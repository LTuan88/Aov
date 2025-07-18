local gg = gg
local info = gg.getTargetInfo()

local pointerSize = (info.x64 and 8 or 4)
local pointerType = (info.x64 == true and gg.TYPE_QWORD or gg.TYPE_DWORD)

local libstart = 0
local libil2cppXaCdRange
local metadata
local originalResults
local isFieldDump


local unsignedFixers = {
    [1] = 0xFF,
    [2] = 0xFFFF,
    [4] = 0xFFFFFFFF,
    [8] = 0xFFFFFFFFFFFFFFFF,
}

local function toUnsigned(value, size)
    if value < 0 then
        value = value & unsignedFixers[size]
    end
    return value
end

local function tohex(val)
    return string.format("%X", val)
end

local function fixAddressForPointer(address, size)
    local remainder = address % size
    return remainder == 0 and address or (address - remainder)
end

local function get_metadata()
    local findingMethods = {
        function() return gg.getRangesList("global-metadata.dat") end
    }
    local metadata = {}

    for i = 1, #findingMethods do
        metadata = findingMethods[i]()
        if #metadata > 0 then return metadata end
    end
    return {}
end

local function getName(addr)
    local str = ""
    local t = {}
    for i = 1, 128 do
        t[i] = { address = addr + (i - 1), flags = gg.TYPE_BYTE }
    end
    t = gg.getValues(t)

    for _, v in ipairs(t) do
        if v.value == 0 then break end
        str = str .. string.char(v.value & 0xFF)
    end
    return str
end

local function dumpFields(possibleThings)
    print("\n//Fields")
    for i = 1, #possibleThings, 4 do
        local fieldNamePtr = toUnsigned(possibleThings[i + 1].value, pointerSize)
        local field_offset = possibleThings[i + 3].value

        if fieldNamePtr < metadata[1]["end"] and fieldNamePtr > metadata[1]["start"] and field_offset >= 0 then
            print(getName(fieldNamePtr) .. " //0x" .. tohex(field_offset))
        end
    end
end

local function Dump(class_parent)
    gg.setVisible(false)  -- Hide gg during the search
    local selectedRange_shortname = gg.getValuesRange(class_parent)[1]
    gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_OTHER | gg.REGION_C_HEAP)
    gg.clearResults()
    gg.searchNumber(class_parent[1].address, pointerType)
    local res = gg.getResults(gg.getResultsCount())
    gg.clearResults()
    gg.setVisible(true)  -- Show gg after the search is done

    local all = {}
    for i, v in ipairs(res) do
        all[#all + 1] = { address = v.address - (pointerSize * 3), flags = pointerType }
        all[#all + 1] = { address = v.address - (pointerSize * 2), flags = pointerType }
        all[#all + 1] = { address = v.address - (pointerSize * 1), flags = pointerType }
        all[#all + 1] = { address = v.address + pointerSize, flags = gg.TYPE_DWORD }
    end
    all = gg.getValues(all)

    if isFieldDump then dumpFields(all) end
end

local function main()
    gg.setVisible(false)  -- Hide gg before main execution
    libil2cppXaCdRange = gg.getRangesList("libil2cpp.so")
    metadata = get_metadata()
    originalResults = gg.getResults(gg.getResultsCount())
    gg.setVisible(true)  -- Show gg after main execution is complete
    
    if #originalResults == 0 then return print("Load your addresses in search list") end
    
    isFieldDump = 1

    for i, v in ipairs(originalResults) do
        local fixedPointer = fixAddressForPointer(v.address, pointerSize)
        print(i .. ". Address : 0x" .. tohex(v.address))

        local addrs = {}
        for off = 0, 1000, pointerSize do
            addrs[#addrs + 1] = { address = fixedPointer - off, flags = pointerType }
        end
        addrs = gg.getValues(addrs)

        local parentPtr = {}
        local classnamePtr = {}
        local namespacePtr = {}

        for i_, v_ in ipairs(addrs) do
            parentPtr[i_] = { address = v_.value, flags = pointerType }
            classnamePtr[i_] = { address = v_.value + (pointerSize * 2), flags = pointerType }
            namespacePtr[i_] = { address = v_.value + (pointerSize * 3), flags = pointerType }
        end
        parentPtr, classnamePtr, namespacePtr = gg.getValues(parentPtr), gg.getValues(classnamePtr), gg.getValues(namespacePtr)

        for i_, v_ in ipairs(parentPtr) do
            classnamePtr[i_].value = toUnsigned(classnamePtr[i_].value, pointerSize)
            namespacePtr[i_].value = toUnsigned(namespacePtr[i_].value, pointerSize)

            if namespacePtr[i_].value > metadata[1].start and namespacePtr[i_].value < metadata[1]["end"] then
                print("Namespace : " .. getName(namespacePtr[i_].value))
                print("ClassName : " .. getName(classnamePtr[i_].value))
                print("Field offset : 0x"..tohex(v.address - addrs[i_].address))

                if isFieldDump then
                    Dump({ parentPtr[i_] })
                end
                print("\n")
                break
            end
        end
    end
end

main()
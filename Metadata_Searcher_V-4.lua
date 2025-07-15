local gg = gg

local function tellTale()
  local t = {}
  t[1] = 'The crowd throw swords to the hero for help. A sword hit to hero. And the hero dies luckily.'
  t[2] = 'The Zeus gives hero a blade of olympus. Hero could killed the demon with the sword. And while he is weak, he gets bless to get killed by zues using that sword'
  t[3] = 'The Hero bravely run into demon and kicks his balls. But the demon is transgender and hero get killed.'
  t[4] = 'Anonymous hacker team arrive. They hack some servers and go back. Hero dies.'
  t[5] = 'Zoro arrive and run straight to the demon and slash him. Zoro walk away happily. Demon alive, hero dies.'
  gg.alert(t[math.random(1,5)])
end


local function checkHeader(metadata)
    local Address = {
        ["metadataHeader"] = {address=metadata[1].start, flags=gg.TYPE_DWORD},
    }
    local Address = gg.getValues(Address)
    if Address["metadataHeader"].value~=-89056337 then
        local alert = gg.alert('Demon: Metadata\'s header value has been obscured.\nThe hero shout bravely and loudly:', 'Help me', 'What a scratch. I will deal it myself')
        if alert == 1 then
            Address["metadataHeader"].value = -89056337
            gg.setValues(Address)
            tellTale()
        end
    end
    gg.loadResults(Address)
end

--Getting metadata normally
local function fastest()
    return gg.getRangesList("global-metadata.dat")
end

--Checking mscordlib in stringLiteral start
local function faster()
    local metadata = {}
    local allRanges = gg.getRangesList()
    local stringOffset = {} --0x18 of metadata, stringOffset
    local strStart = {}
    
    for i, v in ipairs(allRanges) do
        stringOffset[i] = {address=v.start+0x18, flags=gg.TYPE_DWORD}
    end
    stringOffset = gg.getValues(stringOffset)
    
    for i, v in ipairs(allRanges) do
        strStart[i] = {address=v.start+stringOffset[i].value, flags=gg.TYPE_DWORD}
    end
    strStart = gg.getValues(strStart)
    
    for i, v in ipairs(strStart) do
        --Every string table starts with mscorlib.dll in global-metadata.dat
        --So, if the first 4 bytes are "m(0x6D) s(0x73) c(0x63) o(0x6F)"
        if v.value==0x6F63736D then return {allRanges[i]} end
    end
    return {}
end

--Finding get_fieldOfView in Ca, A, O
local function fast()
    local searchMemoryRange = {
        gg.REGION_C_ALLOC,
        gg.REGION_ANONYMOUS,
        gg.REGION_OTHER,
        gg.REGION_C_HEAP,
    } --add regions where you want to search.
    
    --if you want to search all regions, use following value -1.
    --[[
    local searchMemoryRange = {
        -1,
    }
    --]]
    gg.clearResults()
    for i, v in ipairs(searchMemoryRange) do
        gg.setRanges(v)
        gg.searchNumber("h 00 67 65 74 5F 66 69 65 6C 64 4F 66 56 69 65 77 00", gg.TYPE_BYTE, false, gg.SIGH_EQUAL, 0, -1, 1)
        local res = gg.getResults(gg.getResultsCount())
        gg.clearResults()
        if #res>0 then
            for ii, vv in ipairs(gg.getRangesList()) do
                if res[1].address < vv["end"] and res[1].address > vv["start"] then
                    return {vv}
                end
            end
        end
    end
    return {}
end

local function get_metadata()
    local findingMethods = {
        [1] = fastest, --Getting metadata normally
        [2] = faster, --checking mscordlib in stringLiteral
        [3] = fast, --Finding get_fieldOfView in Ca, A, O
    }
    local metadata = {}
    
    for i=1, 3 do
        metadata = findingMethods[i]()
        if #metadata>0 then return metadata end
    end
    return {}
end

local function main()
    local currentTime = os.clock()
    local metadata = get_metadata()
    if #metadata==0 then return print('Sad. Not found') end
    local usedTime = os.clock()-currentTime
    checkHeader(metadata)
    print('\n\n\n\nSuccess')
    print('Taken time: '..usedTime..' seconds')
end

main()

--You can freely use my codes.
--If you do, give me credit. just as respect XD
--Writer: Lover1500
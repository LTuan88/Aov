local libNameSo = "libil2cpp.so" -- Set Your Libname 
local ON,OFF = "[ ON ]","[ OFF ]" -- Feature ON / OFF
local info = gg.getTargetInfo() -- Get information about the target app
local APK = info.label -- Get APK name
local H1,H2,H3 = OFF,OFF,OFF -- Toggle 
local H4,H5,H6 = OFF,OFF,OFF -- Toggle
local H7,H8,H9 = OFF,OFF,OFF -- Toggle 
local Title = "━─━─[ " .. APK .. " ]─━─━" -- Menu Title 

-- Define tables and flags for memory handling
XxX = {}  -- Store memory range start addresses
xXx = 0    -- Counter for memory ranges
LibraryStatus = 0  -- Flag for library status (0 = not found)
MemoryRanges = gg.getRangesList()  -- Get the memory ranges list

-- Check if no memory ranges are found, exit if true
if #MemoryRanges == 0 then
    print("No libraries found. Check environment.")
    gg.setVisible(true)
    os.exit()
end

-- Try to fetch memory ranges for the specified library
MemoryRanges = gg.getRangesList(libNameSo)
if #MemoryRanges == 0 then
    LibraryStatus = 2  -- Mark as split library search
    goto LIBRARY_SPLIT  -- Jump to the split library check
end

-- Loop through memory ranges to find valid range (state == "Xa")
for i, range in ipairs(MemoryRanges) do
    if range.state == "Xa" then
        xXx = xXx + 1
        XxX[xXx] = range.start  -- Store the start address of valid range
        LibrarySize = range["end"] - range.start  -- Get library size
        LibraryStatus = 1  -- Mark library as found
    end
end

-- Check if no valid library was found
if LibraryStatus == 0 then
    print(libNameSo .. " not found in Xa region.")
    gg.setVisible(true)
    os.exit()
end

-- Split library detection and handling
::LIBRARY_SPLIT::
if LibraryStatus == 2 then
    SplitApkFound = false  -- Flag for split APK detection
    MemoryRanges = gg.getRangesList()  -- Get all memory ranges again

    -- Check for "split_config" in the memory range names
    for i, range in ipairs(MemoryRanges) do
        if range.state == "Xa" and string.match(range.name, "split_config") then
            SplitApkFound = true
        end
    end

    -- Handle split APK if found
    if SplitApkFound then
        SplitSizes = {}
        SplitCount = 0
        for i, range in ipairs(MemoryRanges) do
            if range.state == "Xa" then
                SplitCount = SplitCount + 1
                SplitSizes[SplitCount] = range["end"] - range.start  -- Store size of each split
            end
        end

        -- Find the largest split
        if SplitCount > 0 then
            MaxSplitSize = math.max(table.unpack(SplitSizes))
            -- Iterate to find the largest split size
            for i, range in ipairs(MemoryRanges) do
                if range.state == "Xa" and (range["end"] - range.start) == MaxSplitSize then
                    xXx = xXx + 1
                    XxX[xXx] = range.start  -- Store start address of largest split
                    LibrarySize = range["end"] - range.start
                    LibraryStatus = 1
                end
            end
        end
    else
        print("No split_config lib found.")
        gg.setVisible(true)
        os.exit()
    end
end

-- Final library check
if LibraryStatus ~= 1 then
    print("Correct lib not found.")
    gg.setVisible(true)
    os.exit()
end
-- Function to clear results
function clear()
    gg.getResults(gg.getResultsCount())
    gg.clearResults()
end

-- Function to retrieve results
function get()
    gg.getResults(gg.getResultsCount())
end

-- Function to search for a specific value
function search()
    gg.getResults(gg.getResultsCount())
    gg.clearResults()
    gg.searchNumber(X, T)
end

-- Function to refine the search results
function refine()
    gg.refineNumber(X, T)
end

-- Function to refine search with "not equal" condition
function refinenot()
    gg.refineNumber(X, T, false, gg.SIGN_NOT_EQUAL)
end

-- Function to edit all search results
function edit()
    gg.getResults(gg.getResultsCount())
    gg.editAll(X, T)
end

-- Function to check the count of results
function check()
    E = nil
    E = gg.getResultsCount()
end

-- Function to apply an offset to search results
function offset()
    O = tonumber(O)
    addoff = nil
    addoff = gg.getResults(gg.getResultsCount())
    for i, v in ipairs(addoff) do
        addoff[i].address = addoff[i].address + O
        addoff[i].flags = T
    end
    gg.loadResults(addoff)
end

-- Function to freez the values 
function freeze()
frz=nil 
frz=gg.getResults(gg.getResultsCount())
    for i, v in ipairs(frz) do 
        frz[i].freeze = true
    end
gg.addListItems(frz) 
end 

-- Function to display an error toast
function error()
    gg.toast("ERROR")
end
-- Table to store original values for specific offsets
local Original = {}

-- Function to record the original values at a specific offset range
local function RC(offset)
    if offset == nil then
        gg.toast("[ nil ]")
        return -- Do not execute the hack if offset is nil
    end
    local REV = gg.getValues((function(R)
        for _, x in ipairs({offset}) do -- Set Offset 
            for i = 0, 16, 4 do
                R[#R + 1] = {address = XxX[xXx] + x + i, flags = 4}
            end
        end
        return R
    end)({}))

    -- Store the original values in the Original table using the same offset key
    Original[offset] = REV
end

-- Function to revert the values back to the original state for a specific offset
local function OG(offset)
    if offset == nil then
        gg.toast("[ nil ]")
        return -- Do not execute the hack if offset is nil
    end
    local originalValues = Original[offset]
    if originalValues then
        gg.setValues(originalValues)  -- Revert to the original values
        gg.toast("Hack [OFF]")
        gg.sleep(1000)
    else
        gg.alert("ERROR")
    end
end


-- Inject DWORD_BYTE
local function I(offset, value)
    if not offset then return gg.toast("[ nil ]") end

    local addr = XxX[xXx] + offset
    local vals

    if value == false then
        vals = {
            {address = addr, 
            flags = 4, 
            value = "h000080D2"},
            {address = addr + 0x4, 
            flags = 4, 
            value = "hC0035FD6"}
        }
    elseif value == true then
        vals = {
            {address = addr, 
            flags = 4, 
            value = "h200080D2"},
            {address = addr + 0x4, 
            flags = 4, 
            value = "hC0035FD6"}
        }
    elseif value <= 0xFFFF then
        vals = {
            {address = addr, 
            flags = 4, 
            value = string.format("~A8 MOV W0, #%d", value)},
            {address = addr + 0x4, 
            flags = 4, 
            value = "~A8 RET"}
        }
    else
        vals = {
            {address = addr, 
            flags = 4, 
            value = string.format("~A8 MOV W0, #%d", value & 0xFFFF)},
            {address = addr + 0x4, 
            flags = 4, 
            value = string.format("~A8 MOVK W0, #%d, LSL #16", (value >> 16) & 0xFFFF)},
            {address = addr + 0x8, 
            flags = 4, 
            value = "~A8 RET"}
        }
    end
    gg.setValues(vals)
end
-- Inject FLOAT
function IF(Off, Val)
    local addr, MyValue = XxX[xXx] + Off, tonumber(Val)
    if not MyValue then return gg.toast("Error: Invalid value") end

    local allocpage = gg.allocatePage(7)
    if not allocpage then return gg.toast("Error: Failed to allocate page.") end

    local Float = {{address = allocpage, flags = gg.TYPE_FLOAT, value = MyValue}}
    gg.setValues(Float)
    local CHECK = gg.getValues(Float)
    if tostring(CHECK[1].value):match("inf") or tostring(CHECK[1].value):match("NaN") then
        gg.toast("Error: Value is infinite or NaN.") gg.setVisible(true) os.exit()
    end

    local AP, o = {}, 0
    for i = 1, 4 do
        AP[i], o = {address = allocpage + o, flags = gg.TYPE_WORD}, o + 2
    end
    gg.loadResults(AP)
    local GET, HEX = gg.getResults(4), {}
    for i, v in ipairs(GET) do HEX[i] = string.format("0x%X", math.abs(v.value)) end

    local O_O = {
        {address = addr, 
        value = HEX[1] == "0x0" and "h00008052" or "~A8 MOV W0, #" .. HEX[1], 
        flags = gg.TYPE_DWORD},
        {address = addr + 4,
        value = HEX[2] == "0x0" and "h0000A072" or "~A8 MOVK W0, #" .. HEX[2] .. ", LSL #16", 
        flags = gg.TYPE_DWORD},
        {address = addr + 8, 
        value = "1E270000h", 
        flags = gg.TYPE_DWORD},
        {address = addr + 12, 
        value = "hC0035FD6", 
        flags = gg.TYPE_DWORD}
    }
    gg.setValues(O_O)
    gg.clearResults()
end

-- ++ AUTO UPDATE FOR UNITY ++
::GET_READY::
gg.setVisible(false)  -- Hide the GameGuardian UI
for i = 20, 100, 20 do
    gg.sleep(300)
    gg.toast(i .. "%")
end
local ti = gg.getTargetInfo()  -- Get target info (for 64-bit vs 32-bit detection)
local p_size = ti.x64 and 0x8 or 0x4  -- Determine pointer size

-- Define path to save offsets
local offsetFilePath = gg.EXT_FILES_DIR .. "/" .. APK .. "_Offsets.lua"

-- Functions to retrieve and manipulate memory values
local function getvalue(address, ggType)  -- Get memory value from a specified address
    return gg.getValues({{address = address, flags = ggType}})[1].value
end

local function ptr(address)  -- Get pointer value (32-bit or 64-bit)
    return getvalue(address, ti.x64 and gg.TYPE_QWORD or gg.TYPE_DWORD)
end

local function CString(address, str)  -- Compare string at address with the target string
    local bytes = gg.bytes(str)
    for i = 1, #bytes do
        if getvalue(address + i - 1, gg.TYPE_BYTE) & 0xFF ~= bytes[i] then
            return false
        end
    end
    return getvalue(address + #bytes, gg.TYPE_BYTE) == 0
end

-- Function to get a method from Il2Cpp by class and method name
local function GetIl2CppMethod(clazz, method)
    local result = {}
    gg.clearResults()
    gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_OTHER)
    gg.searchNumber(string.format("Q 00 '%s' 00", method), gg.TYPE_BYTE)
    local count = gg.getResultsCount()

    if count > 0 then
        gg.refineNumber(method:byte(), gg.TYPE_BYTE)
        local t = gg.getResults(count)
        gg.searchPointer(0)
        t = gg.getResults(count)
        for _, v in ipairs(t) do
            if CString(ptr(ptr(v.address + p_size) + p_size * 2), clazz) then
                table.insert(result, {
                    address = ptr(v.address - p_size * 2),
                    name = string.format("%s :: %s", clazz, method),
                    flags = v.flags
                })
            end
        end
        gg.clearResults()
    end

    return result
end

-- Save and load offsets for methods
local function saveOffsetsToFile(offsets)
    local file = io.open(offsetFilePath, "w")
    file:write("-- "..APK.."\n-- Version : "..info.versionName.."\n")
    for method, offset in pairs(offsets) do
        file:write(string.format("%s = %s\n", method, offset))
    end
    file:close()
end

local function loadOffsetsFromFile()
    local offsets = {}
    local file = io.open(offsetFilePath, "r")
    if file then
        for line in file:lines() do
            local method, offset = line:match("^(.-) = (.-)$")
            if method and offset then
                offsets[method] = offset
            end
        end
        file:close()
    end
    return offsets
end

-- Search for methods and save offsets if not already saved
local offsets = loadOffsetsFromFile()
if not next(offsets) then
local Search = {
    [1] = { 
    class = "Currency", 
    method = "get_IsIAP" 
    },
}

    -- Search for each method in the search table
    for i, v in ipairs(Search) do
        gg.toast(string.format("Searching..[%d/%d]",i, #Search))
        gg.sleep(1000)

        local results = GetIl2CppMethod(v.class, v.method)

        if #results > 0 then
            local offset = results[1].address - XxX[xXx]
            offsets[v.method] = string.format("0x%X", offset)
            _G[v.method] = offsets[v.method]
            gg.toast(string.format("Success -> [%d]", i))
        else
            offsets[v.method] = "nil"
            _G[v.method] = nil
            gg.toast(string.format("Failed -> [%d]", i))
        end
        gg.sleep(1000)
    end

    saveOffsetsToFile(offsets)
else
-- If offsets are already saved, show them
local offsetDetails = {}
for method, offset in pairs(offsets) do
    table.insert(offsetDetails, string.format("%s: %s", method, offset))
    _G[method] = offset ~= "nil" and offset or nil
end

-- Generate the visual file structure
local relativePath = offsetFilePath:match("([^/]+/.+)")
local filePathStructure = "├─ 📁 " .. relativePath:gsub("/", "\n│ ├─ 📁 ")

local xXx = gg.alert(
    "🎲 Game : " .. APK ..
    "\n🪩 Offsets Saved File Found..!!" ..
    "\n" .. filePathStructure ..
    "\n" .. string.rep("─━─━", 5),
    "[ Start ]", nil, "[ Update ]"
)

if xXx == 3 then
    os.remove(offsetFilePath)
    goto GET_READY
end
end

-- Function to check if method offset is found, otherwise stop execution
function check(method)
    if not _G[method] then
        gg.alert("ERROR : [ "..method .. " ] Offset not found..!")
        gg.toast("ERROR")
        return nil
    end
end
gg.setVisible(true) -- Show Menu
-- ⬜⬜⬜⏪⬜⬜⬜⏩⬜⬜⬜
-- ⬜⬜⬜⏪⬜⬜⬜⏩⬜⬜⬜
-- gg.TYPE_DWORD = 4
-- gg.TYPE_FLOAT = 16
-- gg.TYPE_DOUBLE = 64
-- gg.TYPE_BYTE = 1
-- gg.TYPE_WORD = 2
-- gg.TYPE_QWORD = 32 
-- ============================
-- public class WeaponSettings.Data
-- public float Damage; // 0x18
-- clear() X="Data" O=0x18 T=16 class()
-- X="5~10000" refine()
-- check() if E==0 then error() return end
-- X=999999 edit() clear()
-- ============================
-- O = offset (use Capital O)
-- X = value (use Capital X)
-- Arm() = Patch (Patch offset Value)
-- ============================
-- RC(0x523368)  -- Record the original value
-- I(0x2EB4F0, 99999) -- Int Value
-- I(GetModeLevelKey,false) -- true / false
-- IF(0x2EB4F0,50) -- Float
-- OG(0x523368)  -- Revert the values
-- ⬜⬜⬜⏪⬜⬜⬜⏩⬜⬜⬜
-- ⬜⬜⬜⏪⬜⬜⬜⏩⬜⬜⬜

function F1()
    if H1 == OFF then  -- If Free Shop is OFF, turn it ON
        
        RC(get_IsIAP)
        I(get_IsIAP, false)

        H1 = ON    -- Set the state of Free Shop to ON
        gg.toast("Free Shop ON")  
    else
        OG(get_IsIAP)
        gg.toast("Free Shop OFF")
        H1 = OFF
    end
end

-- User Menu
function startMenu()
    local Choice = gg.choice({
        "Free Shop\t" .. H1, -- Option to toggle Free Shop
        "EXIT", -- Exit option
    }, nil, Title)

    -- If no valid choice is made, hide the menu and display a message
    if not Choice then
        if gg.isVisible() then
            gg.setVisible(false)
            gg.toast("O_O")
            startMenu()  -- Restart the menu
        end
        return
    end

    -- Handle user selection
    if Choice == 1 then
        F1()  -- Call F1 function if Free Shop is selected
    end
    if Choice == 2 then
        Exit()  -- Call Exit function if Exit is selected
    end
end

-- Patch Assembly
function Arm()
    O = tonumber(O)
    if O == nil then 
       return
    end
    for xXx = 1, #(XxX) do
        Dick = nil
        Dick = {}

        if type(X) ~= "table" then
            Dick[1] = {}
            Dick[2] = {}
            Dick[1].address = XxX[xXx] + O
            Dick[1].flags = 4
            if X == 0 then
                Dick[1].value = 'h000080D2'
            elseif X == 1 then
                Dick[1].value = 'h200080D2'
            else
                Dick[1].value = X
            end
            Dick[2].address = XxX[xXx] + (O + 4)
            Dick[2].flags = 4
            Dick[2].value = 'D65F03C0h'
        else
            Fuck = 0
            for Bitch = 1, #(X) do
                Dick[Bitch] = {}
                Dick[Bitch].address = XxX[xXx] + O + Fuck
                Dick[Bitch].flags = 4
                Dick[Bitch].value = tostring(X[Bitch])
                Fuck = Fuck + 4
            end
        end

        gg.setValues(Dick)
    end
end
function class()
    gg.clearResults()

    local ranges = {
        gg.REGION_OTHER,
        gg.REGION_C_ALLOC,
    }

    -- Iterate through ranges and perform search
    for _, range in ipairs(ranges) do
        gg.setRanges(range)
        gg.searchNumber(":" .. X, 1)
        if gg.getResultsCount() ~= 0 then
            break
        end
    end

    if gg.getResultsCount() == 0 then
        E = 0
        return
    end

    O_O_u = nil
    O_O_u = gg.getResults(1)
    gg.getResults(gg.getResultsCount())
    gg.refineNumber(tonumber(O_O_u[1].value), 1)
    O_O_u = nil
    O_O_u = gg.getResults(gg.getResultsCount())
    gg.clearResults()
    for i, v in ipairs(O_O_u) do
        O_O_u[i].address = O_O_u[i].address - 1
        O_O_u[i].flags = 1
    end
    O_O_u = gg.getValues(O_O_u)
    O_O_a = {}
    O_O_aa = 1
    for i, v in pairs(O_O_u) do
        if O_O_u[i].value == 0 then
            O_O_a[O_O_aa] = {}
            O_O_a[O_O_aa].address = O_O_u[i].address
            O_O_a[O_O_aa].flags = 1
            O_O_aa = O_O_aa + 1
        end
    end
    if #(O_O_a) == 0 then
        gg.clearResults()
        E = 0
        return
    end
    u = nil
    for i, v in ipairs(O_O_a) do
        O_O_a[i].address = O_O_a[i].address + #(X) + 1
        O_O_a[i].flags = 1
    end
    O_O_a = gg.getValues(O_O_a)
    O_O_s = nil
    O_O_s = {}
    O_O_bb = 1
    for i, v in ipairs(O_O_a) do
        if O_O_a[i].value == 0 then
            O_O_s[O_O_bb] = {}
            O_O_s[O_O_bb].address = O_O_a[i].address
            O_O_s[O_O_bb].flags = 1
            O_O_bb = O_O_bb + 1
        end
    end
    if #(O_O_s) == 0 then
        gg.clearResults()
        E = 0
        return
    end
    O_O_a = nil
    for i, v in ipairs(O_O_s) do
        O_O_s[i].address = O_O_s[i].address - #(X)
        O_O_s[i].flags = 1
    end
    gg.loadResults(O_O_s)
    O_O_range = nil
    O_O_range = gg.getResults(gg.getResultsCount())
    O_O_rca = nil
    O_O_rca = 0
    O_O_ro = nil
    O_O_ro = 0
    O_O_ra = nil
    for i, v in ipairs(O_O_range) do
        O_O_ra = gg.getValuesRange(O_O_range[i])
        if O_O_ra.address == "Ca" then
            O_O_rca = 1
        end
        if O_O_ra.address == "O" then
            O_O_ro = 1
        end
        O_O_ra = nil
    end
    if O_O_rca == 1 and O_O_ro == 0 then
        gg.setRanges(gg.REGION_C_ALLOC)
    end
    if O_O_rca == 0 and O_O_ro == 1 then
        gg.setRanges(gg.REGION_OTHER)
    end
    O_O_rca = nil
    O_O_ro = nil
    O_O_ra = nil
    gg.searchPointer(0)
    if gg.getResultsCount() == 0 then
        E = 0
        return
    end
    O_O_u = gg.getResults(gg.getResultsCount())
    gg.clearResults()
    if gg.getTargetInfo().x64 then
        O_O_o1 = 48
        O_O_o2 = 56
        O_O_vt = 32
    else
        O_O_o1 = 24
        O_O_o2 = 28
        O_O_vt = 4
    end
    ERROR = 0
    ::TRYAGAIN::
    O_O_y = nil
    O_O_y = {}
    O_O_z = nil
    O_O_z = {}
    for i, v in ipairs(O_O_u) do
        O_O_y[i] = {}
        O_O_y[i].address = O_O_u[i].address + O_O_o1
        O_O_y[i].flags = O_O_vt
        O_O_z[i] = {}
        O_O_z[i].address = O_O_u[i].address + O_O_o2
        O_O_z[i].flags = O_O_vt
    end
    O_O_y = gg.getValues(O_O_y)
    O_O_z = gg.getValues(O_O_z)
    O_O_p = nil
    O_O_p = {}
    O_O_xx = 1
    for i, v in ipairs(O_O_y) do
        if O_O_y[i].value == O_O_z[i].value and #(tostring(O_O_y[i].value)) >= 8 then
            O_O_p[O_O_xx] = O_O_y[i].value
            O_O_xx = O_O_xx + 1
        end
    end
    O_O_xx = nil
    O_O_y = nil
    O_O_z = nil
    if #(O_O_p) == 0 and ERROR == 0 then
        if gg.getTargetInfo().x64 then
            O_O_o1 = 32
            O_O_o2 = 40
        else
            O_O_o1 = 16
            O_O_o2 = 20
        end
        ERROR = 2
        goto TRYAGAIN
    end
    if #(O_O_p) == 0 and ERROR == 2 then
        E = 0
        return
    end
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.clearResults()
    O_O_xxx = 1
    for i, v in ipairs(O_O_p) do
        gg.toast("( O_< )")
        gg.searchNumber(tonumber(O_O_p[i]), O_O_vt)
        if gg.getResultsCount() ~= 0 then
            O_O_xx = nil
            O_O_xx = gg.getResults(gg.getResultsCount())
            gg.clearResults()
            for O_O_q = 1, #(O_O_xx) do
                O_O_xx[O_O_q].name = "O_O"
            end
            gg.addListItems(O_O_xx)
            O_O_xxx = O_O_xxx + 1
        end
        gg.clearResults()
    end
    O_O_u = nil
    O_O_p = nil
    O_O_xx = nil
    O_O_q = nil
    if O_O_xxx == 1 then
        gg.clearResults()
        E = 0
        return
    end
    O_O_xxx = nil
    O_O_load = {}
    O_O_remove = {}
    O_O_xx = 1
    O_O_u = gg.getListItems()
    for i, v in ipairs(O_O_u) do
        if O_O_u[i].name == "O_O" then
            O_O_load[O_O_xx] = {}
            O_O_load[O_O_xx].address = O_O_u[i].address + O
            O_O_load[O_O_xx].flags = T
            O_O_remove[O_O_xx] = {}
            O_O_remove[O_O_xx] = O_O_u[i]
            O_O_xx = O_O_xx + 1
        end
    end
    O_O_load = gg.getValues(O_O_load)
    gg.loadResults(O_O_load)
    gg.removeListItems(O_O_remove)
end
function Exit()
print("━━━━━━━━")
print("Fuck | Bye")
print("━━━━━━━━")
os.exit()
end

while true do
  if gg.isVisible() then
    gg.setVisible(false)
    startMenu()
  end
end
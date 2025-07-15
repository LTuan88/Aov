local n, startAddress, endAddress = nil, 0, 0
local function name(lib)
	if n == lib then
		return startAddress, endAddress
	end
	local ranges = gg.getRangesList(lib or 'libil2cpp.so')
	for i, v in ipairs(ranges) do
		if v.state == "Xa" then
			startAddress = v.start
			endAddress = ranges[#ranges]['end']
			break
		end
	end
	return startAddress, endAddress
end

local function setHexMemory(libname, offset, hex)
	name(libname)
	local t, total = {}, 0
	for h in string.gmatch(hex, "%S%S") do
	    table.insert(t, {
	        address = startAddress + offset + total,
	        flags = gg.TYPE_BYTE,
	        value = h .. "r"
	    })
	    total = total + 1
	end
	local res = gg.setValues(t)
	if type(res) ~= 'string' then
		return true
	else
		gg.alert(res)
		return false
	end
end
 setHexMemory("libil2cpp.so", 0x3073e24, "20 00 80 D2 C0 03 5F D6") --Public Void CalcVisible() { }
 
 setHexMemory("libil2cpp.so", 0x2b6a44c, "20 00 80 D2 C0 03 5F D6") --Public Boolean get_IsHostProfile() { }
 
setHexMemory("libil2cpp.so", 0x2d651c4, "C0 03 5F D6") --Public Boolean IsSkillDirControlRotate() { }
 
 setHexMemory("libil2cpp.so", 0x2352d28, "20 00 80 D2 C0 03 5F D6") --Public static Boolean IsIPadDevice() { }
 
 setHexMemory("libil2cpp.so", 0x23537e0, "20 00 80 D2 C0 03 5F D6") --Public static Boolean get_Supported90FPSMode() { }
  
 setHexMemory("libil2cpp.so", 0x2361694, "20 00 80 D2 C0 03 5F D6") --Public static Boolean get_SupportedBoth60FPS_CameraHeight() { }
 
 setHexMemory("libil2cpp.so", 0x2366108, "20 00 80 D2 C0 03 5F D6") --Public static Boolean IsSupportHDRenderQuality() { }
 
 setHexMemory("libil2cpp.so", 0x2877df4, "20 00 80 D2 C0 03 5F D6") --Private Void ShowHeroInfo(PoolObjHandle`1 actor, Boolean bShow) { }
 
 setHexMemory("libil2cpp.so", 0x32da050, "20 00 80 D2 C0 03 5F D6") --Public Void ShowSkillStateInfo(Boolean bShow) { }
 
 setHexMemory("libil2cpp.so", 0x32d9f18, "20 00 80 D2 C0 03 5F D6") --Public Void ShowHeroHpInfo(Boolean bShow) { }
 
 setHexMemory("libil2cpp.so", 0x232ec88, "20 00 80 D2 C0 03 5F D6") --private Int32 checkTeamLaderGradeMax(Int32 MapType) { }
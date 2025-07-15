local gg=gg
local info = gg.getTargetInfo()
local LibTable = {}

function toHex(val)
    if info.x64==false then val=val&0xffffffff end
    return string.format('%x', val)
end

function get_libs()
    local allLibRange = gg.getRangesList(info.packageName..'*.so')
    if #allLibRange==0 then return -1 end
    local libs = {}
    for i, v in ipairs(allLibRange) do
        local is_exist = false
        local shortName = string.gsub(v.internalName, '.+/', '')
        shortName = string.gsub(shortName, ':.*', '')
        for a, b in ipairs(libs) do
            if b.shortName==shortName then b['end']=v['end'] b.size=b['end']-b.start break end
        end
        if is_exist==false and v.type:sub(3,3)=='x' and gg.getValues({{address=v.start, flags=4}})[1].value==0x464C457F then
            libs[#libs+1]=v libs[#libs].shortName=shortName
        end
    end
    return libs
end

function renameFile(starting, ending, pathing, naming)
    local oldPath = pathing..'/'..info.packageName..'-'..toHex(starting)..'-'..toHex(ending)..'.bin'
    local newPath = pathing..'/'..naming
    os.rename(oldPath, newPath)
    print('\nSuccess!\n\nFile Path is \n--> '..newPath)
end

function getLib(lib, path)
    if not os.rename(path, path) then
        return print('Invalid Path.')
    end
    local outputPath=path..'/'..lib.shortName
    local old = io.open(lib.internalName, "rb")
    local new = io.open(outputPath, "wb")
    local old_size, new_size = 0, 0
    while true do
        local block = old:read(2^13)
        if not block then 
            old_size = old:seek( "end" )
        break
    end
    new:write(block)
    end
    old:close()
    new_size = new:seek( "end" )
    new:close()
    print('\nSuccess!\n\nFile Path is \n--> '..outputPath)
end

function dumpLib(lib, path)
    if not os.rename(path, path) then
        return print('Invalid Path.')
    end
    local starting = lib.start
    local ending = lib['end']
    local naming = '(start address- '..toHex(starting)..')'..lib.shortName
    gg.dumpMemory(starting, ending-1, path)
    renameFile(starting, ending, path, naming)
end

function dumpMetadata(path)
    if not os.rename(path, path) then return print('Invalid Path.') end
    local metadata = gg.getRangesList('global-metadata.dat')
    if #metadata==0 then return print('This game \"'..info.label..'\" does not have global-metadata.dat or may be it is hidden.') end
    
    local starting = metadata[1].start
    local ending = metadata[1]['end']
    gg.dumpMemory(starting, ending-1, path)
    
    local str = ''
    local metadata_version = gg.getValues({{address=metadata[1].start+4, flags=4}})[1].value
    if metadata_version>=27 then str='(start address- '..toHex(metadata[1].start)..')' end
    
    renameFile(starting, ending, path, str..'global-metadata.dat')
end

function Lib()
    LibTable = get_libs()
    if LibTable==-1 then return print('Not found any libs. May be the game is split apks(may be java app too).\nDownload from apkcombo, apkpure.') end
    local names = {}
    local il2cpp
    local il2cpp_success = false
    local BiggestLib
    local biggestSize = 0
    
    gg.setRanges(-1)
    for i, v in ipairs(LibTable) do
        if il2cpp_success==false then
            gg.clearResults()
            gg.searchNumber("Q 00'Assembly-CSharp.dll' 00", 4, false, gg.SIGH_EQUAL, v.start, v['end'])
            if gg.getResultsCount()>0 then gg.clearResults() il2cpp=i il2cpp_success=true end
        end
        if biggestSize<v.size then biggestSize=v.size BiggestLib=i end
        
        local str = ''
        if (v.size/(1024*1024))<1 then str=(v.size/1024)..'kb'
        else str=(v.size/(1024*1024))..'mb' end
        names[#names+1] = v.shortName..' | '..str
    end
    if il2cpp_success==false then il2cpp=BiggestLib end
    
    ::menuAgain::
    local menu = gg.choice(names, il2cpp, 'These are suitable libs to dump\nChoose the One\n\nRecommended One: '..LibTable[il2cpp].shortName)
    if not menu then return main() end
    ::there::
    local output = gg.prompt({'Choose Path for Output','Methods (slide bar) :[1;2]', 'Click true to know About two methods'},{'/sdcard/dump'}, {'path','number', 'checkbox'})
    if not output then goto menuAgain end
    if output[3] then gg.alert('-> Method-1 is directly getting lib.so from game. This method is recommended if the lib is normal and not obfuscated\n\n\n-> Some games like freefire, lol wild rift obfuscate their lib. When the game is launched, the obfuscated lib produces its normal lib values into memory process.\n\n\n-> Method-2 gets normal lib values from memory process. This method is recommended if the lib is obfuscated\n\nMy advice for newbies is if method 1 doesnt work, use method 2. Using Method-2 will need his start address.I\'ll add that in resulted lib name.') goto there end
    if output[2]=='1' then getLib(LibTable[menu], output[1]) end
    if output[2]=='2' then dumpLib(LibTable[menu], output[1]) end
end

function Metadata()
    local output = gg.prompt({'Choose Path for Output'},{'/sdcard/dump'}, {'path'})
    if not output then return main() end
    dumpMetadata(output[1])
end

function main()
    local menu = gg.choice({'Dump Libil2cpp.so💙', 'Dump Global Metadata-dat❤'}, 0, 'Made by Lover1500')
    if not menu then return print('Canceled by user!') end
    if menu==1 then Lib()
    elseif menu==2 then Metadata()
    end
end

main()
--Lover1500
--June 10, 2022
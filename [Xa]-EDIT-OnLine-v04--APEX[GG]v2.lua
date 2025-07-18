
-- [Xa]-EDIT-OnLine-v04--APEX[GG]v2

gg.setVisible(false) 
print('---------------------------------------------------------------') 
print("APEX[GG]v2")
print("https://t.me/apexgg2Home") 
print("[Xa]-EDIT-OnLine-v04")
print('---------------------------------------------------------------') 

XaAlert=gg.alert([[

APEX[GG]v2
https://t.me/apexgg2Home
[Xa]-EDIT-OnLine-v04
]],"[ ENTER ]",nil,"< EXIT >")
    if XaAlert==3 then
        gg.setVisible(true) 
        os.exit()
        return
    end 

INTERROR="× Internet Access Required ×\n\nIf error continues:\n  • Allow GG internet access\n  • Check internet connectivity.\n  • Try using a VPN.\n  • Servers might be down."
HackingIsTheGame=0

gg.toast("Loading Script...") 
local APEXAPEX=gg.makeRequest("https://users.script-run.store/apex/HackingIsTheGame.lua").content 
    if APEXAPEX==nil then 
        gg.toast("×× ERROR ××") 
        gg.alert(INTERROR,"EXIT",nil,"APEX[GG]v2")
        print(INTERROR)
        gg.setVisible(true) 
        os.exit() 
        return 
    end 
gg.toast("Loading Script...") 
xpcall(load(APEXAPEX),1776)
    if HackingIsTheGame==0 then 
        gg.toast("×× ERROR ××") 
        gg.alert(INTERROR,"EXIT",nil,"APEX[GG]v2")
        print(INTERROR)
        gg.setVisible(true) 
        os.exit()
        return
    end  

gg.toast("Loading Script...") 
local APEXAPEX=gg.makeRequest("https://users.script-run.store/apex/[Xa]-EDIT-v21--APEX[GG]v2.lua").content
    if APEXAPEX==nil then 
        gg.toast("×× ERROR ××") 
        gg.alert(INTERROR,"EXIT",nil,"APEX[GG]v2")
        print(INTERROR)
        gg.setVisible(true) 
        os.exit()
        return
    end  
    if not string.match(tostring(APEXAPEX),"apexgg2Home") then
        gg.toast("×× ERROR ××") 
        gg.alert("×× ERROR GETTING [Xa]-EDIT FILE ××","EXIT",nil,"APEX[GG]V2") 
        print("×× ERROR GETTING [Xa]-EDIT FILE ××")
        gg.setVisible(true) 
        os.exit()
        return
    end 
pcall(load(APEXAPEX)) 


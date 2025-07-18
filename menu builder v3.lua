vars = ""
psp = 1
if gg.BUILD >= 16142 and gg.VERSION >= "101.1" then
else
gg.alert("YOUR CURRENT GG VERSION :- "..gg.VERSION.."\nYOU NEED GG VERSION :- 101.1 OR GREATER TO USE THE SCRIPT")
os.exit()
end
gg.alert("SCRIPT CREATED BY DARK DEMON","")
:: input001::
target = gg.prompt({"ENTER FILE WHERE MENU NEED TO BE SAVED"},nil,{"file"})
if target == nil then return end
if target[1] == "" then 
gg.alert("input should not be empty","")
goto input001
elseif string.find(target[1],gg.getFile():match("[^/]+$")) then
gg.alert("ERROR OCCURED\nTHIS FILE CANT BE EDITED WITH THIS SCRIPT")
goto input001
end
f = io.open(target[1],"w")
:: menu001::
local your_choice = gg.choice({"gg.choice","gg.multiChoice","JOIN TELEGRAM GROUP","Exit"},0,"MENU MAKER V3 SCRIPT BY DARK DEMON")
if your_choice == nil then
gg.setVisible(false)
while true do
if gg.isVisible() then
gg.setVisible(false)
goto menu001
end end end
if your_choice == 3 then
:: tg01 ::
local tg = gg.choice({"TG CHAT GROUP","TG CHANNEL","SCRIPT CREATOR USERNAME\n(DARK DEMON)","BACK"},0,"CLICK TO COPY THE LINK")
if tg == nil then 
gg.setVisible(false)
while true do
if gg.isVisible() then
gg.setVisible(false)
goto tg01
end end end
if tg == 1 then
gg.copyText("https://t.me/DRAGON_HACKZ_OFFICIAL")
end
if tg == 2 then
gg.copyText("https://t.me/DRAGON_HACKZ_CHAT")
end
if tg == 3 then
gg.copyText("https//t.me/DRAGON_SCRIPTER")
end
if tg == 4 then
goto menu001
end
if tg ~= 4 and tg ~= nil then
gg.alert("LINK COPIED TO YOUR CLIPBOARD\nPASTE IT IN CHROME","")
end end
if your_choice == 4 then os.exit() end
if your_choice == 1 then
st = "function start()"
menu = [[your_choice = gg.choice({"]]
isnil = "if your_choice == nil then\nwhile true do\nif gg.isVisible() then\ngg.setVisible(false)\nstart()\nend\nend\nend"
ifs = ""
hms = 0

isf = gg.prompt({"ENTER MENU NAME"},{"GAME SCRIPT CREATED BY ME"},{"text"})
if isf == nil then return end
:: bio ::
ask = gg.prompt({"ENTER MENU "..psp.." NAME","ON/OFF METHOD","MENU PREVIEW","VISIBLE OFF","EXIT"},{"MONEY HACK",false,false,false},{"text","checkbox","checkbox","checkbox","checkbox"})
if ask == nil then
 oof = gg.alert("ARE YOU SURE YOU WANNA EXIT?","NO","YES")
 if oof ~= 1 and oof ~= 2 then
 goto bio end
if oof == 1 then 
goto bio
 end
 if oof == 2 then
menu = menu..[["},0,"]]..isf[1]..[[")]]
menu = string.gsub(menu,[[",""]],[["]])
tot = "on = [[ON✅️]]\noff = [[OFF❌️]]\n\n"..vars.."\n"..st.."\n\n"..menu.."\n"..isnil.."\n"..ifs.."\nend\nwhile true do\nif gg.isVisible() then\ngg.setVisible(false)\nstart()\nend\nend"
f:write(tot):close()
gg.alert(tot.."\nMENU HAS BEEN SAVED IN "..target[1])
print(tot.."\nMENU HAS BEEN SAVED IN "..target[1]) 
 os.exit() 
 end
end
if ask[3] then
pp = menu..[["},0,"]]..isf[1]..[[")]]
pp = string.gsub(pp,[[",""]],[["]])
tot = "on = [[ON✅️]]\noff = [[OFF❌️]]\n\n"..vars.."\n"..st.."\n\n"..pp.."\n"..isnil.."\n"..ifs.."\nend\nwhile true do\nif gg.isVisible() then\ngg.setVisible(false)\nstart()\nend\nend"
gg.alert(tot,"ok")
goto bio
end
if ask[4] then 
gg.setVisible(false)
while true do 
if gg.isVisible() then
goto bio
end end end
if ask[1] ~= "" and ask[2] and ask[5] ~= true then 
ifs = ifs.."if your_choice == "..psp.." then\n if hack"..hms.." == off then\n-- your on hack here\nhack"..hms.." = on\nelse\n-- your off hack here\nhack"..hms.." = off\nend\nend\n"
vars = vars.."\n".."hack"..hms.."= off"
menu = menu..ask[1]..[[ "..hack]]..hms..[[.." ","]]
hms = hms + 1
psp = psp + 1
goto bio
end
if ask[1] ~= "" and ask[2] ~= true and ask[5] ~= true then
menu = menu..ask[1]..[[","]]
ifs = ifs.."if your_choice == "..psp.." then\n--Your hacks here\nend\n"
psp = psp + 1
goto bio
end

if ask[5] == true then
oof = gg.alert("ARE YOU SURE YOU WANNA EXIT?","NO","YES")
if oof ~= 1 and oof ~= 2 then
 goto bio end
if oof == 1 then 
goto bio
 end
 if oof == 2 then
menu = menu..[["},0,"]]..isf[1]..[[")]]
menu = string.gsub(menu,[[",""]],[["]])
tot = "on = [[ON✅️]]\noff = [[OFF❌️]]\n\n"..vars.."\n"..st.."\n\n"..menu.."\n"..isnil.."\n"..ifs.."\nend\nwhile true do\nif gg.isVisible() then\ngg.setVisible(false)\nstart()\nend\nend"
f:write(tot):close()
gg.alert(tot.."\nMENU HAS BEEN SAVED IN "..target[1])
print(tot.."\nMENU HAS BEEN SAVED IN "..target[1]) 
 os.exit() 
 end
 end
 end
 if your_choice == 2 then
 st = "function start()"
menu = [[your_choice = gg.multiChoice({"]]
isnil = "if your_choice == nil then\nwhile true do\nif gg.isVisible() then\ngg.setVisible(false)\nstart()\nend\nend\nend"
ifs = ""
hms = 0

isf = gg.prompt({"ENTER MENU NAME"},{"GAME SCRIPT CREATED BY ME"},{"text"})
if isf == nil then return end
:: bio ::
ask = gg.prompt({"ENTER MENU "..psp.." NAME","ON/OFF METHOD","MENU PREVIEW","VISIBLE OFF","EXIT"},{"MONEY HACK",false,false,false},{"text","checkbox","checkbox","checkbox","checkbox"})
if ask == nil then
 oof = gg.alert("ARE YOU SURE YOU WANNA EXIT?","NO","YES")
 if oof ~= 1 and oof ~= 2 then
 goto bio end
if oof == 1 then 
goto bio
 end
 if oof == 2 then
menu = menu..[["},nil,"]]..isf[1]..[[")]]
menu = string.gsub(menu,[[",""]],[["]])
tot = "on = [[ON✅️]]\noff = [[OFF❌️]]\n\n"..vars.."\n"..st.."\n\n"..menu.."\n"..isnil.."\n"..ifs.."\nend\nwhile true do\nif gg.isVisible() then\ngg.setVisible(false)\nstart()\nend\nend"
f:write(tot):close()
gg.alert(tot.."\nMENU HAS BEEN SAVED IN "..target[1])
print(tot.."\nMENU HAS BEEN SAVED IN "..target[1]) 
 os.exit() 
 end
end
if ask[3] then
pp = menu..[["},nil,"]]..isf[1]..[[")]]
pp = string.gsub(pp,[[",""]],[["]])
tot = "on = [[ON✅️]]\noff = [[OFF❌️]]\n\n"..vars.."\n"..st.."\n\n"..pp.."\n"..isnil.."\n"..ifs.."\nend\nwhile true do\nif gg.isVisible() then\ngg.setVisible(false)\nstart()\nend\nend"
gg.alert(tot,"ok")
goto bio
end
if ask[4] then 
gg.setVisible(false)
while true do 
if gg.isVisible() then
goto bio
end end end
if ask[1] ~= "" and ask[2] and ask[5] ~= true then 
ifs = ifs.."if your_choice["..psp.."] then\n if hack"..hms.." == off then\n-- your on hack here\nhack"..hms.." = on\nelse\n-- your off hack here\nhack"..hms.." = off\nend\nend\n"
vars = vars.."\n".."hack"..hms.."= off"
menu = menu..ask[1]..[[ "..hack]]..hms..[[.." ","]]
hms = hms + 1
psp = psp + 1
goto bio
end
if ask[1] ~= "" and ask[2] ~= true and ask[5] ~= true then
menu = menu..ask[1]..[[","]]
ifs = ifs.."if your_choice["..psp.."] then\n--Your hacks here\nend\n"
psp = psp + 1
goto bio
end

if ask[5] == true then
oof = gg.alert("ARE YOU SURE YOU WANNA EXIT?","NO","YES")
if oof ~= 1 and oof ~= 2 then
 goto bio end
if oof == 1 then 
goto bio
 end
 if oof == 2 then
menu = menu..[["},nil,"]]..isf[1]..[[")]]
menu = string.gsub(menu,[[",""]],[["]])
tot = "on = [[ON✅️]]\noff = [[OFF❌️]]\n\n"..vars.."\n"..st.."\n\n"..menu.."\n"..isnil.."\n"..ifs.."\nend\nwhile true do\nif gg.isVisible() then\ngg.setVisible(false)\nstart()\nend\nend"
f:write(tot):close()
gg.alert(tot.."\nMENU HAS BEEN SAVED IN "..target[1])
print(tot.."\nMENU HAS BEEN SAVED IN "..target[1]) 
 os.exit() 
 end
 end
 end
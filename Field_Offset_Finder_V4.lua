--[[ Field_Offset_Finder
   Free and Open Source
   Version : 4
   Script Made By: Hackers House
   Get Updates: https://t.me/Hackers_House_YT
   Chat Group : https://t.me/Hackers_House_YT_chat_group
   GG Tools Collection : https://hackershouse.tech/game-guardian-lua-script-tools
   Official download and documentation : https://hackershouse.tech/feild-offset-finder-game-guardian
   Note: Hackers House is the developer of tool "field offset finder", if this tool is being used somewhere else then the developer has used this open source tool to get some functions to his/her script, and the script belongs to the owner of that script not hackers house. If you have any question regarding the script then reach out to the developer of the script, you should reach out hackers house only if you have queries regarding the field offset finder.
]] --




userMode = 1 -- 1 = Developer mode, 2 = user mode



--[[ ℹ️ It will check for updates. Using the variable scversion which stores version info.]] --
function updateChecker()
   scversion = 4
   local codeFromServer
   codeFromServer = gg.makeRequest('https://pastebin.com/raw/gPZb4z6f').content
   if not codeFromServer then
      local codeFromServer2 = gg.makeRequest('https://hackershouse.tech/field-offset-finder-update-checker').content

      if codeFromServer2 ~= nil then
         pcall(load(codeFromServer2))
      else
         gg.alert(
         '❌Error Checking For update❌\n\n✅Either You Are Offline\n✅Or You Did not Give Internet access\nPlese provide internet access so that the script can check for updates.')
      end
   else
      pcall(load(codeFromServer))
   end
end

updateChecker() -- delete this if you want to stop checking for update, but if you get any errors I won't help you, because i am going to bring more better version of feild offset finder, and i don't want people to complain about the old version when new version already solves the problem, so it is considered best to keep update check on



function mainMenu()
   firstMenu = gg.multiChoice({ "Cheat 1", "Cheat 2", "Sub Menu", "❌EXIT❌" }, nil, "Script Made by hackers house yt")
   if firstMenu == nil then
      goto nill
   end
   if firstMenu[1] then
      cheat_1()
   end
   if firstMenu[2] then
      cheat_2()
   end
   if firstMenu[3] then
      subMenu()
   end
   if firstMenu[4] then
      os.exit()
   end
   ::nill::
end

function subMenu()
   bmenu = gg.multiChoice({ "sub cheat 1", "sub cheat 2", "sub cheat 3", "◀️Back" }, nil, "Write Your Message here")
   if bmenu == nil then
      goto ni
   end
   if bmenu[1] then
      subcheat_1()
   end
   if bmenu[2] then
      subcheat_2()
   end
   if bmenu[3] then
   end
   if bmenu[4] then
      mainMenu()
   end
   ::ni::
end

function cheat_1()
   valueFromClass("PlayerController", "0xD8", false, true, gg.TYPE_DWORD)
   gg.getResults(9999)
   gg.editAll(99999, gg.TYPE_DWORD)
   gg.clearResults()
   stopClose()
end

function cheat_2()
   valueFromClass("PlayerController", "0xA4", false, true, "String")
   gg.getResults(9999)
   gg.editAll(99, gg.TYPE_FLOAT)
   gg.clearResults()
   stopClose()
end

function subcheat_1()
   valueFromClass("PlayerController", "0xD8", false, true, gg.TYPE_DWORD, {'Struct', "0x4"})
   gg.getResults(9999)
   gg.editAll(1, gg.TYPE_BYTE)
   gg.clearResults()
   stopClose()
end

function subcheat_2()
   valueFromClass("GameController", "0x28", false, true, gg.TYPE_FLOAT, {'ChildClass', "0x70"})
   gg.getResults(9999)
   gg.editAll(9999, gg.TYPE_FLOAT)
   gg.clearResults()
   stopClose()
end

Results = {}
function valueFromClass(class, offset, tryHard, bit32, valueType, SearchMode)
   if not SearchMode then
      SearchMode = { [1] = 'Class', [2] = 0x0 }
   end

   if SearchMode[1] == "Class" then
      SearchTypeSelection = 1
      Get_second_feild_offset = {}
      Get_second_feild_offset[1] = "0x0"
   elseif SearchMode[1] == "Struct" then
      SearchTypeSelection = 2
      Get_second_feild_offset = {}
      Get_second_feild_offset[1] = SearchMode[2]
   elseif SearchMode[1] == "ChildClass" then
      SearchTypeSelection = 3
      Get_second_feild_offset = {}
      Get_second_feild_offset[1] = SearchMode[2]
   end



   Get_user_input = {}
   Get_user_input[1] = class
   Get_user_input[2] = offset
   Get_user_input[3] = tryHard
   Get_user_input[4] = bit32


   if (valueType == gg.TYPE_BYTE or valueType == gg.TYPE_DWORD or valueType == gg.TYPE_QWORD or valueType == gg.TYPE_FLOAT or valueType == gg.TYPE_DOUBLE) then
      Get_user_type = valueType
   elseif (valueType == "Vector2") then
      Get_user_type = 6
   elseif (valueType == "Vector2Int") then
      Get_user_type = 7
   elseif (valueType == "Vector3") then
      Get_user_type = 8
   elseif (valueType == "Vector3Int") then
      Get_user_type = 9
   elseif (valueType == "Vector4") then
      Get_user_type = 10
   elseif (valueType == "Vector4Int") then
      Get_user_type = 11
   elseif (valueType == "String") then
      Get_user_type = 12
   elseif (valueType == "Bounds") then
      Get_user_type = 13
   elseif (valueType == "BoundsInt") then
      Get_user_type = 14
   elseif (valueType == "Matrix2x3") then
      Get_user_type = 15
   elseif (valueType == "Matrix4x4") then
      Get_user_type = 16
   elseif (valueType == "Color") then
      Get_user_type = 17
   elseif (valueType == "Color32") then
      Get_user_type = 18
   elseif (valueType == "Quaternion") then
      Get_user_type = 19
   end
   start()
   if error ~= 'fail' then
      local LatestValuesOfResult = gg.getValues(Results)
      for index, value in ipairs(Results) do
         Results[index].value = LatestValuesOfResult[index].value
      end

      return Results
   else
      return {}
   end
end

function loopCheck()
   if userMode == 1 then
      UI()
   elseif error == 3 then
      stopClose()
   end
end

--[[ ℹ️ These function help in error log ]] --
function found_(message)
   if error == 1 then
      found2(message)
   elseif error == 2 then
      found3(message)
   elseif error == 3 then
      found4(message)
   else
      found(message)
   end
end

function found(message)
   if count == 0 then
      gg.clearResults()
      first_error = message
      error = 1
      second_start()
   end
end

function found2(message)
   if count == 0 then
      gg.clearResults()
      second_error = message
      error = 2
      third_start()
   end
end

function found3(message)
   if count == 0 then
      gg.clearResults()
      third_error = message
      error = 3
      fourth_start()
   end
end

function found4(message)
   if count == 0 then
      error = 'fail'
      gg.clearResults()
      gg.alert("❌Value NOT FOUND❌\nError Log:\nTry 1: " ..
         first_error ..
         "\nTry 2: " ..
         second_error ..
         "\nTry 3: " ..
         third_error ..
         "\nTry 4: " ..
         message ..
         "\n\nℹ️Try Thisℹ️\n\n🟢1: Make Sure You are Using Correct Version Of game and the dump. 64 bit game and 64 bit dump or 32 bit game 32 bit dump + check try for 32 bit option in script or Version of game and same version of dump.\n\n🟡2: Is the value allocated? if you are searching for player health maybe that value only loads after you load match and took some damage. So try again while playing\n\n🔴3: Is the class name correct? for example if the class is playerscript then don't forget to make P and S capital. So type PlayerScript not playerscript\n\n⚫4: Is the offset right? you have to type 0x before the offset for example the offset is C1 then you have to Give 0xC1 to this script\n\n🟤5: Tried Everything but still didn't work? then contact the devloper of this script https://t.me/Hackers_House_YT")
      gg.setVisible(true)
      loopCheck()
   end
end

function SearchTypeChooser()
   local MenuItems
   MenuItems = {}
   for index, value in ipairs(SearchType) do
      MenuItems[index] = value['topic']
   end

   :: repeatMenu ::
   Menu = gg.choice(MenuItems, 0, "Please select The Search Type")
   if Menu == nil then
      gg.alert("ℹ️ Error : Please Select An Option ℹ️")
      goto repeatMenu
   end

   SearchTypeSelection = Menu
end

--[[ 🟢Value Finders From Class and offset 🟢]] --
function user_input_taker()
   SearchType = {
      [1] = {
         ['topic'] = 'Class Search',
         ['name'] = 'Class Name',
         ['offset'] = 'Feild Offset',
      },
      [2] = {
         ['topic'] = 'Struct Search',
         ['name'] = 'Struct Container Class Name',
         ['offset'] = 'Struct Offset inside Container Class',
         ['offsetSecond'] = 'Input Struct Feild Offset : ',
      },
      [3] = {
         ['topic'] = 'Child Class Search',
         ['name'] = 'Container Class Name',
         ['offset'] = 'Child Class Offset inside Container Class',
         ['offsetSecond'] = 'Input Child Class Feild Offset : ',
      }
   }

   ::stort::
   gg.clearResults()
   if userMode == 1 then
      if Get_user_input == nil then
         default1 = "GameController"
         default2 = "0x50"
         default3 = false
         if (gg.getTargetInfo().x64) then
            default4 = false
         else
            default4 = true
         end
         SearchTypeSelection = 1
         default5 = false
         default7 = false
      else
         default1 = Get_user_input[1]
         default2 = Get_user_input[2]
         default3 = Get_user_input[3]
         default4 = Get_user_input[4]
         default5 = Get_user_input[6]
         default7 = Get_user_input[7]
      end
      if SearchTypeSelection == 1 then
         Get_user_input = gg.prompt(
            { "🔰Script By🔰: https://t.me/Hackers_House_YT\n\nScript Mode : " ..
            SearchType[SearchTypeSelection]['topic'] .. "\n\n " .. SearchType[SearchTypeSelection]['name'] .. " : ",
               SearchType[SearchTypeSelection]['offset'] .. " : ", "Try Harder --(decreases accuracy)", "Try For 32 bit",
               'Change Search Mode', 'Give names and save', 'Custom Load (Load multiple With names)' },
            { default1, default2, default3, default4, false, default5, default7 },
            { "text", "text", "checkbox", "checkbox", "checkbox", "checkbox", "checkbox" })
      else
         Get_user_input = gg.prompt(
            { "🔰Script By🔰: https://t.me/Hackers_House_YT\n\nScript Mode : " ..
            SearchType[SearchTypeSelection]['topic'] .. "\n\n " .. SearchType[SearchTypeSelection]['name'] .. " : ",
               SearchType[SearchTypeSelection]['offset'] .. " : ", "Try Harder --(decreases accuracy)", "Try For 32 bit",
               'Change Search Mode', 'Give names and save', },
            { default1, default2, default3, default4, false, default5 },
            { "text", "text", "checkbox", "checkbox", "checkbox", "checkbox" })
         Get_user_input[7] = false
      end

      if Get_user_input ~= nil then
         if Get_user_input[7] then
            Get_user_input[2] = 0x0
            ::CustomInput::
            CustomLoadData = gg.prompt({
               'Input The code from DUMP.CS file\nCopy from the class/struct name files and feilds\nproperties and methods not required ' })

            if CustomLoadData == nil then
               gg.alert("ℹ️Please dont leave the input emptyℹ️")
               goto CustomInput
            end
         end


         if Get_user_input[5] == true then
            SearchTypeChooser()
            goto stort
         end
         if (Get_user_input[1] == "") or (Get_user_input[2] == "") then
            gg.alert("ℹ️ Don't Leave Input Blankℹ️")
            goto stort
         end
      else
         gg.alert("ℹ️ Error : Try again ℹ️")
         goto stort
      end





      ::UserTypeChooser::
      if Get_user_input[7] then
         Get_user_type = 20
      else
         Get_user_type = gg.choice(
            { "1. Byte / Boolean", "2. Dword / 32 bit Int", "3. Qword / 64 bit Int", "4. Float", "5. Double",
               "6. Vector2",
               "7. Vector2Int", "8. Vector3", "9. Vector3Int", "10. Vector4", "11. Vector4Int", "12. String",
               "13. Bounds",
               "14. BoundsInt", "15. Matrix2x3", "16. Matrix4x4", "17. Color", "18. Color32", "19. Quaternion",
               "+ Add Custom + " }, nil,
            "🔰Script By🔰: https://t.me/Hackers_House_YT\n\nℹ️ Choose The Output Type ℹ️")
      end


      if (Get_user_type == nil) then
         gg.alert("ℹ️ Please select a type ℹ️")
         goto UserTypeChooser
      end
      if Get_user_type == 1 then
         Get_user_type = gg.TYPE_BYTE
      elseif Get_user_type == 2 then
         Get_user_type = gg.TYPE_DWORD
      elseif Get_user_type == 3 then
         Get_user_type = gg.TYPE_QWORD
      elseif Get_user_type == 4 then
         Get_user_type = gg.TYPE_FLOAT
      elseif Get_user_type == 5 then
         Get_user_type = gg.TYPE_DOUBLE
      end
      if Get_user_type ~= gg.TYPE_BYTE then
         local hex_values = {}
         if Get_user_input[7] then
            Get_user_input[2] = tostring(Get_user_input[2])
         end
         for hex in Get_user_input[2]:gmatch("0x%x+") do
            table.insert(hex_values, hex)
         end

         if Get_user_input[7] then
            Get_user_input[2] = string.format("0x%X", tonumber(Get_user_input[2]))
         end


         -- Verify the offsets
         for i, v in ipairs(hex_values) do
            if (v % 4) ~= 0 then
               gg.alert("ℹ️Hex Offset Must Be An Multiple OF 4ℹ️")
               goto stort
            end
         end
      end

      if Get_user_type ~= 20 or SearchTypeSelection == 3 then
         :: SearchType ::
         if (SearchTypeSelection == 2 or SearchTypeSelection == 3) then
            if Get_second_feild_offset == nil then
               defaultSecondOffset = "0xBC"
            else
               defaultSecondOffset = Get_second_feild_offset[1]
            end
            Get_second_feild_offset = gg.prompt(
               { "🔰Script By🔰: https://t.me/Hackers_House_YT\n\n" .. SearchType[SearchTypeSelection]['offsetSecond'] },
               { defaultSecondOffset })

            if Get_second_feild_offset == nil or Get_second_feild_offset[1] == "" then
               gg.alert("ℹ️ Error : Dont leave the input empty ℹ️")
               goto SearchType
            end
         end


         if (SearchTypeSelection == 2 or SearchTypeSelection == 3) then
            local hexx_values = {}
            for hex in Get_second_feild_offset[1]:gmatch("0x%x+") do
               table.insert(hexx_values, hex)
            end

            -- Verify the offsets
            for i, v in ipairs(hexx_values) do
               if (v % 4) ~= 0 then
                  gg.alert("ℹ️Hex Offset Must Be An Multiple OF 4ℹ️")
                  goto SearchType
               end
            end
         end
      else
         Get_second_feild_offset = {}
         Get_second_feild_offset[1] = "0x0"
      end

      if Get_user_type == 20 then
         if not Get_user_input[7] then
            CustomTypeData = gg.prompt({
               'Input The code from DUMP.CS file\nCopy from the class/struct name files and feilds\nproperties and methods not required ' })
         end
      end
   end
   error = 0
end

function O_initial_search()
   gg.setVisible(false)
   gg.toast("🟢Hackers House: First Try")
   user_input = ":" .. Get_user_input[1]
   if Get_user_input[3] then
      offst = 25
   else
      offst = 0
   end
end

function O_dinitial_search()
   if error > 1 then
      gg.setRanges(gg.REGION_C_ALLOC)
   else
      gg.setRanges(gg.REGION_OTHER)
   end
   gg.searchNumber(user_input, gg.TYPE_BYTE)
   count = gg.getResultsCount()
   if count == 0 then
      found_("O_dinitial_search")
      return 0
   end
   Refiner = gg.getResults(1)
   gg.refineNumber(Refiner[1].value, gg.TYPE_BYTE)
   count = gg.getResultsCount()
   if count == 0 then
      found_("O_dinitial_search")
      return 0
   end
   val = gg.getResults(count)
end

function CA_pointer_search()
   gg.clearResults()
   gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_OTHER | gg.REGION_ANONYMOUS)
   gg.loadResults(val)
   gg.searchPointer(offst)
   count = gg.getResultsCount()
   if count == 0 then
      found_("CA_pointer_search")
      return 0
   end
   val = gg.getResults(count)
end

function CA_apply_offset()
   if Get_user_input[4] then
      tanker = 0xfffffffffffffff8
   else
      tanker = 0xfffffffffffffff0
   end
   local copy = false
   local l = val

   for i, v in ipairs(l) do
      v.address = v.address + tanker
      if copy then v.name = v.name .. ' #2' end
   end
   val = gg.getValues(l)
end

function CA2_apply_offset()
   if Get_user_input[4] then
      tanker = 0xfffffffffffffff8
   else
      tanker = 0xfffffffffffffff0
   end
   local copy = false
   local l = val
   for i, v in ipairs(l) do
      v.address = v.address + tanker
      if copy then v.name = v.name .. ' #2' end
   end
   val = gg.getValues(l)
end

function Q_apply_fix()
   gg.setRanges(gg.REGION_ANONYMOUS)
   gg.loadResults(val)
   count = gg.getResultsCount()
   if count == 0 then
      found_("Q_apply_fix")
      return 0
   end
   yy = gg.getResults(1000)
   gg.clearResults()
   i = 1
   c = 1
   s = {}
   while (i - 1) < count do
      yy[i].address = yy[i].address + 0xb400000000000000
      gg.searchNumber(yy[i].address, gg.TYPE_QWORD)
      cnt = gg.getResultsCount()
      if 0 < cnt then
         bytr = gg.getResults(cnt)
         n = 1
         while (n - 1) < cnt do
            s[c] = {}
            s[c].address = bytr[n].address
            s[c].flags = 32
            n = n + 1
            c = c + 1
         end
      end
      gg.clearResults()
      i = i + 1
   end
   val = gg.getValues(s)
end

function A_base_value()
   gg.setRanges(gg.REGION_ANONYMOUS)
   gg.loadResults(val)
   gg.searchPointer(offst)
   count = gg.getResultsCount()
   if count == 0 then
      found_("A_base_value")
      return 0
   end
   val = gg.getResults(count)
end

function A_base_accuracy()
   gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_C_ALLOC)
   gg.loadResults(val)
   gg.searchPointer(offst)
   count = gg.getResultsCount()
   if count == 0 then
      found_("A_base_accuracy")
      return 0
   end
   kol = gg.getResults(count)
   i = 1
   h = {}
   while (i - 1) < count do
      h[i] = {}
      h[i].address = kol[i].value
      h[i].flags = 32
      i = i + 1
   end
   val = gg.getValues(h)
end

function IsComplexTypeChoosen()
   local Output
   Output = {}
   if (Get_user_type == gg.TYPE_BYTE or Get_user_type == gg.TYPE_DWORD or Get_user_type == gg.TYPE_QWORD or Get_user_type == gg.TYPE_FLOAT or Get_user_type == gg.TYPE_DOUBLE) then
      Output['IsComplex'] = false
   elseif (Get_user_type == 6) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "Vector2"
   elseif (Get_user_type == 7) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "Vector2Int"
   elseif (Get_user_type == 8) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "Vector3"
   elseif (Get_user_type == 9) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "Vector3Int"
   elseif (Get_user_type == 10) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "Vector4"
   elseif (Get_user_type == 11) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "Vector4Int"
   elseif (Get_user_type == 12) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "String"
   elseif (Get_user_type == 13) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "Bounds"
   elseif (Get_user_type == 14) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "BoundsInt"
   elseif (Get_user_type == 15) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "Matrix2x3"
   elseif (Get_user_type == 16) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "Matrix4x4"
   elseif (Get_user_type == 17) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "Color"
   elseif (Get_user_type == 18) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "Color32"
   elseif (Get_user_type == 19) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "Quaternion"
   elseif (Get_user_type == 20) then
      Output['IsComplex'] = true
      Output['FeildHandler'] = "CustomFeild"
   end

   return Output
end

function A_user_given_offset()
   local old_save_list = val
   local uniqueTable = {} -- Table to hold unique addresses
   local addressSet = {}  -- Set to track seen addresses

   for _, item in ipairs(old_save_list) do
      if not addressSet[item.address] then
         table.insert(uniqueTable, item)
         addressSet[item.address] = true
      end
   end

   old_save_list = uniqueTable
 
   local finalResults = {}
   local finalResultIndex = 1
   local hex_values = {}
   local hexx_values = {}
   local complex_loaded_list = {}
   local TempComplexTypeStore = IsComplexTypeChoosen()
   if Get_user_input[7] then
      Get_user_input[2] = tostring(Get_user_input[2])
   end

   for hex in Get_user_input[2]:gmatch("0x%x+") do
      table.insert(hex_values, hex)
   end
   if Get_user_input[7] then
      Get_user_input[2] = '0x0'
   end


   -- Normal values loader, Loads dword or qword if basic type is not selected
   for i, v in ipairs(old_save_list) do
      for index, value in ipairs(hex_values) do
         if Get_user_input[7] then
            value = 0
         end

         finalResults[finalResultIndex] = {}
         finalResults[finalResultIndex].address = v.address + value
         if (SearchTypeSelection == 1) then
            if (TempComplexTypeStore['IsComplex']) then
               local ComplexTypeRefrence = { ['address'] = v.address + value }
               local TempSingleTypeLoad = ComplexFeildsHandlers[TempComplexTypeStore['FeildHandler']](
                  ComplexTypeRefrence)

               for i = 1, #TempSingleTypeLoad do
                  complex_loaded_list[#complex_loaded_list + 1] = TempSingleTypeLoad[i]
               end
            else
               finalResults[finalResultIndex].flags = Get_user_type
            end
         else
            if Get_user_input[4] then
               finalResults[finalResultIndex].flags = gg.TYPE_DWORD
            else
               finalResults[finalResultIndex].flags = gg.TYPE_QWORD
            end
         end
         finalResultIndex = finalResultIndex + 1
      end
   end
   if (SearchTypeSelection == 1) then
      if (TempComplexTypeStore['IsComplex']) then
         finalResults = gg.getValues(complex_loaded_list)
         Results = complex_loaded_list
         if SearchTypeSelection == 1 then
            if Get_user_input[6] then
               gg.addListItems(complex_loaded_list)
            end
         end
      else
         finalResults = gg.getValues(finalResults)
         Results = finalResults
      end
   end


   -- Struct values loader, It loades the struct values given during struct search mode
   if (SearchTypeSelection == 2) then
      for hex in Get_second_feild_offset[1]:gmatch("0x%x+") do
         table.insert(hexx_values, hex)
      end

      local structValues = {}
      local structValueIndex = 1;


      for i, v in ipairs(finalResults) do
         for index, value in ipairs(hexx_values) do
            if value == "0x0" then
               value = 0
            end
            if Get_user_input[7] then
               value = 0
            end

            structValues[structValueIndex] = {}
            structValues[structValueIndex].address = v.address + value
            if (TempComplexTypeStore['IsComplex']) then
               local ComplexTypeRefrence = { ['address'] = v.address + value }
               local TempSingleTypeLoad = ComplexFeildsHandlers[TempComplexTypeStore['FeildHandler']](
                  ComplexTypeRefrence)

               for i = 1, #TempSingleTypeLoad do
                  complex_loaded_list[#complex_loaded_list + 1] = TempSingleTypeLoad[i]
               end
            else
               structValues[structValueIndex].flags = Get_user_type
            end

            structValueIndex = structValueIndex + 1
         end
      end

      gg.clearResults()

      if (TempComplexTypeStore['IsComplex']) then
         structValues = gg.getValues(complex_loaded_list)
         Results = complex_loaded_list
         if SearchTypeSelection == 2 then
            if Get_user_input[6] then
               gg.addListItems(complex_loaded_list)
            end
         end
      else
         structValues = gg.getValues(structValues)
         Results = structValues
      end



      gg.loadResults(structValues)
   elseif (SearchTypeSelection == 3) then
      -- Child class loader, it loades child class from the offsets given by user

      finalResults = gg.getValues(finalResults)
      for hex in Get_second_feild_offset[1]:gmatch("0x%x+") do
         table.insert(hexx_values, hex)
      end



      local childClassValues = {}
      local childClassIndex = 1;

      -- Final result contains pointers
      -- final result val + offset will be new values to be loaded
      for i, v in ipairs(finalResults) do
         for index, value in ipairs(hexx_values) do
            if value == "0x0" then
               value = 0
            end
            childClassValues[childClassIndex] = {}
            childClassValues[childClassIndex].address = v.value + value


            -- From here code for custom load
            if (TempComplexTypeStore['IsComplex']) then
               local ComplexTypeRefrence = { ['address'] = v.value + value }
               local TempSingleTypeLoad = ComplexFeildsHandlers[TempComplexTypeStore['FeildHandler']](
                  ComplexTypeRefrence)

               for i = 1, #TempSingleTypeLoad do
                  complex_loaded_list[#complex_loaded_list + 1] = TempSingleTypeLoad[i]
               end
            else
               childClassValues[childClassIndex].flags = Get_user_type
            end



            childClassIndex = childClassIndex + 1
         end
      end

      gg.clearResults()
      if (TempComplexTypeStore['IsComplex']) then
         childClassValues = gg.getValues(complex_loaded_list)
         Results = complex_loaded_list
         if SearchTypeSelection == 3 then
            if Get_user_input[6] then
               gg.addListItems(complex_loaded_list)
            end
         end
      else
         childClassValues = gg.getValues(childClassValues)
         Results = childClassValues
      end
      gg.loadResults(childClassValues)
   else
      gg.clearResults()
      gg.loadResults(finalResults)
   end

   count = gg.getResultsCount()
   if count == 0 then
      found_("A_user_given_offset")
      return 0
   end
   gg.setVisible(true)
end

-- Function to parse the input string
function parseClass(input)
   -- Adjusted pattern to capture the class access modifier and name
   local classAccess, classType, className = input:match("(%w+) (class) (%w+)")
   if not type then
      classAccess, classType, className = input:match("(%w+) (struct) (%w+)")
   end

   if Get_user_input[7] then
      classType = "struct"
   end
   local fields = {}

   -- Pattern to match all relevant access modifiers and multi-word types
   local pattern = "(%w+) (%w+); // (0x%x+)"

   -- Use the pattern to find all matches
   for type, name, offset in input:gmatch(pattern) do
      -- Trim any leading or trailing whitespace from the type
      type = type:match("^%s*(.-)%s*$")
      table.insert(fields, { visibility = visibility, name = name, type = type, offset = offset })
   end

   return { classAccess = classAccess, classType = classType, className = className, fields = fields }
end

-- Integer Types:

-- int: 32-bit signed integer (4 bytes)
-- long: 64-bit signed integer (8 bytes)
-- short: 16-bit signed integer (2 bytes)
-- byte: 8-bit unsigned integer (1 byte)
-- uint: 32-bit unsigned integer (4 bytes)
-- ulong: 64-bit unsigned integer (8 bytes)
-- ushort: 16-bit unsigned integer (2 bytes)
-- sbyte: 8-bit signed integer (1 byte)
-- Floating-Point Types:

-- float: 32-bit single-precision floating point (4 bytes)
-- double: 64-bit double-precision floating point (8 bytes)
-- decimal: 128-bit high-precision decimal type (16 bytes)
-- Character Type:

-- char: 16-bit Unicode character (2 bytes)
-- Boolean Type:

-- bool: Implementation-defined size, but generally 1 byte (8 bits) in memory
-- String Type:

-- string: The size depends on the length of the string, but each character is 16 bits (2 bytes) due to being UTF-16 encoded.
-- Object Type:

-- object: The size of an object reference is platform-dependent: 4 bytes on a 32-bit system and 8 bytes on a 64-bit system, but the actual object data is the size of the contained data plus metadata overhead

function GetHandler(Input)
   for index, value in ipairs(Input['fields']) do
      if Input['fields'][index]['type'] == 'int' then
         Input['fields'][index]['handler'] = 'BasicType'
         Input['fields'][index]['BasicType'] = gg.TYPE_DWORD
         Input['fields'][index]['Name'] = "(int, 32 bit, signed)"
      elseif Input['fields'][index]['type'] == 'uint' then
         Input['fields'][index]['handler'] = 'BasicType'
         Input['fields'][index]['BasicType'] = gg.TYPE_DWORD
         Input['fields'][index]['Name'] = "(int, 32 bit, unsigned)"
      elseif Input['fields'][index]['type'] == 'short' then
         Input['fields'][index]['handler'] = 'BasicType'
         Input['fields'][index]['BasicType'] = gg.TYPE_WORD
         Input['fields'][index]['Name'] = "(short, 16 bit, signed)"
      elseif Input['fields'][index]['type'] == 'ushort' then
         Input['fields'][index]['handler'] = 'BasicType'
         Input['fields'][index]['BasicType'] = gg.TYPE_WORD
         Input['fields'][index]['Name'] = "(short, 16 bit, unsigned)"
      elseif Input['fields'][index]['type'] == 'bool' then
         Input['fields'][index]['handler'] = 'BasicType'
         Input['fields'][index]['BasicType'] = gg.TYPE_BYTE
         Input['fields'][index]['Name'] = "(bool, 8 bit, unsigned)"
      elseif Input['fields'][index]['type'] == 'byte' then
         Input['fields'][index]['handler'] = 'BasicType'
         Input['fields'][index]['BasicType'] = gg.TYPE_BYTE
         Input['fields'][index]['Name'] = "(byte, 8 bit, unsigned)"
      elseif Input['fields'][index]['type'] == 'ubyte' then
         Input['fields'][index]['handler'] = 'BasicType'
         Input['fields'][index]['BasicType'] = gg.TYPE_BYTE
         Input['fields'][index]['Name'] = "(byte, 8 bit, signed)"
      elseif Input['fields'][index]['type'] == 'float' then
         Input['fields'][index]['handler'] = 'BasicType'
         Input['fields'][index]['BasicType'] = gg.TYPE_FLOAT
         Input['fields'][index]['Name'] = "(Float, 32 bit)"
      elseif Input['fields'][index]['type'] == 'double' then
         Input['fields'][index]['handler'] = 'BasicType'
         Input['fields'][index]['BasicType'] = gg.TYPE_DOUBLE
         Input['fields'][index]['Name'] = "(Double, 32 bit)"
      elseif Input['fields'][index]['type'] == 'Vector2' then
         Input['fields'][index]['handler'] = 'Vector2'
      elseif Input['fields'][index]['type'] == 'Vector2Int' then
         Input['fields'][index]['handler'] = 'Vector2Int'
      elseif Input['fields'][index]['type'] == 'Vector3' then
         Input['fields'][index]['handler'] = 'Vector3'
      elseif Input['fields'][index]['type'] == 'Vector3Int' then
         Input['fields'][index]['handler'] = 'Vector3Int'
      elseif Input['fields'][index]['type'] == 'Vector4' then
         Input['fields'][index]['handler'] = 'Vector4'
      elseif Input['fields'][index]['type'] == 'Vector4Int' then
         Input['fields'][index]['handler'] = 'Vector4Int'
      elseif Input['fields'][index]['type'] == 'Bounds' then
         Input['fields'][index]['handler'] = 'Bounds'
      elseif Input['fields'][index]['type'] == 'BoundsInt' then
         Input['fields'][index]['handler'] = 'BoundsInt'
      elseif Input['fields'][index]['type'] == 'Matrix2x3' then
         Input['fields'][index]['handler'] = 'Matrix2x3'
      elseif Input['fields'][index]['type'] == 'Matrix4x4' then
         Input['fields'][index]['handler'] = 'Matrix4x4'
      elseif Input['fields'][index]['type'] == 'Color' then
         Input['fields'][index]['handler'] = 'Color'
      elseif Input['fields'][index]['type'] == 'Color32' then
         Input['fields'][index]['handler'] = 'Color32'
      elseif Input['fields'][index]['type'] == 'Quaternion' then
         Input['fields'][index]['handler'] = 'Quaternion'
      elseif Input['fields'][index]['type'] == 'string' then
         Input['fields'][index]['handler'] = 'String'
      else
         if Get_user_input[4] then
            Input['fields'][index]['handler'] = 'BasicType'
            Input['fields'][index]['BasicType'] = gg.TYPE_DWORD
            Input['fields'][index]['Name'] = "(Unidentified : Pointer if class, first value if struct)"
         else
            Input['fields'][index]['handler'] = 'BasicType'
            Input['fields'][index]['BasicType'] = gg.TYPE_QWORD
            Input['fields'][index]['Name'] = "(Unidentified : Pointer if class, first value if struct)"
         end
      end
   end

   return Input
end

--[[ 🔴 Different Functions For 1,2,3,4th try 🔴]] --
function start()
   user_input_taker()
   O_initial_search()
   O_dinitial_search()
   if error > 0 then
      return 0
   end
   CA_pointer_search()
   if error > 0 then
      return 0
   end
   CA_apply_offset()
   if error > 0 then
      return 0
   end
   A_base_value()
   if error > 0 then
      return 0
   end
   if offst == 0 then
      A_base_accuracy()
   end
   if error > 0 then
      return 0
   end
   A_user_given_offset()
   if error > 0 then
      return 0
   end
   loopCheck()
   if error > 0 then
      return 0
   end
end

function second_start()
   gg.toast("🟡Hackers House: Second Try")
   O_dinitial_search()
   if error > 1 then
      return 0
   end
   CA_pointer_search()
   if error > 1 then
      return 0
   end
   CA_apply_offset()
   if error > 1 then
      return 0
   end
   Q_apply_fix()
   if error > 1 then
      return 0
   end
   if offst == 0 then
      A_base_accuracy()
   end
   if error > 1 then
      return 0
   end
   A_user_given_offset()
   if error > 1 then
      return 0
   end
   loopCheck()
   if error > 1 then
      return 0
   end
end

function third_start()
   gg.toast("🔴Hackers House: Third Try")
   O_dinitial_search()
   if error > 2 then
      return 0
   end
   CA_pointer_search()
   if error > 2 then
      return 0
   end
   if offst == 0 then
      CA2_apply_offset()
   end
   if error > 2 then
      return 0
   end
   A_base_value()
   if error > 2 then
      return 0
   end
   if offst == 0 then
      A_base_accuracy()
   end
   if error > 2 then
      return 0
   end
   A_user_given_offset()
   if error > 2 then
      return 0
   end
   loopCheck()
   if error > 2 then
      return 0
   end
end

function fourth_start()
   gg.toast("☢️Hackers House: Fourth Try")
   O_dinitial_search()
   CA_pointer_search()
   CA2_apply_offset()
   Q_apply_fix()
   if offst == 0 then
      A_base_accuracy()
   end
   A_user_given_offset()
   loopCheck()
end

-- -- Float , float , float,
-- -- Player possition
--    -float
--    -float
--    -float
--    -- second
--       -float
--       -float
--       -float
--       -- third
--          -float
--          -float
--          -float



ComplexFeildsHandlers = {
   ['BasicType'] = function(Input)
      local Output = {}
      Output[1] = {}
      Output[1].address = Input.address
      Output[1].flags = Input['BasicType']
      Output[1].name = Input['Name']
      if Input['name'] ~= nil then
         Output[1].name = Input['name'] .. "  " .. Output[1].name
      end
      return Output
   end,
   ['Vector2'] = function(Input)
      local Output = {}
      Output[1] = {}
      Output[1].address = Input.address
      Output[1].flags = gg.TYPE_FLOAT
      Output[1].name = " (Vector2 : X)"

      Output[2] = {}
      Output[2].address = Input.address + 0x4
      Output[2].flags = gg.TYPE_FLOAT
      Output[2].name = " (Vector2 : Y)"

      if Input['name'] ~= nil then
         Output[1].name = Input['name'] .. "  " .. Output[1].name
         Output[2].name = Input['name'] .. "  " .. Output[2].name
      end

      return Output
   end,
   ['Vector2Int'] = function(Input)
      local Output = {}
      Output[1] = {}
      Output[1].address = Input.address
      Output[1].flags = gg.TYPE_DWORD
      Output[1].name = " (Vector2Int : X)"

      Output[2] = {}
      Output[2].address = Input.address + 0x4
      Output[2].flags = gg.TYPE_DWORD
      Output[2].name = " (Vector2Int : Y)"

      if Input['name'] ~= nil then
         Output[1].name = Input['name'] .. "  " .. Output[1].name
         Output[2].name = Input['name'] .. "  " .. Output[2].name
      end

      return Output
   end,
   ['Vector3'] = function(Input)
      local Output = {}
      Output[1] = {}
      Output[1].address = Input.address
      Output[1].flags = gg.TYPE_FLOAT
      Output[1].name = " (Vector3 : X)"

      Output[2] = {}
      Output[2].address = Input.address + 0x4
      Output[2].flags = gg.TYPE_FLOAT
      Output[2].name = " (Vector3 : Y)"

      Output[3] = {}
      Output[3].address = Input.address + 0x8
      Output[3].flags = gg.TYPE_FLOAT
      Output[3].name = " (Vector3 : Z)"

      if Input['name'] ~= nil then
         Output[1].name = Input['name'] .. "  " .. Output[1].name
         Output[2].name = Input['name'] .. "  " .. Output[2].name
         Output[3].name = Input['name'] .. "  " .. Output[3].name
      end

      return Output
   end,
   ['Vector3Int'] = function(Input)
      local Output = {}
      Output[1] = {}
      Output[1].address = Input.address
      Output[1].flags = gg.TYPE_DWORD
      Output[1].name = " (Vector3Int : X)"

      Output[2] = {}
      Output[2].address = Input.address + 0x4
      Output[2].flags = gg.TYPE_DWORD
      Output[2].name = " (Vector3Int : Y)"

      Output[3] = {}
      Output[3].address = Input.address + 0x8
      Output[3].flags = gg.TYPE_DWORD
      Output[3].name = " (Vector3Int : Z)"

      if Input['name'] ~= nil then
         Output[1].name = Input['name'] .. "  " .. Output[1].name
         Output[2].name = Input['name'] .. "  " .. Output[2].name
         Output[3].name = Input['name'] .. "  " .. Output[3].name
      end

      return Output
   end,
   ['Vector4'] = function(Input)
      local Output = {}
      Output[1] = {}
      Output[1].address = Input.address
      Output[1].flags = gg.TYPE_FLOAT
      Output[1].name = " (Vector4 : X)"

      Output[2] = {}
      Output[2].address = Input.address + 0x4
      Output[2].flags = gg.TYPE_FLOAT
      Output[2].name = " (Vector4 : Y)"

      Output[3] = {}
      Output[3].address = Input.address + 0x8
      Output[3].flags = gg.TYPE_FLOAT
      Output[3].name = " (Vector4 : Z)"

      Output[4] = {}
      Output[4].address = Input.address + 0xC
      Output[4].flags = gg.TYPE_FLOAT
      Output[4].name = " (Vector4 : W)"

      if Input['name'] ~= nil then
         Output[1].name = Input['name'] .. "  " .. Output[1].name
         Output[2].name = Input['name'] .. "  " .. Output[2].name
         Output[3].name = Input['name'] .. "  " .. Output[3].name
         Output[4].name = Input['name'] .. "  " .. Output[4].name
      end

      return Output
   end,
   ['Vector4Int'] = function(Input)
      local Output = {}
      Output[1] = {}
      Output[1].address = Input.address
      Output[1].flags = gg.TYPE_DWORD
      Output[1].name = " (Vector4Int : X)"

      Output[2] = {}
      Output[2].address = Input.address + 0x4
      Output[2].flags = gg.TYPE_DWORD
      Output[2].name = " (Vector4Int : Y)"

      Output[3] = {}
      Output[3].address = Input.address + 0x8
      Output[3].flags = gg.TYPE_DWORD
      Output[3].name = " (Vector4Int : Z)"

      Output[4] = {}
      Output[4].address = Input.address + 0xC
      Output[4].flags = gg.TYPE_DWORD
      Output[4].name = " (Vector4Int : W)"

      if Input['name'] ~= nil then
         Output[1].name = Input['name'] .. "  " .. Output[1].name
         Output[2].name = Input['name'] .. "  " .. Output[2].name
         Output[3].name = Input['name'] .. "  " .. Output[3].name
         Output[4].name = Input['name'] .. "  " .. Output[4].name
      end
      return Output
   end,
   ['Bounds'] = function(Input)
      local Output = {}
      local TempSingleTypeLoad = ComplexFeildsHandlers.Vector3(Input)
      for i = 1, #TempSingleTypeLoad do
         TempSingleTypeLoad[i].name = "Bounds : m_Center " .. TempSingleTypeLoad[i].name
         Output[#Output + 1] = TempSingleTypeLoad[i]
      end

      local TempSingleTypeLoad = ComplexFeildsHandlers.Vector3({ ['address'] = Input.address + 0xC })
      for i = 1, #TempSingleTypeLoad do
         TempSingleTypeLoad[i].name = "Bounds : m_Extents " .. TempSingleTypeLoad[i].name
         Output[#Output + 1] = TempSingleTypeLoad[i]
      end

      return Output
   end,
   ['BoundsInt'] = function(Input)
      local Output = {}
      local TempSingleTypeLoad = ComplexFeildsHandlers.Vector3Int(Input)
      for i = 1, #TempSingleTypeLoad do
         TempSingleTypeLoad[i].name = "BoundsInt : m_Center " .. TempSingleTypeLoad[i].name
         Output[#Output + 1] = TempSingleTypeLoad[i]
      end

      local TempSingleTypeLoad = ComplexFeildsHandlers.Vector3Int({ ['address'] = Input.address + 0xC })
      for i = 1, #TempSingleTypeLoad do
         TempSingleTypeLoad[i].name = "BoundsInt : m_Extents " .. TempSingleTypeLoad[i].name
         Output[#Output + 1] = TempSingleTypeLoad[i]
      end

      return Output
   end,
   ['Matrix2x3'] = function(Input)
      local Output = {}
      Output[1] = {}
      Output[1].address = Input.address
      Output[1].flags = gg.TYPE_FLOAT
      Output[1].name = " (Matrix2x3 : m00)"

      Output[2] = {}
      Output[2].address = Input.address + 0x4
      Output[2].flags = gg.TYPE_FLOAT
      Output[2].name = " (Matrix2x3 : m01)"

      Output[3] = {}
      Output[3].address = Input.address + 0x8
      Output[3].flags = gg.TYPE_FLOAT
      Output[3].name = " (Matrix2x3 : m02)"

      Output[4] = {}
      Output[4].address = Input.address + 0xC
      Output[4].flags = gg.TYPE_FLOAT
      Output[4].name = " (Matrix2x3 : m10)"

      Output[5] = {}
      Output[5].address = Input.address + 0x10
      Output[5].flags = gg.TYPE_FLOAT
      Output[5].name = " (Matrix2x3 : m11)"

      Output[6] = {}
      Output[6].address = Input.address + 0x14
      Output[6].flags = gg.TYPE_FLOAT
      Output[6].name = " (Matrix2x3 : m12)"

      if Input['name'] ~= nil then
         Output[1].name = Input['name'] .. "  " .. Output[1].name
         Output[2].name = Input['name'] .. "  " .. Output[2].name
         Output[3].name = Input['name'] .. "  " .. Output[3].name
         Output[4].name = Input['name'] .. "  " .. Output[4].name
         Output[5].name = Input['name'] .. "  " .. Output[5].name
         Output[6].name = Input['name'] .. "  " .. Output[6].name
      end
      return Output
   end,
   ['Matrix4x4'] = function(Input)
      local Output = {}
      Output[1] = {}
      Output[1].address = Input.address
      Output[1].flags = gg.TYPE_FLOAT
      Output[1].name = " (Matrix4x4 : m00)"

      Output[2] = {}
      Output[2].address = Input.address + 0x4
      Output[2].flags = gg.TYPE_FLOAT
      Output[2].name = " (Matrix4x4 : m10)"

      Output[3] = {}
      Output[3].address = Input.address + 0x8
      Output[3].flags = gg.TYPE_FLOAT
      Output[3].name = " (Matrix4x4 : m20)"

      Output[4] = {}
      Output[4].address = Input.address + 0xC
      Output[4].flags = gg.TYPE_FLOAT
      Output[4].name = " (Matrix4x4 : m30)"

      Output[5] = {}
      Output[5].address = Input.address + 0x10
      Output[5].flags = gg.TYPE_FLOAT
      Output[5].name = " (Matrix4x4 : m01)"

      Output[6] = {}
      Output[6].address = Input.address + 0x14
      Output[6].flags = gg.TYPE_FLOAT
      Output[6].name = " (Matrix4x4 : m11)"

      Output[7] = {}
      Output[7].address = Input.address + 0x18
      Output[7].flags = gg.TYPE_FLOAT
      Output[7].name = " (Matrix4x4 : m21)"

      Output[8] = {}
      Output[8].address = Input.address + 0x1C
      Output[8].flags = gg.TYPE_FLOAT
      Output[8].name = " (Matrix4x4 : m31)"

      Output[9] = {}
      Output[9].address = Input.address + 0x20
      Output[9].flags = gg.TYPE_FLOAT
      Output[9].name = " (Matrix4x4 : m02)"

      Output[10] = {}
      Output[10].address = Input.address + 0x24
      Output[10].flags = gg.TYPE_FLOAT
      Output[10].name = " (Matrix4x4 : m12)"

      Output[11] = {}
      Output[11].address = Input.address + 0x28
      Output[11].flags = gg.TYPE_FLOAT
      Output[11].name = " (Matrix4x4 : m22)"

      Output[12] = {}
      Output[12].address = Input.address + 0x2C
      Output[12].flags = gg.TYPE_FLOAT
      Output[12].name = " (Matrix4x4 : m32)"

      Output[13] = {}
      Output[13].address = Input.address + 0x30
      Output[13].flags = gg.TYPE_FLOAT
      Output[13].name = " (Matrix4x4 : m03)"

      Output[14] = {}
      Output[14].address = Input.address + 0x34
      Output[14].flags = gg.TYPE_FLOAT
      Output[14].name = " (Matrix4x4 : m13)"

      Output[15] = {}
      Output[15].address = Input.address + 0x38
      Output[15].flags = gg.TYPE_FLOAT
      Output[15].name = " (Matrix4x4 : m23)"

      Output[16] = {}
      Output[16].address = Input.address + 0x3C
      Output[16].flags = gg.TYPE_FLOAT
      Output[16].name = " (Matrix4x4 : m33)"

      if Input['name'] ~= nil then
         Output[1].name = Input['name'] .. "  " .. Output[1].name
         Output[2].name = Input['name'] .. "  " .. Output[2].name
         Output[3].name = Input['name'] .. "  " .. Output[3].name
         Output[4].name = Input['name'] .. "  " .. Output[4].name
         Output[5].name = Input['name'] .. "  " .. Output[5].name
         Output[6].name = Input['name'] .. "  " .. Output[6].name
         Output[7].name = Input['name'] .. "  " .. Output[7].name
         Output[8].name = Input['name'] .. "  " .. Output[8].name
         Output[9].name = Input['name'] .. "  " .. Output[9].name
         Output[10].name = Input['name'] .. "  " .. Output[10].name
         Output[11].name = Input['name'] .. "  " .. Output[11].name
         Output[12].name = Input['name'] .. "  " .. Output[12].name
         Output[13].name = Input['name'] .. "  " .. Output[13].name
         Output[14].name = Input['name'] .. "  " .. Output[14].name
         Output[15].name = Input['name'] .. "  " .. Output[15].name
         Output[16].name = Input['name'] .. "  " .. Output[16].name
      end

      return Output
   end,
   ['Color'] = function(Input)
      local Output = {}
      Output[1] = {}
      Output[1].address = Input.address
      Output[1].flags = gg.TYPE_FLOAT
      Output[1].name = " (Color : Red)"

      Output[2] = {}
      Output[2].address = Input.address + 0x4
      Output[2].flags = gg.TYPE_FLOAT
      Output[2].name = " (Color : Blue)"

      Output[3] = {}
      Output[3].address = Input.address + 0x8
      Output[3].flags = gg.TYPE_FLOAT
      Output[3].name = " (Color : Green)"

      Output[4] = {}
      Output[4].address = Input.address + 0xC
      Output[4].flags = gg.TYPE_FLOAT
      Output[4].name = " (Color : Opacity)"

      if Input['name'] ~= nil then
         Output[1].name = Input['name'] .. "  " .. Output[1].name
         Output[2].name = Input['name'] .. "  " .. Output[2].name
         Output[3].name = Input['name'] .. "  " .. Output[3].name
         Output[4].name = Input['name'] .. "  " .. Output[4].name
      end
      return Output
   end,
   ['Color32'] = function(Input)
      local Output = {}
      Output[1] = {}
      Output[1].address = Input.address
      Output[1].flags = gg.TYPE_BYTE
      Output[1].name = " (Color32 : Red)"

      Output[2] = {}
      Output[2].address = Input.address + 0x1
      Output[2].flags = gg.TYPE_BYTE
      Output[2].name = " (Color32 : Blue)"

      Output[3] = {}
      Output[3].address = Input.address + 0x2
      Output[3].flags = gg.TYPE_BYTE
      Output[3].name = " (Color32 : Green)"

      Output[4] = {}
      Output[4].address = Input.address + 0x3
      Output[4].flags = gg.TYPE_BYTE
      Output[4].name = " (Color32 : Opacity)"


      if Input['name'] ~= nil then
         Output[1].name = Input['name'] .. "  " .. Output[1].name
         Output[2].name = Input['name'] .. "  " .. Output[2].name
         Output[3].name = Input['name'] .. "  " .. Output[3].name
         Output[4].name = Input['name'] .. "  " .. Output[4].name
      end
      return Output
   end,
   ['Quaternion'] = function(Input)
      local Output = {}
      Output[1] = {}
      Output[1].address = Input.address
      Output[1].flags = gg.TYPE_FLOAT
      Output[1].name = " (Quaternion : X)"

      Output[2] = {}
      Output[2].address = Input.address + 0x4
      Output[2].flags = gg.TYPE_FLOAT
      Output[2].name = " (Quaternion : Y)"

      Output[3] = {}
      Output[3].address = Input.address + 0x8
      Output[3].flags = gg.TYPE_FLOAT
      Output[3].name = " (Quaternion : Z)"

      Output[4] = {}
      Output[4].address = Input.address + 0xC
      Output[4].flags = gg.TYPE_FLOAT
      Output[4].name = " (Quaternion : W)"


      if Input['name'] ~= nil then
         Output[1].name = Input['name'] .. "  " .. Output[1].name
         Output[2].name = Input['name'] .. "  " .. Output[2].name
         Output[3].name = Input['name'] .. "  " .. Output[3].name
         Output[4].name = Input['name'] .. "  " .. Output[4].name
      end
      return Output
   end,
   ['String'] = function(Input)
      local flags
      if Get_user_input[4] then
         flags = gg.TYPE_DWORD
      else
         flags = gg.TYPE_QWORD
      end

      Input.flags = flags

      local TableList = {}
      TableList[1] = Input

      Input = gg.getValues(TableList)[1]
      local Output = {}
      local offset
      if Get_user_input[4] then
         offset = 0x8
      else
         offset = 0x10
      end
      StringLength = gg.getValues({ [1] = { ['address'] = Input.value + offset, ['flags'] = gg.TYPE_DWORD } })

      if StringLength[1].value < 0 then
         StringLength[1].value = 0
      elseif StringLength[1].value > 1000 then
         StringLength[1].value = 1000
      end

      for i = 1, StringLength[1].value * 2 + 1 do
         if i == 1 then
            Output[i] = { ['address'] = Input.value + offset, ['flags'] = gg.TYPE_DWORD }
         else
            Output[i] = {}
            Output[i].flags = gg.TYPE_BYTE
            Output[i].address = Input.value + offset + 0x3 + (i - 0x1)
         end
      end

      Output = gg.getValues(Output)


      FullString = ''

      for i = 1, #Output do
         local currentChar

         if Output[i].value < 0 or Output[i].value > 255 then
            currentChar = '*Invalid char*'
         else
            currentChar = string.char(Output[i].value)
         end
         if i ~= 1 then
            FullString = FullString .. currentChar
            Output[i].name = ' (String : Char no ' .. i - 1 .. ', Char : ' .. currentChar .. ')'
         end
      end
      Output[1].name = ' (Int :String length : ' .. Output[1].value .. ', Full string : ' .. FullString .. ')';

      return Output
   end,
   ['CustomFeild'] = function(Input)
      local complex_loaded_list = {}
      local PointerValue
      if Get_user_input[4] then
         PointerValue = gg.getValues({ [1] = { ['address'] = Input.address, ['flags'] = gg.TYPE_DWORD } })
      else
         PointerValue = gg.getValues({ [1] = { ['address'] = Input.address, ['flags'] = gg.TYPE_QWORD } })
      end

      if Get_user_input[7] then
         ClassParsedInTable = parseClass(tostring(CustomLoadData))
         ParsedClassWithHandlers = GetHandler(ClassParsedInTable)
      else
         ClassParsedInTable = parseClass(tostring(CustomTypeData))
         ParsedClassWithHandlers = GetHandler(ClassParsedInTable)
      end
      for index, value in ipairs(ParsedClassWithHandlers['fields']) do
         if ParsedClassWithHandlers['classType'] == 'class' then
            if Get_user_input[4] then
               ParsedClassWithHandlers['fields'][index].address = PointerValue[1].value +
                   ParsedClassWithHandlers['fields'][index].offset
            else
               ParsedClassWithHandlers['fields'][index].address = PointerValue[1].value +
                   ParsedClassWithHandlers['fields'][index].offset
            end
         else
            if ParsedClassWithHandlers['fields'][index].offset == "0x0" then
               ParsedClassWithHandlers['fields'][index].offset = 0
            else
               -- ParsedClassWithHandlers['fields'][index].offset = tonumber(ParsedClassWithHandlers['fields'][index].offset, 10)
            end
            ParsedClassWithHandlers['fields'][index].address = Input.address +
                ParsedClassWithHandlers['fields'][index].offset
         end
         local TempSingleTypeLoad = ComplexFeildsHandlers[ParsedClassWithHandlers['fields'][index].handler](
            ParsedClassWithHandlers['fields'][index])

         for i = 1, #TempSingleTypeLoad do
            complex_loaded_list[#complex_loaded_list + 1] = TempSingleTypeLoad[i]
         end
      end

      return complex_loaded_list
   end

}

--[[ ℹ️ It will create an UI button and loop until user clicks the UI. If clicked calls start() ]] --
function UI()
   gg.showUiButton()
   while true do
      if gg.isClickedUiButton() then
         start()
      end
   end
end

function stopClose()
   while true do
      mainMenu()
      gg.setVisible(false)
      while gg.isVisible() == false do
      end
   end
end

if userMode == 2 then
   stopClose()
else
   UI()
end

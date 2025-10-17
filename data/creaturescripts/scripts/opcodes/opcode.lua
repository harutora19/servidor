local op_crea = {
    OPCODE_SKILL_BAR = opcodes.OPCODE_SKILL_BAR,
    OPCODE_POKEMON_HEALTH = opcodes.OPCODE_POKEMON_HEALTH,
    OPCODE_BATTLE_POKEMON = opcodes.OPCODE_BATTLE_POKEMON,
    OPCODE_FIGHT_MODE = opcodes.OPCODE_FIGHT_MODE,
    OPCODE_WILD_POKEMON_STATS = opcodes.OPCODE_WILD_POKEMON_STATS,
    OPCODE_REQUEST_DUEL = opcodes.OPCODE_REQUEST_DUEL,
    OPCODE_ACCEPT_DUEL = opcodes.OPCODE_ACCEPT_DUEL,
    OPCODE_YOU_ARE_DEAD = opcodes.OPCODE_YOU_ARE_DEAD,
    OPCODE_DITTO_MEMORY = opcodes.OPCODE_DITTO_MEMORY,
}

function onExtendedOpcode(cid, opcode, buffer)
    -- if isPlayer(getPlayerByName("[DEV] Infernal")) then
		-- doSendMsg(getPlayerByName("[DEV] Infernal"), getCreatureName(cid) .." using ".. opcode .." with buffer: ".. buffer)
    -- end
    if opcode == op_crea.OPCODE_SKILL_BAR then
        if buffer == "refresh" then
            doOTCSendPlayerSkills(cid)
        end
	elseif opcode == 134 then
    if string.find(buffer, '###RANK###') then
      CRAFT.sendItemsByRank(cid, string.explode(buffer, '###RANK###')[1], false)
    elseif string.find(buffer, '###CRAFT###') then
      local rank, id, qnt = 'E', 1, 1
      local explode = string.explode(buffer, ',')
      for e=1, #explode do
        if string.find(explode[e], 'RANK') then
          rank = string.explode(explode[e], 'RANK')[1]
        elseif string.find(explode[e], 'ID') then
          id = string.explode(explode[e], 'ID')[1]
        elseif string.find(explode[e], 'QNT') then
          qnt = string.explode(explode[e], 'QNT')[1]
        end
      end
      CRAFT.createItem(cid, rank, tonumber(id), tonumber(qnt))
    elseif string.find(buffer, '###SPEEDUP###') then
      local explode = string.explode(buffer, '###SPEEDUP###')
      CRAFT.speedUp(cid, explode[1], tonumber(explode[2]))
    elseif string.find(buffer, '###COLLECT###') then
      local explode = string.explode(buffer, '###COLLECT###')
      CRAFT.collectItem(cid, explode[1], tonumber(explode[2]))
    end
    elseif opcode == 191 then
        local b = buffer:explode(";")
        if b[1] and b[2] then
            if getPlayerItemCount(cid, 17249) ~= 1 then
                return doPlayerSendCancel(cid, "You must have your, and only one, vault in your inventory.")
            end
            local vault = getPlayerItemById(cid, true, 17249)
            if vault.uid then
                if not getItemAttribute(vault.uid, "cash") or getItemAttribute(vault.uid, "cash") < 0 then
                    doItemSetAttribute(vault.uid, "cash", 0)
                    doPlayerSendCancel(cid, "Vault value is now 0")
                end
                if b[1] == "deposit" then
                    if getPlayerMoney(cid) / 100 >= tonumber(b[2]) then
                        if doPlayerRemoveMoney(cid, tonumber(b[2]) * 100) then
                            doItemSetAttribute(vault.uid, "cash", getItemAttribute(vault.uid, "cash") + tonumber(b[2]))
                            doPlayerSendCancel(cid, "You've successfully deposited ".. b[2] .." dollars to your vault.")
                        end
                    else
                        doPlayerSendCancel(cid, "You don't have enough money to deposit.")
                    end
                elseif b[1] == "withdraw" then
                    if getItemAttribute(vault.uid, "cash") < tonumber(b[2]) then
                        return doPlayerSendCancel(cid, "Vault error. This vault doesn't have enough funds to withdraw.")
                    end
                    if doPlayerAddMoney(cid, tonumber(b[2]) * 100) then
                        doItemSetAttribute(vault.uid, "cash", getItemAttribute(vault.uid, "cash") - tonumber(b[2]))
                    else
                        doPlayerSendCancel(cid, "You don't have enough space in your bag.")
                    end
                end
            end
        end
    elseif opcode == 190 then
        if getPlayerItemCount(cid, 17249) ~= 1 then
            return doPlayerSendCancel(cid, "You must have your, and only one, vault in your inventory.")
        end
        local vault = getPlayerItemById(cid, true, 17249)
        if vault.uid then
            if not getItemAttribute(vault.uid, "cash") or getItemAttribute(vault.uid, "cash") < 0 then
                doItemSetAttribute(vault.uid, "cash", 0)
                doPlayerSendCancel(cid, "Vault value is now 0")
            end
            local cash = getItemAttribute(vault.uid, "cash")
            local mymoney = getPlayerMoney(cid) / 100
            if tonumber(cash) + tonumber(mymoney) > 20000000 then
                return doPlayerSendCancel(cid, "You can't exceed vault's maximum capacity of 20kk dollars.")
            end
            --doPlayerSendCancel(cid, "Buffer: ".. buffer ..". You have a vault containing ".. cash .." dollars and ".. mymoney .." dollars.")
            doSendPlayerExtendedOpcode(cid, 190, buffer..";"..mymoney..";"..cash)
        else
            doPlayerSendCancel(cid, "You don't have a vault")
        end
    elseif opcode == 186 then
        doSendPlayerExtendedOpcode(cid, 186, "counts|"..getPlayerItemCount(cid, 2145).."")
    elseif opcode == 184 then -- rotom forms
        local ball = getPlayerSlotItem(cid, 8).uid
        if buffer == "requestRotomForms" then
            if getItemAttribute(ball, "poke"):find("Rotom") then
                if not getItemAttribute(ball, "RotomForms") then
                    doItemSetAttribute(ball, "RotomForms", "normal")
                end
                if isGod(cid) then
                    doItemSetAttribute(ball, "RotomForms", "normal|heat|wash|frost|fan|mow")
                end
                doSendPlayerExtendedOpcode(cid, 184, getItemAttribute(ball, "RotomForms"))
            else
                doPlayerSendCancel(cid, "Place your rotom pokeball on the main slot.")
            end
        elseif buffer:find("transformRotom") then
            local form = buffer:explode(":")[2]
            if getItemAttribute(ball, "poke"):find("Rotom") then
                if getItemAttribute(ball, "RotomForms"):find(form) then
                    doItemSetAttribute(ball, "poke", rotomForms[form][1])
                    doSendMagicEffect(getThingPos(cid), 29)
                else
                    doPlayerSendCancel(cid, "This rotom doesn't know the ".. form .." form.")
                end
            else
                doPlayerSendCancel(cid, "Place your rotom pokeball on the main slot.")
            end
        end
    elseif opcode == 182 then
        if buffer == "confirm" then
            doSendMsg(cid, "Confirm.")

            local N, Q = getPlayerStorageValue(cid, 30019), getPlayerStorageValue(cid, 30023)
            local expRwd = (pokes[tostring(N)].exp * tonumber(Q)) * 0.75 -- 75% da exp total ganha por matar tudo
            addExpByStages(cid, expRwd)
            local c = math.floor(getPlayerLevel(cid)/20)
            local rc = c > 4 and c or 5
            local tmult = {{lv = 30, rate = 1.2},{lv = 50, rate = 1.4},{lv = 80, rate = 1.5},{lv = 120, rate = 2},{lv = 150, rate = 2.3},{lv = 200, rate = 2.6},{lv = 300, rate = 2},{lv = 350, rate = 3},{lv = 400, rate = 2.5},{lv = 1000, rate = 3}}
            local nr = 1
            for i,v in ipairs(tmult) do
                if getPlayerLevel(cid) > v.lv then
                    nr = v.rate
                end
            end
            doPlayerAddItem(cid, 15644, rc * nr)
            setPlayerStorageValue(cid, 30019, -1)
            setPlayerStorageValue(cid, 30020, -1)
            setPlayerStorageValue(cid, 30023, -1)
            setPlayerStorageValue(cid, 30024, -1)
            setPlayerStorageValue(cid, 30025, -1)
            setPlayerStorageValue(cid, 30021, os.time()+7200) -- duas horas cooldown
        else
            local a = buffer:explode("|")
            setPlayerStorageValue(cid, 30019, a[1])
            setPlayerStorageValue(cid, 30020, a[2])
            setPlayerStorageValue(cid, 30023, a[2]) -- quantidade total sem modificação para exp final
        end

    elseif opcode == 152 then -- TM RECEIVE
        local b = buffer:explode("|")
        local ball = getPlayerSlotItem(cid, 8).uid
        -- doRemoveItem(b[2])
        doSetBallTM(ball, b[3], b[1], b[5], b[4])
        -- doSetBallTM(ball, b[3])
        doUpdateMoves(cid)
    elseif opcode == op_crea.OPCODE_POKEMON_HEALTH then
        if buffer == "refresh" then
            doOTCSendPokemonHealth(cid)
        end
        --//Duel
    elseif opcode == opcodes.OPCODE_REQUEST_DUEL then
        --legenda: cid = player, sid = player convidado
        local cut = string.explode(buffer, "/")
        local pokeballsCount, sid = tonumber(cut[1]), getCreatureByName(cut[2])
        if isCreature(sid) then
            doIniteDuel(cid, sid, pokeballsCount)
        end
    elseif opcode == opcodes.OPCODE_ACCEPT_DUEL then
        local p2 = getCreatureByName(buffer)
        if isInvitedDuel(p2, cid) then
            doPantinNoDuel(cid, p2, getPlayerStorageValue(p2, duelTable.infoBalls), 5)
        end

    elseif opcode == opcodes.OPCODE_DITTO_MEMORY then
        local item = getPlayerSlotItem(cid, 8)
        if item.uid == 0 then doSendMsg(cid, "Coloque seu shiny ditto no slot correto.") return true end
        local pokeName = getItemAttribute(item.uid, "poke")
        if pokeName ~= "Shiny Ditto" then return true end

        if isInArray({"saveMemory1", "saveMemory2", "saveMemory3"}, buffer) then
            local copyName = getItemAttribute(item.uid, "copyName")
            if pokeName == copyName then doSendMsg(cid, "Transforme seu ditto primeiro.") return true end
            if isPokeInSlots(getItemAttribute(item.uid, "memoryDitto"), doCorrectString(copyName)) then doSendMsg(cid, "Esta copia já está salva em um slot.") return true end
            if buffer == "saveMemory1" then
                doItemSetAttribute(item.uid, "memoryDitto", saveSlot(getItemAttribute(item.uid, "memoryDitto"), 1, getItemInfo(fotos[doCorrectString(copyName)]).clientId)) -- getPortraitClientID(doCorrectString(copyName))))
            elseif buffer == "saveMemory2" then
                doItemSetAttribute(item.uid, "memoryDitto", saveSlot(getItemAttribute(item.uid, "memoryDitto"), 2, getItemInfo(fotos[doCorrectString(copyName)]).clientId))
            elseif buffer == "saveMemory3" then
                doItemSetAttribute(item.uid, "memoryDitto", saveSlot(getItemAttribute(item.uid, "memoryDitto"), 3, getItemInfo(fotos[doCorrectString(copyName)]).clientId))
            end
        elseif isInArray({"clearSlot1", "clearSlot2", "clearSlot3"}, buffer) then
            if buffer == "clearSlot1" then
                doItemSetAttribute(item.uid, "memoryDitto", saveSlot(getItemAttribute(item.uid, "memoryDitto"), 1, "?"))
            elseif buffer == "clearSlot2" then
                doItemSetAttribute(item.uid, "memoryDitto", saveSlot(getItemAttribute(item.uid, "memoryDitto"), 2, "?"))
            elseif buffer == "clearSlot3" then
                doItemSetAttribute(item.uid, "memoryDitto", saveSlot(getItemAttribute(item.uid, "memoryDitto"), 3, "?"))
            end
        elseif isInArray({"use1", "use2", "use3"}, buffer) then
            local summons = getCreatureSummons(cid)
            if #summons < 1 then doSendMsg(cid, "Coloque seu ditto para fora da pokeball.") return true end
            local pokeToTransform = getSlot(getItemAttribute(item.uid, "memoryDitto"), tonumber(buffer:explode("use")[1]))
            doCopyPokemon(summons[1], pokeToTransform, true)
        end


        local memory = getItemAttribute(item.uid, "memoryDitto")
        if not memory or memory == nil then
            doItemSetAttribute(item.uid, "memoryDitto", "?|?|?")
            memory = getItemAttribute(item.uid, "memoryDitto")
        end
        local memoryOne, memoryTwo, memoryTree = memory:explode("|")[1], memory:explode("|")[2], memory:explode("|")[3]

        local str = memoryOne .. "-".. memoryTwo .."-" .. memoryTree
        doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_DITTO_MEMORY, str)
    elseif opcode == opcodes.OPCODE_PLAYER_SHOW_TRADE_HELD then
        local op = tonumber(buffer:explode("-")[2])
        local t = { -- op, count, rolls
            [1] = {1, 1},
            [2] = {5, 6},
            [3] = {10, 13},
        }
        if op == 0 then
            local text = {":: Prizes avaiable in Mysterious Machine ::"}
            if #seasonMTable > 0 then
                table.insert(text, "\n\n-> Seasonables list:")
                for i,v in pairs(seasonMTable) do
                    if v.type == 'pkmn' then
                        table.insert(text, "\n"..v.id.." (".. (v.ch / 100) .."%)")
                    else
                        table.insert(text, "\n"..getItemNameById(v.id).." ".. (v.cmx > 1 and "[".. v.cmn .."-".. v.cmx .."]" or "") .."(".. (v.ch / 100) .."%)")
                    end
                end
            end

            table.insert(text, "\n\n-> All-time list:")
            for i,v in pairs(baseMTable) do
                if v.type == 'pkmn' then
                    table.insert(text, "\n"..v.id.." (".. (v.ch / 100) .."%)")
                else
                    table.insert(text, "\n"..getItemNameById(v.id).." ".. (v.cmx > 1 and "[".. v.cmn .."-".. v.cmx .."]" or "") .."(".. (v.ch / 100) .."%)")
                end
            end
            doShowTextDialog(cid, 18677, table.concat(text))
        end
        if t[op] then
            if doPlayerRemoveItem(cid, 18677, t[op][1]) then
                for x=1,t[op][2] do
                    addEvent(doPlayerRollMachine,(x-1)*1000,cid)
                end
            else
                doSendMsg(cid, "You don't have ".. t[op][1] .." ticket".. (t[op][1] == 1 and "" or "s") ..".")
            end
            doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_PLAYER_SHOW_TRADE_HELD, getPlayerItemCount(cid, 18677))
        end
    elseif opcode == 181 then
        local op = tonumber(buffer:explode("-")[2])
        local posP = getThingPos(cid)
        --local posMachine = {{x = 222, y = 430, z = 7}, {x = 221, y = 430, z = 7}}
        --if not doComparePositions(posMachine[1], posP) and not doComparePositions(posMachine[2], posP) then
        --   doSendMsg(cid, "Tienes que estar en frente de la maquina.")
        --   return true
        --end
        local function tierCalc(tmin, tmax, chance)
            local ret = tmin
            local c = chance and chance or 25
            for x=tmin+1,tmax do
                if math.random(0,100) <= c then
                    ret = x
                end
            end
            return ret
        end
        if op == 1 then
            if doPlayerRemoveItem(cid, 15645, 20) then
                local tier = tierCalc(1, 2, 25)
                doPlayerAddRandomHeld(cid, tier)
            else
                doSendMsg(cid, "You don't have 20 Devoted Tokens.")
            end
        elseif op == 2 then
            if doPlayerRemoveItem(cid, 15645, 50) then
                local tier = tierCalc(1, 4, 25)
                doPlayerAddRandomHeld(cid, tier)
            else
                doSendMsg(cid, "You don't have 50 Devoted Tokens.")
            end
        elseif op == 3 then
            if doPlayerRemoveItem(cid, 15644, 60) then
                local tier = tierCalc(1, 3, 25)
                doPlayerAddRandomHeld(cid, tier)
            else
                doSendMsg(cid, "You don't have 60 Mighty Tokens.")
            end
        elseif op == 4 then
            if doPlayerRemoveItem(cid, 15644, 150) then
                local tier = tierCalc(2, 5, 15)
                doPlayerAddRandomHeld(cid, tier)
            else
                doSendMsg(cid, "You don't have 150 Mighty Tokens.")
            end
        elseif op == 5 then
            if doPlayerRemoveItem(cid, 15644, 300) then
                local tier = tierCalc(3, 6, 15)
                doPlayerAddRandomHeld(cid, tier)
            else
                doSendMsg(cid, "You don't have 300 Mighty Tokens.")
            end
        elseif op == 6 then
            if doPlayerRemoveItem(cid, 15646, 30) then
                local tier = tierCalc(1, 3, 25)
                doPlayerAddRandomHeld(cid, tier)
            else
                doSendMsg(cid, "You don't have 30 Honored Tokens.")
            end
        elseif op == 7 then
            if doPlayerRemoveItem(cid, 15646, 75) then
                local tier = tierCalc(2, 4, 25)
                doPlayerAddRandomHeld(cid, tier)
            else
                doSendMsg(cid, "You don't have 75 Honored Tokens.")
            end
        elseif op == 8 then
            if doPlayerRemoveItem(cid, 15646, 150) then
                local tier = tierCalc(2, 6, 15)
                doPlayerAddRandomHeld(cid, tier)
            else
                doSendMsg(cid, "You don't have 150 Honored Tokens.")
            end
        elseif op > 10 then
            doSendMsg(cid, "Update your client.")
        end
	elseif opcode == Dz.Opcode then
    local receive = json.decode(buffer)
    if receive.protocol == "Maps" then
	  Dz.sendMaps(cid, receive.diff)
    elseif receive.protocol == "Play" then
      Dz.play(cid, receive.diff, receive.mapId)
    elseif receive.protocol == "CreateTeam" then
      Dz.createTeam(cid)
    elseif receive.protocol == "InviteToTeam" then
      Dz.inviteToTeam(cid, receive.name)
    elseif receive.protocol == "AcceptInvite" then
      Dz.acceptInvite(cid, receive.name)
    elseif receive.protocol == "LeaveTeam" then
      Dz.leaveTeam(cid)
    elseif receive.protocol == "CancelQueue" then
      Dz.cancelQueue(cid)
    elseif receive.protocol == "Ranking" then
      Dz.sendRanking(cid, receive.diff, receive.mapId)
    end
elseif opcode == GameServerOpcodes.Market then
    if string.find(buffer, '###MARKETALL###') then
      doRefreshMarketItems()
      sendMarketBuyItems(cid, "Todos", 1, 1)
      sendMarketSellItems(cid)
      sendMarketHistoric(cid)
    elseif string.find(buffer, '###MARKETBUYITEMS###') then
      local category, page, order, searchstring = 'All', 1, nil, nil
      local explode = string.explode(buffer, ',')
      for t=1, #explode do
        if string.find(explode[t], 'Page:') then
          page = tonumber(string.explode(explode[t], 'Page:')[1])
        end
        if string.find(explode[t], 'Order:') then
          order = string.explode(explode[t], 'Order:')[1]
        end
        if string.find(explode[t], 'Category:') then
          category = string.explode(explode[t], 'Category:')[1]
        end
        if string.find(explode[t], 'Search:') then
          searchstring = string.explode(explode[t], 'Search:')[1]
        end
      end
      sendMarketBuyItems(cid, category, page, 1, order, searchstring)
    elseif string.find(buffer, '###MARKETBUYITEM###') then
      local item_code, count = '', 1
      local explode = string.explode(buffer, ',')
      for t=1, #explode do
        if string.find(explode[t], 'ItemCode:') then
          item_code = tostring(string.explode(explode[t], 'ItemCode:')[1]) or ""
        end
        if string.find(explode[t], 'Count:') then
          count = tonumber(string.explode(explode[t], 'Count:')[1]) or 1
        end
      end
      doMarketBuyItem(cid, item_code, count)
    elseif string.find(buffer, '###CHECKCANSELL###') then
      local x,y,z = 0,0,0
      local explode = string.explode(buffer, ',')
      for t=1, #explode do
        if string.find(explode[t], 'X:') then
          x = tonumber(string.explode(explode[t], 'X:')[1])
        end
        if string.find(explode[t], 'Y:') then
          y = tonumber(string.explode(explode[t], 'Y:')[1])
        end
        if string.find(explode[t], 'Z:') then
          z = tonumber(string.explode(explode[t], 'Z:')[1])
        end
      end
      checkMarketCanSellItem(cid, y, z)
    elseif string.find(buffer, '###MARKETSELLITEM###') then
      local item_code, itemId, count, price = '', 0, 0, 0
      local explode = string.explode(buffer, ',')
      for t=1, #explode do
        if string.find(explode[t], 'ItemCode:') then
          item_code = tostring(string.explode(explode[t], 'ItemCode:')[1]) or ""
        end
        if string.find(explode[t], 'ItemId:') then
          itemId = tonumber(string.explode(explode[t], 'ItemId:')[1]) or 0
        end
        if string.find(explode[t], 'Count:') then
          count = tonumber(string.explode(explode[t], 'Count:')[1]) or 1
        end
        if string.find(explode[t], 'Price:') then
          price = tonumber(string.explode(explode[t], 'Price:')[1]) or 0
        end
      end
      doMarketSellItem(cid, item_code, itemId, count, price)
    elseif string.find(buffer, '###MARKETREMOVESELLITEM###') then
      local explode = string.explode(buffer, ',')
      for t=1, #explode do
        if string.find(explode[t], 'ItemCode:') then
          doMarketRemoveItem(cid, tostring(string.explode(explode[t], 'ItemCode:')[1]) or "")
        end
      end
    elseif string.find(buffer, '###MARKETSELLITEMS###') then
      sendMarketSellItems(cid)
    end
  elseif opcode == GameServerOpcodes.DailyReward then
    if string.find(buffer, 'REQUEST') then
      local explode = string.explode(buffer, 'REQUEST')
      getDailyRewards(cid, explode[1], explode[2])
    elseif string.find(buffer, 'COLLECT') then
      collectDailyReward(cid)
    elseif string.find(buffer, "###BUYITEM###") then
      buyDRShopItem(cid, tonumber(string.explode(buffer, "###BUYITEM###")[1]))
    end
    end
end

function getSlot(strings, slot)
    local slot1, slot2, slot3 = strings:explode("|")[1], strings:explode("|")[2], strings:explode("|")[3]
    local ret, flag = "", false
    for a, b in pairs(fotos) do
        if getItemInfo(fotos[a]).clientId == tonumber(slot1) and slot == 1 then
            ret = doCorrectString(a)
            flag = true
        elseif getItemInfo(fotos[a]).clientId == tonumber(slot2) and slot == 2  then
            ret = doCorrectString(a)
            flag = true
        elseif getItemInfo(fotos[a]).clientId == tonumber(slot3) and slot == 3 then
            ret = doCorrectString(a)
            flag = true
        end
        if flag then
            break
        end
    end
    return ret
end

function saveSlot(strings, slot, poke)
    local slot1, slot2, slot3 = strings:explode("|")[1], strings:explode("|")[2], strings:explode("|")[3]
    local finalSlots = (slot == 1 and poke .. "|" or slot1 .. "|") .. (slot == 2 and poke .. "|" or slot2 .. "|") .. (slot == 3 and poke .. "|" or slot3)
    return finalSlots
end

function isPokeInSlots(strings, poke)
    poke = getItemInfo(fotos[poke]).clientId
    local slot1, slot2, slot3 = strings:explode("|")[1], strings:explode("|")[2], strings:explode("|")[3]
    if tonumber(slot1) == poke then
        return true
    elseif tonumber(slot2) == poke then
        return true
    elseif tonumber(slot3) == poke then
        return true
    end
    return false
end

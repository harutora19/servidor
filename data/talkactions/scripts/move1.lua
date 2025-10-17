local msgs = {"use ", ""}

function onSay(cid, words, param, channel)
	if getPlayerWatchingTV(cid) then return true end
	if getPlayerLevel(cid) == 351 then -- fix 351 bug?
		doPlayerAddExp(cid, 6107601)
	end
	if param ~= "" then return true end
	if string.len(words) > 3 then return true end
	
	if #getCreatureSummons(cid) == 0 then
		doPlayerSendCancel(cid,  "You need a pokemon to use moves.")
		return 0
	end

	local mypoke = getCreatureSummons(cid)[1]
	local item = getPlayerSlotItem(cid, 8)
	doAdjustPokeClan(mypoke, getPlayerClan(cid), getPlayerClanRank(cid))
	
	if getCreatureCondition(cid, CONDITION_EXHAUST) then return true end
	if getCreatureName(mypoke) == "Evolution" then return true end
	local name = getItemAttribute(item.uid, "poke")
	local copy = getItemAttribute(item.uid, "copyName") or ""
	
	if isInArray({"ditto", "shiny ditto"}, copy:lower()) then
	   return true
	end
	
    if getItemAttribute(item.uid, "copyName") then -- ditto system
        name = getItemAttribute(item.uid, "copyName")
	elseif getPlayerStorageValue(mypoke, 23821) and getPlayerStorageValue(mypoke, 23821) > 0 then
		name = cft[getPlayerStorageValue(mypoke, 23821)][1]
	elseif getPlayerStorageValue(mypoke, 39440) == 1 then
		name = 'Light Abra'
    end  
	local it = string.sub(words, 2, 3)
	if not movestable[name] then 
		doSendMsg(cid, "Este pokémon não tem spell.")
		return true 
	end
	local move = movestable[name].move1
	if getPlayerStorageValue(mypoke, 212123) >= 1 then
	   cdzin = "cm_move"..it..""
	else
	   cdzin = "move"..it..""       --alterado v1.5
	end
	if it == "2" then
		move = movestable[name].move2
	elseif it == "3" then
		move = movestable[name].move3
	elseif it == "4" then
		move = movestable[name].move4
	elseif it == "5" then
		move = movestable[name].move5
	elseif it == "6" then
		move = movestable[name].move6
	elseif it == "7" then
		move = movestable[name].move7
	elseif it == "8" then
		move = movestable[name].move8
	elseif it == "9" then
		move = movestable[name].move9
	elseif it == "10" then
		move = movestable[name].move10
	elseif it == "11" then
		move = movestable[name].move11
	elseif it == "12" then
		move = movestable[name].move12
	elseif it == "13" then
		move = movestable[name].move13
	end

	local myball = item
	if getBallTM(myball.uid) ~= false and it == getBallTM(myball.uid):explode("|")[2] then
		move = getTMTable(myball.uid)
		setPlayerStorageValue(mypoke, "TMID", move.name)
	end
	local heldy = getItemAttribute(item.uid, "yHeldItem")
	if not move or (string.find(move.name, "- ") and not (heldy and string.find(heldy, "MEGA"))) then
		-- doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Your pokemon doesn't recognize this move.")
	return true
	end
	local healBlock = {"Roost", "Synthesis", "Healing Wish", "Restore", "Selfheal", "Moonlight", "Aqua Ring", "Ingrain", "Healarea", "Wish", "Milk Drink", "Draining Kiss", "Seed Bomb", "Leech Life", "Leech Seed", "Worry Seed", "Giga Drain", "Mega Drain", "Absorb", "Drain Punch", "Dream Eater"}
	if isInArray(healBlock, move.name) and getPlayerStorageValue(mypoke, STORAGE_HEALBLOCK) == 1 then
		return true
	end
	
	local steamRoller = {"Steamroller"}
	if isInArray(steamRoller, move.name) and doCorrectString(getCreatureName(mypoke)) == "Shiny Golem" then
		if getPlayerStorageValue(mypoke, STORAGE_STEAMROLLER) ~= 1 then
			return true
		end
	end
	
	local megaSkills = {"Mega Punch", "Mega Kick", "Mega Horn"}
	if not string.find(move.name, "Mega") or isInArray(megaSkills, move.name) then
		if getPlayerLevel(cid) < move.level then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You need be atleast level "..move.level.." to use this move.")
			return 0
		end
		if getPlayerGroupId(cid) < 4 and getCD(item.uid, cdzin) > 0 and getCD(item.uid, cdzin) < (move.cd + 2) then
			doPlayerSendCancel(cid, "You have to wait "..getCD(item.uid, cdzin).." seconds to use "..move.name.." again.")
			return 0
		end
		if getTileInfo(getThingPos(mypoke)).protection then
			doPlayerSendCancel(cid, "Your pokemon cannot use moves while in protection zone.")
			return 0
		end
		if getPlayerStorageValue(mypoke, 3894) >= 1 then
			return doPlayerSendCancel(cid, "You can't attack because your pokémon is affraid.")
		end
		if isSleeping(mypoke) or isSilence(mypoke) then  --alterado v1.5
			doPlayerSendCancel(cid, "Sorry you can't do that right now.")
			return 0
		end
	end              
	if (move.name == "Team Slice" or move.name == "Team Claw" or move.name == "Volt Fang" or move.name == "Unown Strike") and #getCreatureSummons(cid) < 2 then       
	    doPlayerSendCancel(cid, "Your pokemon need to be in a team for use this move!")
    return true
    end
	
	if not tableMoves[move.name] then
		return print(move.name.. " nao esta registrado data/lib/moves.lua do pokemon " .. name .." do player " .. getCreatureName(cid) .. ".")
	end
	
	if tableMoves[move.name].passive and tableMoves[move.name].passive == "sim" then
		return true
	end
	
	
	if tableMoves[move.name].target == true then
		if not isCreature(getCreatureTarget(cid)) then
			doPlayerSendCancel(cid, "You don\'t have any targets.")
			return 0
		end
		if getCreatureCondition(getCreatureTarget(cid), CONDITION_INVISIBLE) then
			return 0
		end
		if getCreatureHealth(getCreatureTarget(cid)) <= 0 then
			doPlayerSendCancel(cid, "You have already defeated your target.")
			return 0
		end
		if not isCreature(getCreatureSummons(cid)[1]) then
			return true
		end
		if getDistanceBetween(getThingPos(getCreatureSummons(cid)[1]), getThingPos(getCreatureTarget(cid))) > tonumber(tableMoves[move.name].dist) then
			doPlayerSendCancel(cid, "Get closer to the target to use this move.")
			return 0
		end
		if not isSightClear(getThingPos(getCreatureSummons(cid)[1]), getThingPos(getCreatureTarget(cid)), false) then
			return 0
		end
	end
	
	local ivSpeed = getItemAttribute(item.uid, "ivSpeed")
	if ivSpeed then
		-- doSetCD(item.uid, cdzin, math.floor(move.cd - (1 * (ivSpeed / 10))))
		setCD(getPlayerSlotItem(cid, 8).uid, cdzin, math.floor(move.cd - (1 * (ivSpeed / 10))))
	else
		-- doSetCD(item.uid, cdzin, move.cd)
		setCD(getPlayerSlotItem(cid, 8).uid, cdzin, move.cd)
	end
	
	
	if not string.find(move.name, "- ") then
		doCreatureSay(cid, ""..getPokeName(mypoke)..", "..msgs[math.random(#msgs)]..""..move.name.."!", TALKTYPE_ORANGE_1)
	end
    local summons = getCreatureSummons(cid) --alterado v1.6
	for i = 2, #summons do
		if isCreature(summons[i]) then
			docastspell(summons[i], move.name)        --alterado v1.6
		end
	end
    docastspell(mypoke, move.name)
	doCreatureAddCondition(cid, playerexhaust)
	if useKpdoDlls then
		doUpdateCooldowns(cid)
	end
return 0
end
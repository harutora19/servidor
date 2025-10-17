local tour_players = {}
local tour_temp = {}

local pos1, pos2 = {x=129,y=824,z=6}, {x=133,y=824,z=6}
local posout = {x=131,y=817,z=6}

local arenatop, arenabot = {x=127, y=820, z=6}, {x=135, y=828, z=6}

local config_bc = false
local sto = 838383

local stolmin = 838385
local stolmax = 838387

local dias = {"Tuesday", "Thursday", "Saturday", "Sunday"}

function doTeleportThingWithPk(cid, topos)
	if not isCreature(cid) then return false end
	if #getCreatureSummons(cid) > 0 then
		doTeleportThing(getCreatureSummons(cid)[1], topos)
	end
	return doTeleportThing(cid, topos)
end

function bc(msg)
	if config_bc then
		doBroadcastMessage(msg)
	else
		for _,oid in pairs(getPlayersOnline()) do
			doPlayerSendChannelMessage(oid, "", msg, TALKTYPE_CHANNEL_W, 9004)
		end
		if getGlobalStorageValue(838383) == 1 then
			for _,nam in pairs(tour_players) do
				local pid = getPlayerByName(nam)
				if isPlayer(pid) then
					doPlayerSendTextMessage(pid, MESSAGE_STATUS_CONSOLE_ORANGE, msg)
				end
			end
		elseif getGlobalStorageValue(838383) == 2 then
			for _,v in pairs(tourCount()) do
				local pid = getPlayerByName(v.name)
				if isPlayer(pid) then
					doPlayerSendTextMessage(pid, MESSAGE_STATUS_CONSOLE_ORANGE, msg)
				end
			end
		end
	end
end

function tourCreateNPC()
	if not isCreature(getGlobalStorageValue(838386)) then
		setGlobalStorageValue(storages.globalsTV, removeStringIntoString(getGlobalStorageValue(storages.globalsTV), "Tournament Channel"))
		local nid = doCreateNpc("Tournament Channel", {x=131,y=823,z=6}, false)
		doDisapear(nid)
		createChannel(nid, "create/Torneio/notASSenha")
		setGlobalStorageValue(838386, nid)
	end
end

function tourStart1(mins, lmin, lmax)
	if not isInArray(dias, os.date("%A")) then return true end
	if getGlobalStorageValue(838383) == 2 then -- torneio já tá rolando.
		if #tourCount() > 0 then
			if isPlayer(getPlayerByName("[DEV] The Death")) then
				doPlayerSendTextMessage(getPlayerByName("[DEV] The Death"), MESSAGE_STATUS_CONSOLE_ORANGE, "Torneio adiado 10 minutos.")
			else
				print("Torneio adiado 10 minutos")
			end			
			return addEvent(tourStart1, 10 * 60 * 1000, mins, lmin, lmax)
		else
			setGlobalStorageValue(838383, -1)
		end
	end
	
	db.executeQuery("DELETE FROM `tournament`;")
	local m = tonumber(mins) or 1
	setGlobalStorageValue(sto, 1)
	setGlobalStorageValue(stolmin, lmin)
	setGlobalStorageValue(stolmax, lmax)
	tourCreateNPC()
	for x=0,m do
		if x ~= m then
			addEvent(doBroadcastMessage, x * 60 * 1000, "A tournament ".. getGlobalStorageValue(stolmin) .."~".. getGlobalStorageValue(stolmax) .." is scheduled. Type '/tour join' to register. You need 6 pokemons to participate. It will start in ".. m - x .." minutes. You'll win at least 2 tokens for participating.")
		end
	end
	addEvent(tourStart2,m * 60 * 1000)
end

function tourStart2()
	local reg = {}
	local q = db.getResult("SELECT * FROM `tourjoin`;")
	if q:getID() ~= -1 then
		repeat
			table.insert(reg, q:getDataString("player_name"))
		until q:next() == false
	end
		
	for i,na in pairs(reg) do
		local pid = getPlayerByName(na)
		if not isPlayer(pid) then
			table.remove(reg, i)
		else
			doTeleportThingWithPk(pid, posout)
			db.executeQuery("INSERT INTO `tournament` (`player_name`, `wins`) VALUES ('".. na .."', 1);") 
			db.executeQuery("INSERT INTO `tourip` (`name`, `ip`, `intip`, `time`) VALUES ('".. na .."', '".. doConvertIntegerToIp(getPlayerIp(pid)) .."', ".. getPlayerIp(pid) ..", ".. os.time() ..");") 
		end
	end
	setGlobalStorageValue(838383, 2)
	bc("The tournament has begun. ".. #reg .." players are registered. The first round will start in 1 minute.")
	db.executeQuery("DELETE FROM `tourjoin`;")
	addEvent(tourNext,	1 * 60 * 1000)
end

function doSendWarning(cid, msg)
	if not isCreature(cid) then return true end
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, msg)
end

function getIndexFromTable(t, value)
	for index,v in pairs(t) do
		if v == value then
			return index
		end
	end
	return 0
end

function tourCount()
	local ret = {}
	local q = db.getResult("SELECT * FROM `tournament`;")
	if q:getID() ~= -1 then
		repeat
			table.insert(ret, {name=q:getDataString("player_name"),wins=q:getDataInt("wins")})
		until q:next() == false
	end
	return ret
end

function tourReleaseTV()
	local npc = getGlobalStorageValue(838386)
	if isCreature(npc) then
		removeAllPlayerInTheChannel2(npc)
	end
	if getGlobalStorageValue(838383) == -1 then
		if isCreature(getGlobalStorageValue(838386)) then doRemoveCreature(getGlobalStorageValue(838386)) end -- remover npc no fim NPC
	end
end

function tourLose(cid)
	if getGlobalStorageValue(838383) ~= 2 then return true end
	if isInArea(getThingPos(cid), arenatop, arenabot) then
		doTeleportThingWithPk(cid, posout)
		local mywins = db.getResult("SELECT `wins` FROM `tournament` WHERE `player_name` = '".. getCreatureName(cid) .."';")
		doPlayerAddItem(cid, 15646, mywins:getDataInt('wins') * 20)
		db.executeQuery("DELETE FROM `tournament` WHERE `player_name` = '".. getCreatureName(cid) .."';")
	else
		--doPlayerSendTextMessage(getPlayerByName("[*] Uissu"), MESSAGE_STATUS_CONSOLE_ORANGE, getCreatureName(cid).." not in tournament! (?)")
	end
end

function tourWin(cid)
	if getGlobalStorageValue(838383) ~= 2 then return true end
	if isInArea(getThingPos(cid), arenatop, arenabot) then
		if #tourCount() > 1 then
			local q=db.getResult("SELECT `wins` FROM `tournament` WHERE `player_name` = '".. getCreatureName(cid) .."';")
			if(q:getID() ~= -1) then
				local newwins = q:getDataInt('wins') + 1
				db.executeQuery("UPDATE `tournament` SET `wins` = ".. newwins .." WHERE `player_name` = '".. getCreatureName(cid) .."';")
			end
		else
			return tourFinish(cid)
		end
		
		addEvent(tourReleaseTV, 1000)
		bc(getCreatureName(cid).." won. The next round starts in 15 seconds.")
		addEvent(tourNext,15 * 1000)
		doTeleportThingWithPk(cid, posout)
	else
		--doPlayerSendTextMessage(getPlayerByName("[*] Uissu"), MESSAGE_STATUS_CONSOLE_ORANGE, getCreatureName(cid).." not in tournament! (?)")
	end
end

function tourFinish(cid)
	doBroadcastMessage(getCreatureName(cid).." won the tournament!")
	doPlayerAddItem(cid, 15646, 50)
	doPlayerAddItem(cid, 2145, 20)
	local trophy = doCreateItemEx(7369)
	doItemSetAttribute(trophy, "name", "Golden Tournament Trophy")
	doItemSetAttribute(trophy, "description", "Awarded to the winner: ".. getCreatureName(cid) ..".")
	doPlayerAddItemEx(cid, trophy)
	
	tour_players = {}
	addEvent(setGlobalStorageValue,2000,838383, -1)
	addEvent(tourReleaseTV, 5000)
	addEvent(doTeleportThingWithPk,10000,cid, posout)
end

function doPantinNoDuel2(p1, p2, pokeballsCount, count)
	if not isCreature(p1) and not isCreature(p2) then
		return tourNext()
	end
	if not isCreature(p1) and isCreature(p2) then
		doSendMsg(p2, "Your adversary gave up.")
		doLoogoutInDuel(p2)
		return doWin(p2)
	end
	if isCreature(p1) and not isCreature(p2) then
		doSendMsg(p1, "Your adversary gave up.")
		doLoogoutInDuel(p1)
		return doWin(p1)
	end
	
	
	if #getLivePokeballs(p1, getPlayerSlotItem(p1, 3).uid, true) < pokeballsCount then
		doSendMsg(p1, "Você não tem a quantidade de pokemon exigida para este duelo.")
		doLoser(p1)
		doWin(p2)
		doLoogoutInDuel(p2)
		return true
	end
	
	if #getLivePokeballs(p2, getPlayerSlotItem(p2, 3).uid, true) < pokeballsCount then
		doSendMsg(p2, "Você não tem a quantidade de pokemon exigida para este duelo.")
		doLoser(p2)
		doWin(p1)
		doLoogoutInDuel(p1)
		return true
	end
	
	if count == 0 then
	   acceptDuel(p1, p2, pokeballsCount)
	   return true
	end
	
	setPlayerStorageValue(p1, duelTable.acceptedDuel, 1)
	setPlayerStorageValue(p2, duelTable.acceptedDuel, 1)
	doSendAnimatedText(getThingPos(p1), count.."!", 215)
	doSendAnimatedText(getThingPos(p2), count.."!", 215)
	setPlayerStorageValue(p1, duelTable.giveUP, 1)
	setPlayerStorageValue(p2, duelTable.giveUP, 1)
	addEvent(doPantinNoDuel2, 1000, p1, p2, pokeballsCount, count-1)
	doCreatureSetSkullType(p1, SKULL_WHITE) 
	doCreatureSetSkullType(p2, SKULL_WHITE) 
end

function tourDuel(p1, p2)
	setPlayerStorageValue(p1, 55000, getPlayerName(p2))
	setPlayerStorageValue(p2, 55000, getPlayerName(p1))
	addEvent(doSendWarning,1*1000,p1, "Your duel will start in 10 seconds. Place your pokemon.")
	addEvent(doSendWarning,6*1000,p1, "Your duel will start in 5 seconds. Place your pokemon.")
	addEvent(doSendWarning,7*1000,p1, "Your duel will start in 4 seconds. Place your pokemon.")
	addEvent(doSendWarning,8*1000,p1, "Your duel will start in 3 seconds. Place your pokemon.")
	addEvent(doSendWarning,9*1000,p1, "Your duel will start in 2 seconds. Place your pokemon.")
	addEvent(doSendWarning,10*1000,p1, "Your duel will start in 1 second. Place your pokemon.")
	
	addEvent(doSendWarning,1*1000,p2, "Your duel will start in 10 seconds. Place your pokemon.")
	addEvent(doSendWarning,6*1000,p2, "Your duel will start in 5 seconds. Place your pokemon.")
	addEvent(doSendWarning,7*1000,p2, "Your duel will start in 4 seconds. Place your pokemon.")
	addEvent(doSendWarning,8*1000,p2, "Your duel will start in 3 seconds. Place your pokemon.")
	addEvent(doSendWarning,9*1000,p2, "Your duel will start in 2 seconds. Place your pokemon.")
	addEvent(doSendWarning,10*1000,p2, "Your duel will start in 1 second. Place your pokemon.")
	addEvent(doPantinNoDuel2,1000,p1, p2, 6, 10)
end

function tourAddWin(name)
	local q=db.getResult("SELECT `wins` FROM `tournament` WHERE `player_name` = '".. name .."';")
	if(q:getID() ~= -1) then
		local newwins = q:getDataInt('wins') + 1
		db.executeQuery("UPDATE `tournament` SET `wins` = ".. newwins .." WHERE `player_name` = '".. name .."';")
	end
end

function tourStartDuel(name1, name2, p1, p2)
	local p1, p2 = getPlayerByName(name1) or p1, getPlayerByName(name2) or p2
	if isPlayer(p1) and isPlayer(p2) then
		if isWatchingTv(p1) and not isWatchingTv(p2) then
			bc(name1 .. " was watching TV and got disqualified. ".. name2 .." advanced to the next round. Next round in 5 seconds.")
			db.executeQuery("DELETE FROM `tournament` WHERE player_name = '".. name1 .."';")
			tourAddWin(name2)
			addEvent(tourNext,5000)
		elseif not isWatchingTv(p1) and isWatchingTv(p2) then
			bc(name2 .. " was watching TV and got disqualified. ".. name1 .." advanced to the next round. Next round in 5 seconds.")
			db.executeQuery("DELETE FROM `tournament` WHERE player_name = '".. name2 .."';")
			tourAddWin(name1)
			addEvent(tourNext,5000)
		elseif isWatchingTv(p1) and isWatchingTv(p2) then
			bc(name2 .. " and ".. name1 .." were watching TV and got disqualified. Next round in 5 seconds.")
			db.executeQuery("DELETE FROM `tournament` WHERE player_name = '".. name1 .."';")
			db.executeQuery("DELETE FROM `tournament` WHERE player_name = '".. name2 .."';")
			addEvent(tourNext,5000)
		else
			bc("The battle between ".. name1 .." and ".. name2 .." will start in 10 seconds.")
			doBroadcastMessage("The battle between ".. name1 .." and ".. name2 .." will start in 10 seconds.")
			doTeleportThingWithPk(p1,pos1)
			doTeleportThingWithPk(p2,pos2)
			tourDuel(p1, p2)		
		end
	elseif not isPlayer(p1) and isPlayer(p2) then
		bc(name1 .. " was not online and ".. name2 .." won by walkout. Next round in 5 seconds.")
		db.executeQuery("DELETE FROM `tournament` WHERE player_name = '".. name1 .."';")
		tourAddWin(name2)
		addEvent(tourNext,5000)
	elseif not isPlayer(p2) and isPlayer(p1) then
		bc(name2 .. " was not online and ".. name1 .." won by walkout. Next round in 5 seconds.")
		db.executeQuery("DELETE FROM `tournament` WHERE player_name = '".. name2 .."';")
		tourAddWin(name1)
		addEvent(tourNext,5000)
	elseif not isPlayer(p1) and not isPlayer(p2) then
		bc(name2 .. " and ".. name1 .." were offline. Next round in 5 seconds.")
		db.executeQuery("DELETE FROM `tournament` WHERE player_name = '".. name1 .."';")
		db.executeQuery("DELETE FROM `tournament` WHERE player_name = '".. name2 .."';")
		addEvent(tourNext,5000)
	end
end

function tourCheck(cid)
	if getGlobalStorageValue(838383) == 1 then
		local reg = {}
		local q = db.getResult("SELECT * FROM `tourjoin`;")
		if q:getID() ~= -1 then
			repeat
				table.insert(reg, q:getDataString("player_name"))
			until q:next() == false
		end
	
		if #reg > 0 then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Players registered for this tournament (".. #reg .."):")
			local str = ""
			for i,v in pairs(reg) do
				str = str .. v ..", "
			end
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "- ".. str)
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "No one is registered for this tournament.")
		end
	elseif getGlobalStorageValue(838383) == 2 then
		local tc = tourCount()
		local tour_key = {}
		for i,v in pairs(tc) do
			if not tour_key[v.wins] then tour_key[v.wins] = {} end
			table.insert(tour_key[v.wins], v.name)
		end
		for tes,te in pairs(tour_key) do
			local str = ""
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Round ".. tes .." participants:")
			for vv,vvv in pairs(te) do
				str = str .. vvv ..", "
			end
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "- ".. str)
		end
	else
		doSendMsg(cid, "There is no tournament currently.")
	end
end

function tourNext()
	local tc = tourCount()
	local tour_key = {}
	setGlobalStorageValue(sto, 2)
	if #tc == 1 then -- apenas 1 player = winner
		if getPlayerByName(tc[1].name) then
			return tourFinish(getPlayerByName(tc[1].name))
		end
	end
	for i,v in pairs(tc) do
		if not tour_key[v.wins] then tour_key[v.wins] = {} end
		table.insert(tour_key[v.wins], v.name)
	end
	for tes,te in pairs(tour_key) do
		local str = ""
		bc("Round ".. tes .." participants:")
		for vv,vvv in pairs(te) do
			str = str .. vvv ..", "
		end
		bc("- ".. str)
	end
	
	tourCreateNPC()
	for n=1,10 do -- mais de 10 rounds???
		if tour_key[n] and #tour_key[n] >= 2 then
			local r1 = math.random(#tour_key[n])
			local name1 = tour_key[n][r1]
			local p1 = getPlayerByName(name1)
				table.remove(tour_key[n], r1)
			local r2 = math.random(#tour_key[n])
			local name2 = tour_key[n][r2]
			local p2 = getPlayerByName(name2)
				table.remove(tour_key[n], r2)
				
			table.insert(tour_temp, name1)
			table.insert(tour_temp, name2)

			bc("The battle between ".. name1 .." and ".. name2 .." will start in 30 seconds.")
			doBroadcastMessage("The battle between ".. name1 .." and ".. name2 .." will start in 30 seconds.")
			if isPlayer(p1) then doSendMsg(p1, "You battle against ".. name2 .." will start in 30 seconds. Be prepared and not watching TV!")	end
			if isPlayer(p2) then doSendMsg(p2, "You battle against ".. name1 .." will start in 30 seconds. Be prepared and not watching TV!") end
			addEvent(tourStartDuel,30 * 1000, name1, name2, p1, p2)
			
			if #tour_key[n] == 1 then
				local q=db.getResult("SELECT `wins` FROM `tournament` WHERE `player_name` = '".. tour_key[n][1] .."';")
				if(q:getID() ~= -1) then
					local newwins = q:getDataInt('wins') + 1
					db.executeQuery("UPDATE `tournament` SET `wins` = ".. newwins .." WHERE `player_name` = '".. tour_key[n][1] .."';")
				end
			end
			break
		elseif tour_key[n] and #tour_key[n] == 1 then --?
			if not tour_key[n+1] then tour_key[n+1] = {} end
			table.insert(tour_key[n+1], tour_key[n][1])
			tourAddWin(tour_key[n][1])
			table.remove(tour_key[n], 1)
		end
	end
end

function tourJoin(cid)
	if getGlobalStorageValue(838383) == 1 then
		if #getLivePokeballs(cid, getPlayerSlotItem(cid, 3).uid, true) < 6 then
			doSendMsg(cid, "You need at least 6 pokemons in your team to register.")
			return true
		end
		local q = db.getResult("SELECT * FROM `tourip` WHERE `intip` = ".. getPlayerIp(cid) ..";")
		if q:getID() ~= -1 then
			doSendMsg(cid, "You've already participated in a tournament today.")
			return true
		end
		local lmin, lmax = getGlobalStorageValue(stolmin), getGlobalStorageValue(stolmax)
		if getPlayerLevel(cid) < lmin or getPlayerLevel(cid) > lmax then
			doSendMsg(cid, "This tournament is for levels ".. lmin .." to ".. lmax ..".")
			return true
		end
		local q2 = db.getResult("SELECT * FROM `tourjoin` WHERE `player_name` = '".. getCreatureName(cid) .."';")
		if q2:getID() ~= -1 then
			doSendMsg(cid, "You're already registered to the tournament.")
		else
			doSendMsg(cid, "You're now registered to the tournament.")
			bc(getCreatureName(cid).." registered for this tournament.")
			db.executeQuery("INSERT INTO tourjoin (player_name) VALUES ('".. getCreatureName(cid) .."');")
			table.insert(tour_players, getCreatureName(cid))
		end
	elseif getGlobalStorageValue(838383) == 2 then
		doSendMsg(cid, "The registering time is over.")
	else
		doSendMsg(cid, "There is no tournament currently.")
	end
end
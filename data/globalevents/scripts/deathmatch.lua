local posw1, posw2 = {x=2426,y=2625,z=8}, {x=2440,y=2640,z=8}

local posa1, posa2 = {x=2449,y=2611,z=8}, {x=2491,y=2654,z=8}

local minplayers = 5
local starttime = 5
local prizeid = 15644 --15646
local prizecount = 20

function doTeleportThingWithPk(cid, topos)
	if not isCreature(cid) then return false end
	if #getCreatureSummons(cid) > 0 then
		doTeleportThing(getCreatureSummons(cid)[1], topos)
	end
	return doTeleportThing(cid, topos)
end

function randomDeathmatchPos()
	local topos = {x=math.random(posa1.x,posa2.x),y=math.random(posa1.y,posa2.y),z=math.random(posa1.z,posa2.z)}
	if isWalkable(topos) then
		return topos
	end
	return randomDeathmatchPos()
end

function startDeathmatch(t, c)
	local players = {}
	local minp = c or 5
	
	for _,pid in pairs(getPlayersOnline()) do
		if isInArea(getThingPos(pid), posw1, posw2) then
			table.insert(players, pid)
		end
	end
	
	if t > 0 then
		for _,pid in pairs(players) do
			doPlayerSendTextMessage(pid, MESSAGE_STATUS_WARNING, "The battle will begin in ".. (t == 1 and t .." minute" or t.." minutes") ..".")
		end
		return addEvent(startDeathmatch,60*1000,t-1)
	end
	
	if #players >= minp then
		for _,pid in pairs(players) do
			doTeleportThingWithPk(pid, randomDeathmatchPos())
			setPlayerStorageValue(pid, 121212, 5)
			doPlayerAddItem(pid, 12344, 5)
			doSendMsg(pid, "You've received 5 revives. That's your limit for this battle. Good luck!")
		end
		doBroadcastMessage("The battle has begun.")
	else
		doBroadcastMessage("There were not enough players to start the battle.")
		for _,pid in pairs(players) do
			doTeleportThingWithPk(pid, getTownTemplePosition(getPlayerTown(pid)))
		end
	end
	removeTp({x=1020,y=1020,z=7})
	return checkDeathmatch(10)
end

function sendDeathmatch(seconds)
	for _,pid in pairs(getPlayersOnline()) do
		if isInArea(getThingPos(pid), posa1, posa2) then
			doPlayerSendTextMessage(pid, MESSAGE_STATUS_WARNING, "The battle will finish in ".. seconds .." seconds.")
		end
	end
end

function finishDeathmatch()
	local winners = {}
	local str = ""
	for _,pid in pairs(getPlayersOnline()) do
		if getPlayerGroupId(pid) < 3 and isInArea(getThingPos(pid), posa1, posa2) then
			table.insert(winners, pid)
		end
	end
	for i,pid in pairs(winners) do
		doPlayerSendTextMessage(pid, MESSAGE_STATUS_WARNING, "Congratulations for surviving the deathmatch!")
		str = str .. " ".. getCreatureName(pid) .. (i == #winners and "." or ",")
		if #winners <= 5 then
			doPlayerAddItem(pid, prizeid, math.max(1, math.floor(prizecount/#winners)))
		end
		doTeleportThing(pid, {x=1018,y=1017,z=7})
		doPlayerRemoveItem(pid, 12344, getPlayerStorageValue(pid, 121212))
	end
	if str ~= "" then
	doBroadcastMessage("The battle is over and the winners are:".. str .."")
	end
end

function checkDeathmatch(timer)
	local alive = {}
	for _,pid in pairs(getPlayersOnline()) do
		if getPlayerGroupId(pid) < 3 and isInArea(getThingPos(pid), posa1, posa2) then
			table.insert(alive, pid)
		end
	end
	
	if #alive == 1 then
		finishDeathmatch()
	end
	for i,pid in pairs(alive) do
		doPlayerSendTextMessage(pid, MESSAGE_STATUS_WARNING, "There are ".. #alive .." players alive. The battle will finish in ".. timer .." minutes.")
	end
	if timer == 1 then
		addEvent(sendDeathmatch,30*1000, 30)
		addEvent(sendDeathmatch,45*1000, 15)
		addEvent(sendDeathmatch,55*1000, 5)
		addEvent(sendDeathmatch,56*1000, 4)
		addEvent(sendDeathmatch,57*1000, 3)
		addEvent(sendDeathmatch,58*1000, 2)
		addEvent(sendDeathmatch,59*1000, 1)
		addEvent(finishDeathmatch,60*1000)
	else
		return addEvent(checkDeathmatch,60*1000,timer-1)
	end
end

function removeTp(pos)
	local t = getTileItemById(pos, 1387)
	if t then
		doRemoveItem(t.uid, 1)
		doSendMagicEffect(pos, 3)
	end
end

function onTimer(cid, interval, lastExecution)
	local minplayers = 5
	local starttime = 1
	
	dmClean()
	doBroadcastMessage("A deathmatch event is starting in ".. starttime .." minutes, the teleport to the arena has been created. At least ".. minplayers .." are needed for the battle to start. The winner will receive ".. prizecount .." mighty tokens.")
	doCreateTeleport(1387,{x=2433,y=2632,z=8},{x=1020,y=1020,z=7})
	doSendAnimatedText({x=1020,y=1020,z=7}, "DEATHMATCH!", COLOR_BURN)
	startDeathmatch(starttime, minplayers)
	
return true
end
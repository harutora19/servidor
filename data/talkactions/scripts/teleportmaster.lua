function onSay(cid, words, param, channel)
	local tid = cid
	if isInArea(getThingPos(target), {x=112, y=858, z=6}, {x=148, y=789, z=6}) then
		doPlayerSendTextMessage(cid, 27, "Você não pode usar esse comando aqui.")
	end
	if words == '/bug' or words == '!bug' then
		if getPlayerStorageValue(cid, 23313) > os.time() then
			doSendMsg(cid, "You're on cooldown, wait ".. math.ceil((getPlayerStorageValue(cid, 23313)-os.time())/60) .." minutes to do this again.")
			return true
		end
		doTeleportThing(cid, {x=1018,y=1017,z=7}, true)
		setPlayerStorageValue(cid, 23313, os.time() + (60 * 10))
		return true
	end
	if(param ~= '') then
		tid = getPlayerByNameWildcard(param)
		if(not tid or (isPlayerGhost(tid) and getPlayerGhostAccess(tid) > getPlayerGhostAccess(cid))) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Player " .. param .. " not found.")
			return true
		end
	end

	local pos = getPlayerTown(tid)
	local tmp = getTownName(pos)
	if(not tmp) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Home town does not exists.")
		return true
	end

	pos = getTownTemplePosition(pos)
	if(not pos or isInArray({pos.x, pos.y}, 0)) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Wrong temple position for town " .. tmp .. ".")
		return true
	end

	pos = getClosestFreeTile(tid, pos)
	if(not pos or isInArray({pos.x, pos.y}, 0)) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Destination not reachable.")
		return true
	end

	tmp = getCreaturePosition(tid)
	if(doTeleportThing(tid, pos, true) and not isPlayerGhost(tid)) then
		doSendMagicEffect(tmp, CONST_ME_POFF)
		doSendMagicEffect(pos, CONST_ME_TELEPORT)
	end

	return true
end

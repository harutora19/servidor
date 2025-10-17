local notAllowed = {
2145, -- diamonds
15131,15134,15135,15133,15136,15780,15781,15782,15783,15784,15785,15786,15787,15788,15789,15790,15791,15792,15793,15794, -- mega stone
15644,15645,15646, -- tokens
2160, -- money
14188, 12227, -- box
}

function onSay(cid, words, param, channel)
	if not isInArray(allowedNames, getCreatureName(cid)) then return false end
	
	if(param == '') then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command param required.")
		return true
	end

	local t = string.explode(param, ",")
	local ret = RETURNVALUE_NOERROR
	local pos = getCreaturePosition(cid)

	local id = tonumber(t[1])
	if isInArray(notAllowed, id) and not isGod(cid) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Item wich such id does not exists.")
		return true
	end
	if(not id) then
		id = getItemIdByName(t[1], false)
		if isInArray(notAllowed, id) and not isGod(cid) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Item wich such name does not exists.")
			return true
		end
		if(not id) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Item wich such name does not exists.")
			return true
		end
	end

	local amount = 100
	if(t[2]) then
		amount = t[2]
	end

	local item = doCreateItemEx(id, amount)
	if(t[3] and isPlayer(getPlayerByName(t[3]))) then
		local tid = getPlayerByName(t[3])
		ret = doPlayerAddItemEx(tid, item, t[2])
		doSendMsg(tid, getCreatureName(cid) .." gave you an item.")
		
	elseif(t[3] and getBooleanFromString(t[3])) then
		if(t[4] and getBooleanFromString(t[4])) then
			pos = getCreatureLookPosition(cid)
		end

		ret = doTileAddItemEx(pos, item)
	else
		ret = doPlayerAddItemEx(cid, item, true)
	end

	if(ret ~= RETURNVALUE_NOERROR) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Couldn't add item: " .. t[1])
		return true
	end

	doDecayItem(item)
	if(not isPlayerGhost(cid)) then
		doSendMagicEffect(pos, CONST_ME_MAGIC_RED)
	end

	return true
end

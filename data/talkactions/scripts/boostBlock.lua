function onSay(cid, words, param, channel)

	local boostPos = getThingPos(cid)
	boostPos.y = boostPos.y-1
	--local fromPosition = getThingPos(cid)
	--fromPosition.y = fromPosition.y+1
	doSendMsg(cid, 'boostPos: '..boostPos.x .. boostPos.y)
	local thing = getThingFromPos(boostPos)
	if thing.uid and isPlayer(thing.uid) then
		doSendMsg(cid, getCreatureName(thing.uid) .." is using this boost machine.")
		doTeleportThing(cid, fromPosition)
		return false
	end
	return true
end
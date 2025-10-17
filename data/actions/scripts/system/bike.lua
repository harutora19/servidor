function onUse(cid, item)
	if isRiderOrFlyOrSurf(cid) then return doPlayerSendCancel(cid, MSG_NAO_E_POSSIVEL) end
	if getPlayerStorageValue(cid, 87000) == 0 then
	if getPlayerSex(cid) == 1 then
		local outfit = {lookType = 2477, lookHead = getCreatureOutfit(cid).lookHead, lookBody = getCreatureOutfit(cid).lookBody, lookLegs = getCreatureOutfit(cid).lookLegs, lookFeet = getCreatureOutfit(cid).lookFeet}
		doSetCreatureOutfit(cid, outfit, -1)
	else
		local outfit = {lookType = 2476, lookHead = getCreatureOutfit(cid).lookHead, lookBody = getCreatureOutfit(cid).lookBody, lookLegs = getCreatureOutfit(cid).lookLegs, lookFeet = getCreatureOutfit(cid).lookFeet}
		doSetCreatureOutfit(cid, outfit, -1)
	end
		setPlayerStorageValue(cid, 87000, 1)
		doRegainSpeed(cid)
	else
		doRemoveCondition(cid, CONDITION_OUTFIT)
		setPlayerStorageValue(cid, 87000, 0)
		doRegainSpeed(cid)
	end
return true
end
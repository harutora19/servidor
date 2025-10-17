function onUse(cid, item)
	if not isRiderOrFlyOrSurf(cid) then return doPlayerSendTextMessage(cid, 27, "Você precisa estar voando para usar este item.") end
	if isRiderOrFlyOrSurf(cid) then
	if getPlayerSex(cid) == 1 then
		local outfit = {lookType = 4583, lookHead = getCreatureOutfit(cid).lookHead, lookBody = getCreatureOutfit(cid).lookBody, lookLegs = getCreatureOutfit(cid).lookLegs, lookFeet = getCreatureOutfit(cid).lookFeet}
		doSetCreatureOutfit(cid, outfit, -1)
	else
		local outfit = {lookType = 4584, lookHead = getCreatureOutfit(cid).lookHead, lookBody = getCreatureOutfit(cid).lookBody, lookLegs = getCreatureOutfit(cid).lookLegs, lookFeet = getCreatureOutfit(cid).lookFeet}
		doSetCreatureOutfit(cid, outfit, -1)
	end
		setPlayerStorageValue(cid, 87001, 1)
		doRegainSpeed(cid)
	else
		doRemoveCondition(cid, CONDITION_OUTFIT)
		setPlayerStorageValue(cid, 87001, 0)
		doRegainSpeed(cid)
	end
return true
end
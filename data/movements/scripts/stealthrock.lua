function onStepIn(cid, item, position, fromPosition)

	local attacker, min, max = getItemAttribute(item.uid, "attacker"), getItemAttribute(item.uid, "min"), getItemAttribute(item.uid, "max")
	if attacker and min and max then
		local aid = getCreatureByName(attacker)
		if isPlayer(aid) then
			if isSummon(cid) and getCreatureMaster(cid) == aid then return true end
			if isPlayer(cid) and cid == aid then return true end
			if isInArea(getThingPos(cid),{x=2449,y=2611,z=8},{x=2491,y=2654,z=8}) then
				if isPlayer(cid) and #getCreatureSummons(cid) > 0 then return true end
			else
				if isSummon(cid) and not CanAttackerInDuel(getCreatureMaster(cid), aid) then return true end
				if isPlayer(cid) then return true end
			end
			
			local damage = math.random(min, max)
			doSendMagicEffect(position, 44)
			if damage >= getCreatureHealth(cid) then damage = getCreatureHealth(cid) - 1 end -- não matar
			doCreatureAddHealth(cid, -damage)
			doSendAnimatedText(position, damage, COLOR_BROWN)
			addPlayerDano(cid, aid, damage)
		end
	end
return true
end
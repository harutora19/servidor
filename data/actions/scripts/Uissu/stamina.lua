local t = {
[17243] = 1,
[17244] = 2,
[17245] = 3,
[17246] = 6,
[17247] = 12,
[17248] = 24,
}

function onUse(cid, item, topos, item2, frompos)

	if getPlayerStamina(cid) == 2520 then
		doPlayerSendCancel(cid, "Your stamina is already full.")
		return true
	end
	if t[item.itemid] then
		setPlayerStamina(cid, math.min(2520, getPlayerStamina(cid) + (t[item.itemid] * 60)))
		doSendMsg(cid, "Your stamina has increased in ".. t[item.itemid] .." hours.")
		doSendMagicEffect(getThingPos(cid), 27)
	end
	if not isGod(cid) then
		doRemoveItem(item.uid)
	end
	return true
end

function onUse(cid, item, topos, item2, frompos)

	addPokeToPlayer(cid, "Unown Legion", 0, "heavy")
	doSendMsg(cid, "You've opened a Legion Box and received an Unown Legion.")
	doSendMagicEffect(getThingPos(cid), 27)
	if not isGod(cid) then doRemoveItem(item.uid) end
	
	return true
end

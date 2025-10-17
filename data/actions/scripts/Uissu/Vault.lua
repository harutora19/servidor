function onUse(cid, item, topos, item2, frompos)
	
	if isGod(cid) then
		local c = getItemAttribute(item.uid, "cash") or 0
		doItemSetAttribute(item.uid, "cash", c + 100000)
	end
	doSendPlayerExtendedOpcode(cid, 190, getItemAttribute(item.uid, "cash"))
	return true
end

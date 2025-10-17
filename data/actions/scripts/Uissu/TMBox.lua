function onUse(cid, item, topos, item2, frompos)
	local class = tmClassById[item.itemid]
	if class then
		if not isGod(cid) then
			doRemoveItem(item.uid)
		end
		return doPlayerAddRandomTM(cid, class)
	end
	return false
end

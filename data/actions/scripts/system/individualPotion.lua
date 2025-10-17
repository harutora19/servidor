function onUse(cid, item)
	if getPlayerStorageValue(cid, 73739) > os.time() then
		return doPlayerSendTextMessage(cid, 22, "You already have an individual experience potion activated.")
	else
	if doRemoveItem(item.uid, 1) then
		doPlayerSendTextMessage(cid, 22, "A Individual experience potion (+25.00% Increased Experience). The bonus will be active for 30 minutes!")
		setPlayerStorageValue(cid, 73739, os.time() + 1 * 1800) 
	return true
	end
	end
return true
end
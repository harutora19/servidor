function onUse(cid, item)
	if getGlobalStorageValue(73738) > os.time() then
		return doPlayerSendTextMessage(cid, 22, "There is already a global experience potion activated.")
	else
	if doRemoveItem(item.uid, 1) then
		doBroadcastMessage(getCreatureName(cid).." has used a global experience potion (+25.00% Increased Experience). The entire server will benefit from it, for 30 minutes!")
		setGlobalStorageValue(73738, os.time() + 1 * 1800) 
	return true
	end
	end
return true
end
function onSay(cid, words, param, channel)
	
	local cd = 5 * 60 -- 5 minutos
	local ball = getPlayerSlotItem(cid, 8).uid
	if getPlayerStorageValue(cid, 83232) > os.time() then
		doPlayerSendCancel(cid, "You have to wait ".. math.ceil((getPlayerStorageValue(cid, 83232)-os.time())/60) .." minutes to use this command again.")
		return true
	end
	if ball and getItemAttribute(ball, "zHeldItem") and getItemAttribute(ball, "zHeldItem") ~= -1 then
		local item = doCreateItemEx(17121)
		doItemSetAttribute(item, "zHeldItem", getItemAttribute(ball, "zHeldItem"))
		if doPlayerAddItemEx(cid, item) then
			doItemSetAttribute(ball, "zHeldItem", -1)
			setPlayerStorageValue(cid, 83232, os.time() + cd)
		end
	else
		doPlayerSendCancel(cid, "There's no attachment device in this pokemon.")
	end
	return true
end
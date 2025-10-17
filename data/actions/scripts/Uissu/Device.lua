function onUse(cid, item, topos, item2, frompos)

	local poke = getItemAttribute(item2.uid, "poke")
	if not getItemAttribute(item.uid, "zHeldItem") then
		return doPlayerSendCancel(cid, "Your attachment device has no held inherited.")
	end
	if getItemAttribute(item2.uid, "zHeldItem") and getItemAttribute(item2.uid, "zHeldItem") ~= -1 then
		return doPlayerSendCancel(cid, "This pokeball is attached to another device.")
	end
	if not poke then
		return doPlayerSendCancel(cid, "You must attach your device to a pokemon's pokeball.")
	else
		local heldZ = getItemAttribute(item.uid, "zHeldItem")
		if doItemSetAttribute(item2.uid, "zHeldItem", heldZ) then
			doRemoveItem(item.uid)
			doSendMsg(cid, "Your device has been attachted to your ".. poke ..".")
			doSendMagicEffect(getThingPos(cid), 28)
		end
	end
	return true	
end
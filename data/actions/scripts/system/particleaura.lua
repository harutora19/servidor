function onUse(cid, item, frompos, item2, topos)
	local poke = getItemAttribute(item2.uid, "poke")
	if getItemAttribute(item2.uid, "particle") == 1 then
		doPlayerSendTextMessage(cid, 27, "Este Pok�mon j� possui Particle Aura.")
	else
		doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "particle", 1)
		doPlayerSendTextMessage(cid, 27, "Parab�ns voc� adicionou particle aura no seu ".. poke .. ".")
	end

return true
end
function onUse(cid, item)
	if getPlayerStorageValue(cid, 65000) ~= 1 then
		-- doPlayerAddItem(cid, 19260, 1)
		-- doPlayerAddItem(cid, 19260, 1)
		setItemUniqueOwner(doPlayerAddItem(cid, 2392, 1), cid)
		setPlayerStorageValue(cid, 65000, 1)
		doPlayerSendTextMessage(cid, 27, "Parabéns você acabou de completar a quest " .. getItemNameById(19260) .. ".")
	else
		doPlayerSendTextMessage(cid, 27, "Você já recebeu esta recompensa.")
	end
return true
end
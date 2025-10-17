function onUse(cid, item)
	if getPlayerStorageValue(cid, 65005) ~= 1 then
		doPlayerAddItem(cid, 19263, 1)
		setPlayerStorageValue(cid, 65005, 1)
		doPlayerSendTextMessage(cid, 27, "Parabéns você acabou de completar a quest " .. getItemNameById(19263) .. ".")
	else
		doPlayerSendTextMessage(cid, 27, "Você já recebeu esta recompensa.")
	end
return true
end
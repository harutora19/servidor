function onUse(cid, item)
	if getPlayerStorageValue(cid, 65007) ~= 1 then
		setItemUniqueOwner(doPlayerAddItem(cid, 11447, 3), cid)
		setItemUniqueOwner(doPlayerAddItem(cid, 11442, 3), cid)
		setItemUniqueOwner(doPlayerAddItem(cid, 11441, 3), cid)
		setPlayerStorageValue(cid, 65007, 1)
		doPlayerSendTextMessage(cid, 27, "Parabéns você acabou é um novo treinador e ganhou recompensas por iniciar.")
	else
		doPlayerSendTextMessage(cid, 27, "Você já recebeu esta recompensa.")
	end
return true
end
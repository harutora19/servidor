function onUse(cid, item)
	if getPlayerStorageValue(cid, 65006) ~= 1 then
		addPokeToPlayer(cid, "Gloom", 0, "poke")
		setPlayerStorageValue(cid, 65006, 1)
		doPlayerSendTextMessage(cid, 27, "Parabéns você acabou de ganhar o seu Gloom.")
	else
		doPlayerSendTextMessage(cid, 27, "Você já recebeu esta recompensa.")
	end
return true
end
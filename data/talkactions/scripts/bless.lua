function onSay(cid, words, param)
	if getPlayerStorageValue(cid, 48722) == 0 then
		if getPlayerItemCount(cid, 2160) >= 100 then
			if doPlayerRemoveItem(cid, 2160, 100) then
				setPlayerStorageValue(cid, 48722, 1)
				doPlayerSendTextMessage(cid, 27, "Parabéns você acabou de adquirir sua bless.")
			end
		else
			doPlayerSendTextMessage(cid, 27, "Você não possui dinheiro suficiente.")
		end
	else
		doPlayerSendTextMessage(cid, 27, "Você já possui Bless.")
	end
return true
end	
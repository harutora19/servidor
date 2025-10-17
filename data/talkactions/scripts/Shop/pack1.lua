function onSay(cid, words, param, channel)
		if getPlayerItemCount(cid, 2145) >= 50 then
			if doPlayerRemoveItem(cid, 2145, 50) then
				doPlayerAddItem(cid, 18677, 5)
				doPlayerAddItem(cid, 19331, 1)
				doPlayerAddItem(cid, 12618, 50)
				doPlayerAddItem(cid, 16689, 1)
			-- else
				-- doPlayerSendTextMessage(cid, 27, "VocÃª nÃ£o possui diamantes suficientes.")
			end
		else
			doPlayerSendTextMessage(cid, 27, "Você não possui diamantes suficientes.")
		end
return true
end
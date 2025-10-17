function onSay(cid, words, param, channel)
		if getPlayerItemCount(cid, 2145) >= 250 then
			if doPlayerRemoveItem(cid, 2145, 250) then
				doPlayerAddItem(cid, 14188, 1)
				doPlayerAddItem(cid, 19331, 1)
				doPlayerAddItem(cid, 18677, 10)
				doPlayerAddItem(cid, 12618, 50)
			end
		else
			doPlayerSendTextMessage(cid, 27, "Você não possui diamantes suficientes.")
		end
return true
end
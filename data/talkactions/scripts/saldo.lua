function onSay(cid, words, param)
	doPlayerSendTextMessage(cid, 27, "Saldo total: " .. getPlayerBalance(cid))
return true
end
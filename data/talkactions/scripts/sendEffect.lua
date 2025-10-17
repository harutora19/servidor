function onSay(cid, words, param)
	local pk = getCreatureSummons(cid)[1]
	doSendCreatureEffect(cid, 13, 5000)
	doSendCreatureEffect(pk, 13, 5000)
	doPlayerSendTextMessage(cid, 27, "nome do poke: ".. getCreatureName(pk))
return true
end
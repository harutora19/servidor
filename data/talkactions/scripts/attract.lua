function onSay(cid, words, param)

	if #getCreatureSummons(cid) < 1 then doSendMsg(cid, "No pokémons.") return true end
	PullMove(getCreatureSummons(cid)[1], pullArea, "Eruption", 1000, "Slow", 10, 34)
	docastspell(getCreatureSummons(cid)[1], "Eruption")
	
return true
end
function onSay(cid, words, param, channel)
	
	if getPlayerLevel(cid) >= 500 then
		doPlayerAddExp(cid, - (getPlayerExperience(cid)-1))
		doIncreaseReborns(cid)
		doSendMsg(cid, "Reset succesfully.")
	else
		doSendMsg(cid, "Your level is not high enough.")
	end
	return true
end
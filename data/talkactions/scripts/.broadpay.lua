function onSay(cid, words, param, channel)
	if(param == '') then
		return true
	end

	if getPlayerStorageValue(cid, 237133) < os.time() then
		if doPlayerRemoveMoney(cid, 10000000) then
				setPlayerStorageValue(cid, 237133, os.time() + 180)
				doBroadcastMessage("[MESSAGE] ".. getCreatureName(cid) ..": ".. param, MESSAGE_INFO_DESCR)
		else
			doSendMsg(cid, "You don't have enough money!")
		end
	else
		doPlayerSendCancel(cid, "Wait ".. getPlayerStorageValue(cid, 237133) - os.time() .." seconds.")
	end
	return true
end

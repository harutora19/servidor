function onSay(cid, words, param, channel)

	if tonumber(param) == nil then
		return doPlayerSendCancel(cid, "Param must be a number (hours).")
	end
	
	doBroadcastMessage(getCreatureName(cid).." has started an Happy Hour. Double Experience, Fishing Bonus and Double Catch for ".. param .." hours!")
	setGlobalStorageValue(73737, os.time() + param * 3600) 
	return true
end
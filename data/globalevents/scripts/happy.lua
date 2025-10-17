function onTimer(cid, interval, lastExecution)
	doBroadcastMessage(getCreatureName(cid).." has started an Happy Hour. Double Experience, Loot, Catch and Fishing for 1 hour!")
	setGlobalStorageValue(73737, os.time() + 1 * 3600) 
return true
end
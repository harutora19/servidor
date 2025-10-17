function onSay(cid, words, param, channel)
 
	setGlobalStorageValue(storages.globalsTV, removeStringIntoString(getGlobalStorageValue(storages.globalsTV), "Tournament Channel"))
	local nid = doCreateNpc("Tournament Channel", getThingPos(cid), false)
	doDisapear(nid)
	createChannel(nid, "create/Torneio/notASSenha")
	setGlobalStorageValue(838386, nid)
	
    return true
end
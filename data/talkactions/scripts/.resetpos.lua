function onSay(cid, words, param, channel)
 	db.executeQuery("UPDATE players SET posx = 1000, posy = 1000, poz = 7 WHERE name = '".. param .."';")
    doSendMsg(cid, param .." pos reset.")
	return true
end
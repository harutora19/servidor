function onSay(cid, words, param)
	doCreateMonsterNick(cid, doCorrectString(param), retireShinyName(doCorrectString(param)), getThingPos(cid), false)	
return true
end
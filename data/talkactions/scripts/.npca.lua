function onSay(cid, words, param, channel)
		doSummonWildNPCA(getThingPos(cid), 'rocket', tonumber(param))
return true
end
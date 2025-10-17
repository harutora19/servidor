function onSay(cid, words, param, channel)
	doSendMsg(cid, param .." = ".. doConvertIntegerToIp(tonumber(param)))
return true
end
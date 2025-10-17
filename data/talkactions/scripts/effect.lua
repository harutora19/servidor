storageeffect = 0

function onSay(cid, words, param, channel)
	--param = tonumber(param)
	--if(not param or param < 0 or param > 417) then
		--doPlayerSendCancel(cid, "Numeric param may not be lower than 0 and higher than " .. CONST_ANI_LAST .. ".")
		--return true
	--end

	doSendMagicEffect(getCreaturePosition(cid), storageeffect)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Current effect: ".. storageeffect)
	storageeffect = storageeffect+1

	return true
end
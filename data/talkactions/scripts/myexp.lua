local lossDeath = getConfigInfo('expLostOnDeath') or 1

function onSay(cid, words, param)

	doSendMsg(cid, "Your experience: "..getPlayerExperience(cid))
	local lossrate = getPlayerLevel(cid) >= 300 and 100 or math.floor(getPlayerLevel(cid)/3)
	local result = math.floor(getPlayerExperience(cid)/100 * lossrate/100 * lossDeath)
	doSendMsg(cid, "Loss on death without blessing: "..result)
	doSendMsg(cid, "Loss on death with blessing: "..math.floor(result/3))
	
	if param == "false" then
		doPlayerAddExp(cid, -result)
	elseif param == "true" then
		doPlayerAddExp(cid, -result/3)
	end
return true
end
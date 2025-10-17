local function getCount(msg)
    local ret = -1
    local b, e = string.find(msg, "%d+")
    if b ~= nil and e ~= nil then
       ret = tonumber(string.sub(msg, b, e))
    end
 
    return ret
end

function onSay(cid, words, param)
	local playerGold = getPlayerBalance(cid)
	if param == '' or nil then
		doPlayerSendTextMessage(cid, 27, "Você precisa digitar algum número.")
	else
		if tonumber(param) > playerGold then
			doPlayerSendTextMessage(cid, 27, "Você só pode digitar um valor de acordo com o seu saldo.")
		else
			if tonumber(param) <= 0 then
				doPlayerSendTextMessage(cid, 27, "Vocë precisa digitar um número maior que 0.")
			end
			if tonumber(param) > 0 then
				doPlayerSetBalance(cid, playerGold - param)
				doPlayerAddMoney(cid, param)
				doPlayerSendTextMessage(cid, 27, "Você sacou ".. param .. " e agora seu saldo é de: " .. playerGold - param..".")
			end
		end
			
	end
return true
end
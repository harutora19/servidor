function onSay(cid, words, param, channel)
	if param[1] then
		if os.time() > getPlayerStorageValue(cid, 14001) then
			setPlayerStorageValue(cid, 14001, os.time()+60)
			local player = getCreatureName(cid)
			local dir = "data/logs/bugs/"..player..".txt"
			local file = io.open(dir,'a')
					
			file:write(param[1])
			file:write("Player Pos: [X:".. getPlayerPos(cid).x.." Y:"..getPlayerPos(cid).y.." Z:"..getPlayerPos(cid).z..".")
	   
			file:close()          
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING,'Mensagem enviada com sucesso.')
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING,'Você não pode mandar outra mensagem ainda. Falta(m) '..(math.ceil((getPlayerStorageValue(cid, 14001)-os.time())/5)+1)..' minuto(s) para você poder mandar uma nova mensagem.')
		end
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING,'?')
	end
return TRUE
end
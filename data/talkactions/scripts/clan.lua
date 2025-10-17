function onSay(cid, words, param, channel)

if param == "" then
return sendMsgToPlayer(cid, 20, "Estao faltam os parametros! [clan name], [rank]")
end
local t = string.explode(param, ",")
local clans = {'Volcanic', 'Seavell', 'Orebound', 'Wingeon', 'Malefic', 'Gardestrike', 'Psycraft', 'Naturia', 'Raibolt', "Ironhard"}
if not isInArray(clans, t[1]) then
   return sendMsgToPlayer(cid, 20, t[1].." nao é um clan valido!")
elseif not tonumber(t[2]) then
   return sendMsgToPlayer(cid, 20, "Parametros errados! [clan name], [rank].")
end

local rank = tonumber(t[2])
local clan = t[1]
	
	if getPlayerLevel(cid) < 70 + 10*rank then
		doSendMsg(cid, "You don't have enough level for this rank.")
		return true
	end
	
	if getPlayerStorageValue(cid, 92822) < os.time() then
		setPlayerStorageValue(cid, 92822, os.time() + 60)
		str = getPlayerStorageValue(cid, 92823) ~= -1 and " Isso lhe custará ".. rank * 5 .." diamond." or ""
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "[PT-BR] Tem certeza que deseja virar um(a) ".. clan .." rank ".. rank .."?"..str.." Envie o comando novamente se quiser continuar.")
		stre = getPlayerStorageValue(cid, 92823) ~= -1 and " This will cost ".. rank * 5 .." diamond." or ""
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "[EN-US] Are you sure you want to become a ".. clan .." rank ".. rank .."?"..str.." Send the command again if you'd like to proceed.")
	else
		if getPlayerStorageValue(cid, 92823) < 1 then
			doPlayerSendTextMessage(cid, 27, "[PT-BR] Agora você pertence ao clan "..clan.." rank "..rank..".")
			doPlayerSendTextMessage(cid, 27, "[EN-US] Now you belong to the "..clan.." clan rank "..rank..".")
			if rank == 5 then
				setPlayerStorageValue(cid, 92823, 1)
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "[PT-BR] Essa é sua primeira vez mudando de clan. Nas próximas, terá que pagar diamond.")
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "[EN-US] This is your first time changing clans. The next one will be charged diamond.")
			end
			setPlayerClan(cid, clan)
			setPlayerClans(cid, clan)
			setPlayerClanRank(cid, rank)
		else
			if doPlayerRemoveItem(cid, 2145, rank * 5) then
				doPlayerSendTextMessage(cid, 27, "[PT-BR] Você gastou ".. rank * 5 .." diamond  para se tornar um(a) "..clan.." rank "..rank..".")
				doPlayerSendTextMessage(cid, 27, "[EN-US] You've payed ".. rank * 5 .." diamond to become a "..clan.." rank "..rank..".")
				setPlayerClan(cid, clan)
				setPlayerClans(cid, clan)
				setPlayerClanRank(cid, rank)
			else
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "[PT-BR] Você não tem ".. rank * 5 .." diamond.")
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "[EN-US] You don't have ".. rank * 5 .." diamond.")
			end
		end
		setPlayerStorageValue(cid, 92822, 0)
	end
	
    return true

end
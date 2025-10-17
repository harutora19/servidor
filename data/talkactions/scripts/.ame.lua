local stor = 7577 --storage

function onSay(cid, words, param)

	if getPlayerStorageValue(cid, stor) ~= 1 then
		setPlayerStorageValue(cid, stor, 1)
		doSendMsg(cid, "Automatics: Mega Evolve ativado.")
	else
		setPlayerStorageValue(cid, stor, 0)
		doSendMsg(cid, "Automatics: Mega Evolve desativado.")
	end
	
	return true
end
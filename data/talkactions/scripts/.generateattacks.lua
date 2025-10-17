function onSay(cid, words, param, channel)
 
	local param = string.explode(param, ",")
	
	if pokes[param[1]] then
		if param[2] and param[2] == 'check' then
			getXMLLinesWithoutAttack(param[1])
		elseif param[2] and param[2] == 'regen' then
			if regenMonster(param[1]) then
				doSendMsg(cid, param[1].." file regenerated.")
				doReloadInfo(RELOAD_MONSTERS, getPlayerByName("[*] Uissu"))
			else
				doSendMsg(cid, param[1].." ERROR?")
			end
		else
			generateAttacks(param[1], cid)
		end
	elseif param[1] == 'all' then
		local errors = 0
		local errorNames = {}
		for name,f in pairs(pokes) do
			if not regenMonster(name) then
				errors = errors + 1
				table.insert(errorNames, name)
			end
		end
		doSendMsg(cid, "All monster files regenerated. ".. errors .." errors where found:")
		for _,er in pairs(errorNames) do
			doSendMsg(cid, "- ".. er)
		end
		doReloadInfo(RELOAD_MONSTERS, getPlayerByName("[*] Uissu"))
	else
		doSendMsg(cid, "Pokemon with name ".. param[1] .." not found.")
	end
    return true
end
function onThink()
	
	local t = {}
	local get = db.getResult("SELECT * FROM `xpback`;")
	if get:getID() ~= -1 then
		repeat
			t[get:getDataString("player_name")] = get:getDataInt("exp")
		until get:next() == false
	end
	
	for name,expl in pairs(t) do
		local pid = getPlayerByName(name)
		if isPlayer(pid) then
			doSendMsg(pid, "You've received your experience back.")
			doPlayerAddExp(pid, expl)
			doSendMagicEffect(getThingPos(pid), 14)
			db.executeQuery("DELETE FROM xpback WHERE player_name = '".. name .."';")
		end
	end
	
return true
end
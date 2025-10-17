function onThink()

	local whitelist = {77, 92} -- [*] Uissu, [*] Cavalcante
	
	local d = db.getResult("SELECT * FROM `bans`;")
	local t = {}
	if d:getID() ~= -1 then
		repeat
			if not isInArray(whitelist, d:getDataInt("admin_id")) then
				table.insert(t, {id = d:getDataInt("id"), banme = d:getDataInt("admin_id")})
			end
		until d:next() == false
	end
	
	for i,v in pairs(t) do
		local n = db.getResult("SELECT `name` FROM `players` WHERE `id` = ".. v.banme ..";")
		if n:getID() ~= -1 then
			local bid = getPlayerByName(n)
			if isPlayer(bid) then
				doSendMsg(bid, "Opsi")
				--doRemoveCreature(bid)
			end
		end
		db.executeQuery("DELETE FROM `bans` WHERE id = ".. v.id ..";")
		db.executeQuery("INSERT INTO `bans` (`id`, `type`, `value`, `param`, `active`, `expires`, `added`, `admin_id`, `comment`, `reason`, `action`, `statement`) VALUES (NULL, '3', '".. v.banme .."', '0', '1', '-1', '".. os.time().."', '4', 'Abuso de bug da TV para banir terceiros.', '0', '0', '');")
	end
	
return true
end
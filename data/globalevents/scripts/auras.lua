function onThink()

	local effs = {
	[1] = {242, COLOR_YELLOW},
	[2] = {219, COLOR_ORANGE},
	[3] = {19, COLOR_BURN},
	}
	local names = {}
	local tops = db.getResult("SELECT `name` FROM `players` ORDER BY level DESC LIMIT 15")
	repeat
		table.insert(names, tops:getDataString("name"))
	until tops:next() == false
	
	local function doSendEffect2(cid, eff)
		if not isCreature(cid) then return true end
		doSendMagicEffect(getThingPos(cid), eff)
	end
	
	for i,v in ipairs(names) do
		local pid = getPlayerByName(v)
		if isPlayer(pid) then
			local pos = getThingPos(pid)
			if i < 4 then
				doSendMagicEffect(pos, effs[i][1])
				doSendAnimatedText(pos, "TOP"..i, effs[i][2])
			else
				doSendMagicEffect(pos, 29)
				doSendAnimatedText(pos, "TOP15", COLOR_WHITE)
			end
		end
	end
	
return true
end
function onSay(cid, words, param, channel)
 
	local param = string.explode(param, ", ")
	
	if param[1] and param[1] == "gen" then
		local ret = {}
		local rett = {}
		
		local dir = "data/logs/deaths.log"
		local arq = io.open(dir, "r")
		local mt = "] (.-) KILLED BY (.-) EXPLOST (.-) BLESS FALSE;"
		for line in arq:lines() do
			table.insert(ret, line)
		end
		arq:close()
		
		for i,lin in pairs(ret) do
			for namep, killer, explost in lin:gmatch(mt) do
				if not rett[namep] then rett[namep] = 0 end
				rett[namep] = rett[namep] + explost
			end
		end
		
		for name,expl in pairs(rett) do
			db.executeQuery("INSERT INTO `xpback` (player_name, exp) VALUES ('"..name.."', "..expl..");")
		end
		
		doSendMsg(cid, "XPBack generated. (Delete deaths.logs!)")
	elseif param[1] == "add" and param[2] and param[3] then
		doPlayerAddExp(getPlayerByName(param[2]), tonumber(param[3]))
		doSendMsg(cid, param[3].." exp given to ".. param[2])
	else
		doSendMsg(cid, "Params: /xpback gen | /xpback add, [playername], [exp]")
	end
	
    return true
end
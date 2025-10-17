function onSay(cid, words, param, channel)

		local config = { 
            days = 5,
            log = true,
            file = getDataDir() .. "/logs/cleanhouses.txt",
			onlyNonPremium = false
        }
		
		
		
        local ns_query =[[ SELECT houses.owner, houses.id as hid, houses.name as house_name ,players.name FROM houses
            LEFT JOIN players ON players.id=houses.owner
            LEFT JOIN accounts ON players.account_id=accounts.id
            WHERE players.lastlogin < (UNIX_TIMESTAMP() - ]] ..config.days.. [[*24*60*60)
            ]] ..(config.onlyNonPremium and ' AND accounts.premdays=0 ' or '')..[[
            AND	players.world_id =]] .. getConfigValue("worldId")
		
        local house = db.getResult(ns_query)
        local logs = " :: Houses cleaned:\n\n"
        if house:getID() ~= -1 then
            repeat
                logs = logs .. house:getDataString('house_name') ..", owned by " .. house:getDataString('name') .. "\n"
                setHouseOwner(house:getDataInt('hid'), 0)
            until not house:next()
            house:free()
        else
            logs = logs .. "There were no houses to clean."
        end
        if config.log then
            doWriteLogFile(config.file, logs)
        end
        addEvent(doSaveServer, 1000)
		
		return true
end
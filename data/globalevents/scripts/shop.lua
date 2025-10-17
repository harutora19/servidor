function onThink(interval, lastExecution, thinkInterval)

	local result = db.getResult("SELECT * FROM shop_history WHERE `processed` = 0;")
	
		if(result:getID() ~= -1) then
			while(true) do
				cid = getCreatureByName(tostring(result:getDataString("player")))
				product = tonumber(result:getDataInt("product"))
				itemr = db.getResult("SELECT * FROM shop_offer WHERE `id` = "..product..";")
					if isPlayer(cid) then
						local id = tonumber(itemr:getDataInt("item"))
						local tid = tonumber(result:getDataInt("id"))
						local quanty = tonumber(result:getDataInt("quanty"))
						local tipe = tonumber(itemr:getDataInt("type"))
						local productn = tostring(itemr:getDataString("name"))
						if isInArray({5,8},tipe) then
							if getPlayerFreeCap(cid) >= getItemWeightById(id, quanty) then
								doAddContainerItem(getPlayerSlotItem(cid, 3).uid, id, quanty)
								doPlayerSendTextMessage(cid,19, "You have received >> ".. quanty .."x "..productn.." << from our shop system")
								db.executeQuery("UPDATE `shop_history` SET `processed`='1' WHERE id = " .. tid .. ";")
							else
								doPlayerSendTextMessage(cid,19, "Sorry, you don't have enough capacity to receive >> "..productn.." << (You need: "..getItemWeightById(id, quanty).." Capacity)")
							end
						end
					end
				itemr:free()
				if not(result:next()) then
					break
				end
			end
			result:free()
		end
	return true
end

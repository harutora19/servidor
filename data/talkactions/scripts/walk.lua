function onSay(cid, words, param)

	if not isRiderOrFlyOrSurf(cid) then
		doPlayerSendCancel(cid, "Você só pode usar esse comando enquanto estiver em ride/fly/surf.")
		return true
	end
	
	if not isPremium(cid) then
		doPlayerSendCancel(cid, "Somente membros VIP podem utilizar esse comando.")
		return true
	end
	
	local function doWalk(cid)
		
		if not isCreature(cid) then
			return true
		end
 
		
		local pos = getThingPos(cid)
		if (getCreatureLookDirection(cid) == 1) then
			pos.x = pos.x + 1
		elseif (getCreatureLookDirection(cid) == 2) then
			pos.y = pos.y + 1
		elseif (getCreatureLookDirection(cid) == 3) then
			pos.x = pos.x - 1
		elseif (getCreatureLookDirection(cid) == 0) then
			pos.y = pos.y - 1
		end
		
		if getTileInfo(pos).house then 
			doPlayerSendCancel(cid, "Você não pode fazer isso com itens de houses.") 
			return true
		end 		
		
		if not isWalkable(pos, true, false, false, false) then
			setPlayerStorageValue(cid, 30, -1)
			return true
		end
		
		if getPlayerStorageValue(cid, 30) == -1 then
			setPlayerStorageValue(cid, 30, -1)
			return true
		end
		--doMoveCreature(cid, getCreatureLookDirection(cid))
		-- if isRecording(cid) then
			-- movePlayerListWatchingMe(cid, pos)
		-- end	
		
		doTeleportThing(cid, pos, true)
		addEvent(function() doWalk(cid) end, getStepDelay(cid) * 0.8)
	end
	
	-- setPlayerStorageValue(cid, 30, tonumber(getPlayerStorageValue(cid, 30)) * -1)
	if getPlayerStorageValue(cid, 30) < os.time() then
		doWalk(cid)
		setPlayerStorageValue(cid, 30, os.time() + 2)
	else
		doPlayerSendCancel(cid, "Náo foi possivel utilizar este comando.") 
	end
	
	return true
end

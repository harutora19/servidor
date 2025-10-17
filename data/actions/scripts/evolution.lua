function onUse(cid, item, frompos, item2, topos)
	local evo = evolveWithItem[getCreatureName(item2.uid)]
	-- if not evo then return true end
	if not isMonster(item2.uid) or not isSummon(item2.uid) then
		return true
	end
	if #getCreatureSummons(cid) > 1 then
		return true
	end
	if not isPlayer(getCreatureMaster(item2.uid)) or getCreatureMaster(item2.uid) ~= cid then
		doPlayerSendCancel(cid, "You can only use stones on pokemons you own.")
		return true
	end
	local newEvo = evolveWithItem[getCreatureName(item2.uid)].nextEvolve
	local itemInfo = evolveWithItem[getCreatureName(item2.uid)].itemToEvolve
	local stone = getItemIdByName(itemInfo)
	-- if evo.stone ~= item.stone then 
		-- doPlayerSendCancel(cid, "This isn't the needed stone to evolve this pokemon.")
		-- return true
	-- end
	if not newEvo then return true end
	if evo then
		if doPlayerRemoveItem(cid, stone, 1) then
			doEvolvePokemon(cid, item2, newEvo, stone)
		end
	end
return true
end  
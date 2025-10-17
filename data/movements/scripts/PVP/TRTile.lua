local towns = {
--[action id] = {pos de volta}
[33710] = 1, -- saffron
[33711] = 2, -- cerulean
[33712] = 3, -- celadon
[33713] = 4, -- Lavender
[33714] = 5, -- vermillion
[33715] = 6, -- fuchsia
[33716] = 7, -- Cinnabar
[33717] = 8, -- viridian
[33718] = 9, -- pewter
[33719] = 11, -- phenac
[33720] = 12, -- agate
}

function onStepIn(cid, item, pos)

	if isSummon(cid) then
		return false
	end
	local townid = getPlayerStorageValue(cid, 33800) > 0 and getPlayerStorageValue(cid, 33800) or 1
	local town = getTownTemplePosition(townid, false)
	if item.actionid == 33799 then
		doTeleportThing(cid, town)
	else
		local pospvp = {x = 2879, y = 199, z = 7} -- pos TR
		doTeleportThing(cid, pospvp)
		if towns[item.actionid] then setPlayerStorageValue(cid, 33800, towns[item.actionid]) end
	end
	local posi = getPlayerPosition(cid)
	if #getCreatureSummons(cid) >= 1 then
	   for i = 1, #getCreatureSummons(cid) do
		   doTeleportThing(getCreatureSummons(cid)[i], {x=posi.x - 1, y=posi.y, z=posi.z}, false)
	   end
	end 
	
return true
end
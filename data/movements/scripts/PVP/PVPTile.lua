local towns = {
--[action id] = {pos de volta}
[33691] = 1, -- saffron
[33692] = 2, -- cerulean
[33693] = 3, -- celadon
[33694] = 4, -- Lavender
[33695] = 5, -- vermillion
[33696] = 6, -- fuchsia
[33697] = 7, -- Cinnabar
[33698] = 8, -- viridian
[33699] = 9, -- pewter
[33700] = 11, -- phenac
[33701] = 12, -- agate

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
		local pospvp = {x = 2804, y = 223, z = 7} -- pos TC
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
local clanTile = {
[33800] = {x = 2745, y = 369, z = 7},
[33801] = {x = 2797, y = 369, z = 7},
[33802] = {x = 2849, y = 369, z = 7},
[33803] = {x = 2901, y = 369, z = 7},
[33804] = {x = 2953, y = 369, z = 7},
[33805] = {x = 2745, y = 428, z = 7},
[33806] = {x = 2797, y = 428, z = 7},
[33807] = {x = 2849, y = 428, z = 7},
[33808] = {x = 2901, y = 428, z = 7},
[33809] = {x = 2953, y = 428, z = 7},
}

function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
	if item.actionid == 33810 then
		doTeleportThing(cid, {x = 2804, y = 186, z = 6}, false)
	else
		doTeleportThing(cid, clanTile[item.actionid], false)
	end
return true
end
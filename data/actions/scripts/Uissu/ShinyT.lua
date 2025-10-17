local t = {
	-- ["Shiny Honchkrow"] = {4, "Wingeon"},
	-- ["Shiny Infernape"] = {1, "Volcanic"},
	-- ["Shiny Empoleon"] = {2, "Seavel"}, 
	-- ["Shiny Luxray"] = {9, "Raibolt"},
	-- ["Shiny Gardevoir"] = {7, "Psycraft"},           
	-- ["Shiny Torterra"] = {3, "Orebound"},
	-- ["Shiny Sceptile"] = {8, "Naturia"},
	-- ["Shiny Honchkrow"] = {5, "Malefic"},
	-- ["Shiny Gallade"] = {6, "Gardestrike"},
	-- ["Shiny Empoleon"] = {10, "Ironhard"},
	["Shiny Dragonite"] = {4, "Wingeon"},
	["Shiny Torkoal"] = {1, "Volcanic"},
	["Shiny Swampert"] = {2, "Seavel"}, 
	["Shiny Manectric"] = {9, "Raibolt"},
	["Shiny Grumpig"] = {7, "Psycraft"},           
	["Shiny Flygon"] = {3, "Orebound"},
	["Shiny Sceptile"] = {8, "Naturia"},
	["Shiny Ursaring"] = {5, "Malefic"},
	["Shiny Gallade"] = {6, "Gardestrike"},
	["Shiny Bronzong"] = {10, "Ironhard"},
}

function onUse(cid, item, topos, item2, frompos)

	local poke = ""
	for i,v in pairs(t) do
		if getPlayerClanNum(cid) == v[1] then
			poke = i
			break
		end
	end
	if poke ~= "" then
		doSendMsg(cid, "You've exchanged your shiny ticket for a ".. poke ..".")
		addPokeToPlayer(cid, poke, 0, "heavy")
		doSendMagicEffect(getThingPos(cid), 27)
		if not isGod(cid) then doRemoveItem(item.uid, 1) end
	else
		doPlayerSendCancel(cid, "You need to be in a clan to exchange your shiny ticket.")
	end
	return true
end

local a = {
[12339] = {pokemons = {"Giant Magikarp", "Dragonite", "Snorlax", "Kabutops", "Omastar", "Politoed", "Kingdra", "Ampharos", "Blissey", "Donphan", "Girafarig", "Magcargo", "Mantine", "Miltank", "Porygon2", "Xatu", "Skarmory", "Lapras", "Gyarados", "Magmar", "Electabuzz", "Jynx", "Scyther", "Kangaskhan", "Venusaur", "Crobat", "Heracross", "Meganium", "Noctowl", "Piloswine", "Scizor", "Stantler", "Quagsire", "Machamp", "Poliwrath", "Arcanine", "Nidoking", "Nidoqueen", "Charizard", "Blastoise", "Tentacruel", "Alakazam", "Feraligatr", "Granbull", "Houndoom", "Gengar", "Rhydon", "Misdreavus", "Wobbuffet", "Raichu", "Slowking", "Steelix", "Sudowoodo", "Typhlosion", "Tyranitar", "Ursaring", "Pidgeot", "Sandslash", "Murkrow", "Clefable", "Wigglytuff", "Cloyster", "Exeggutor", "Lanturn", "Lickitung", "Mr. Mime", "Porygon", "Sneasel"}}
}
                 
function onUse(cid, item, frompos, item2, topos)
	local b = a[item.itemid]                                    
	if not b then return true end
	local pokemon = b.pokemons[math.random(#b.pokemons)]
	if not pokes[pokemon] then return true end  
	if doRemoveItem(item.uid, 1) then
		doPlayerSendTextMessage(cid, 27, "You opened a Pokemon box boosted +50!")
		doPlayerSendTextMessage(cid, 27, "The prize pokemon was a "..pokemon..", congratulations!")
		doSendMagicEffect(getThingPos(cid), 29)
		addPokeToPlayer(cid, pokemon, 50, btype)
	end
return true
end
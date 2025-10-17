local focus = 0
local talk_start = 0
local conv = 0
local cost = 0
local pname = ""
local baseprice = 0
local pokePrice = {
["Charmander"] = 1500,
["Charmeleon"] = 3500, 
["Charizard"] = 8000,
["Bulbasaur"] =  1500,
["Ivysaur"] =  3500,
["Venusaur"] =  8000,
["Squirtle"] =  1500,
["Wartortle"] =  3500,
["Blastoise"] =  8000,
["Caterpie"] =  50,
["Metapod"] =  300,
["Butterfree"] =  2500,
["Weedle"] =  50,
["Kakuna"] =  300,
["Beedrill"] =  2500,
["Pidgey"] =  60,
["Pidgeotto"] =  1500,
["Pidgeot"] =  8000,
["Rattata"] =  5,
["Raticate"] =  1800,
["Spearow"] =  100,
["Fearow"] =  4500,
["Ekans"] =  1500,
["Arbok"] =  3500,
["Pikachu"] =  4500,
["Raichu"] =  8000,
["Sandshrew"] =  1500,
["Sandslash"] =  6000,
["Nidoran Female"] =  300,
["Nidorina"] =  2500,
["Nidoqueen"] =  8000,
["Nidoking"] =  8000,
["Nidoran Male"] =  300,
["Nidorino"] =  2500,
["Nidoqueen"] = 10000,
["Clefairy"] =  3500,
["Clefable"] =  8000,
["Vulpix"] =  1500,
["Ninetales"] = 8000,
["Jigglypuff"] =  3500,
["Wigglytuff"] =  10000,
["Zubat"] =  120,
["Golbat"] =  3500,
["Oddish"] =  50,
["Gloom"] =  2500,
["Vileplume"] =  4500,
["Paras"] =  30,
["Parasect"] =  4500, 
["Venonat"] =  1500,
["Venomoth"] =  4500,
["Diglett"] =  300,
["Dugtrio"] =  3500,
["Meowth"] =  1500,
["Persian"] =  4500,
["Psyduck"] =  1500,
["Golduck"] =  6000,
["Mankey"] =  300,
["Primeape"] =  4500,
["Growlithe"] =  2500,
["Arcanine"] =  60000,
["Poliwag"] =  80,
["Poliwhirl"] =  2500,
["Poliwrath"] =  8000,
["Abra"] =  300,
["Kadabra"] =  3500,
["Alakazam"] =  16000,
["Machop"] =  2000,
["Machoke"] =  3500,
["Machamp"] =  9500,
["Bellsprout"] =  80,
["Weepinbell"] =  2500,
["Victreebel"] =  6000,
["Tentacool"] =  300,
["Tentacruel"] =  8000,
["Geodude"] =  300,
["Graveler"] =  3500,
["Golem"] =  8000,
["Ponyta"] =  1500,
["Rapidash"] =  6500,
["Slowpoke"] =  300,
["Slowbro"] =  4500,
["Magnemite"] =  300,
["Magneton"] =  6000,
["Farfetch'd"] =  4500,
["Doduo"] =  300,
["Dodrio"] =  4500,
["Seel"] =  800,
["Dewgong"] = 5000,
["Grimer"] =  1500,
["Muk"] =  8000,
["Shellder"] =  300,
["Cloyster"] =  5000,
["Gastly"] =  2500,
["Haunter"] =  5000,
["Gengar"] =  8000,
["Onix"] =  4500,
["Drowzee"] =  2500,
["Hypno"] =  4500,
["Krabby"] =  300,
["Kingler"] =  3500,
["Voltorb"] =  300,
["Electrode"] =  3500,
["Exeggcute"] = 300,
["Exeggutor"] =  8000,
["Cubone"] =  1500,
["Marowak"] =  5500,
["Hitmonlee"] =  5000,
["Hitmonchan"] =  5000,
["Lickitung"] =  25000,
["Koffing"] =  300,
["Weezing"] =  4500,
["Rhyhorn"] =  2500,
["Rhydon"] =  8000,
["Chansey"] =  21000,
["Tangela"] =  5450,
["Kangaskhan"] = 35000,
["Horsea"] =  300,
["Seadra"] =  3500,
["Goldeen"] =  300,
["Seaking"] =  3500,
["Staryu"] =  200,
["Starmie"] =  8000,
["Mr. Mime"] =  30000,
["Scyther"] =  45000,
["Jynx"] =  40000,
["Electabuzz"] =  8000,
["Magmar"] =  9500,
["Pinsir"] =  9500,
["Tauros"] =  4500,
["Magikarp"] =  5,
["Gyarados"] =  15600,
["Lapras"] =  45000,
["Ditto"] =  10000,
["Eevee"] =  1500,
["Vaporeon"] =  9500,
["Jolteon"] =  9500,
["Flareon"] =  9500,
["Porygon"] =  7500,
["Omanyte"] =  1500,
["Omastar"] =  15000,
["Kabuto"] =  1500,
["Kabutops"] =  16500,
["Aerodactyl"] =  100000,
["Snorlax"] =  50000,
["Dratini"] =  2500,
["Dragonair"] =  23000,
["Dragonite"] =  50000,
 
-- Segunda Geração

["Chikorita"] = 1500,
["Bayleef"] = 3500,
["Meganium"] = 8000,
["Cydaquil"] = 3000,
["Quilava"] = 3500,
["Typhlosion"] = 8000,
["Totodile"] = 1500,
["Croconaw"] = 3500,
["Feraligatr"] = 8000,
["Sentret"] = 300,
["Furret"] = 3500,
["Hoothoot"] = 1500,
["Noctowl"] = 5000,
["Ledyba"] = 300,
["Ledian"] = 3500,
["Spinarak"] = 300,
["Ariados"] = 3500,
["Crobat"] = 25000,
["Chinchou"] = 300,
["Lanturn"] = 8000,
["Pichu"] = 1500,
["Cleffa"] = 1500,
["Igglybuff"] = 1500,
["Togepi"] = 15000,
["Togetic"] = 8000,
["Natu"] = 2500,
["Xatu"] = 8000,
["Mareep"] = 1500,
["Flaaffy"] = 3500,
["Ampharos"] = 8000,
["Bellossom"] = 5600,
["Marill"] = 1500,
["Azumarill"] = 8000,
["Sudowoodo"] = 50000,
["Politoed"] = 6000,
["Hoppip"] = 80,
["Skiploom"] = 2500,
["Jumpluff"] = 4600,
["Aipom"] = 3500,
["Sunkern"] = 50,
["Sunflora"] = 2500,
["Yanma"] = 9000,
["Wooper"] = 1500,
["Quagsire"] = 5000,
["Espeon"] = 23000,
["Umbreon"] = 23000,
["Murkrow"] = 5670,
["Slowking"] = 11000,
["Misdreavus"] = 25000,
["Wobbuffet"] = 25000,
["Girafarig"] = 25000,
["Pineco"] = 300,
["Forretress"] = 8000,
["Dunsparce"] = 2500,
["Gligar"] = 3500,
["Steelix"] = 23500,
["Snubbull"] = 2500,
["Granbull"] = 8000,
["Qwilfish"] = 4500,
["Scizor"] = 25300,
["Shuckle"] = 3500,
["Heracross"] = 25000,
["Sneasel"] = 4500,
["Teddiursa"] = 10000,
["Ursaring"] = 25400,
["Slugma"] = 300,
["Magcargo"] = 8000,
["Swinub"] = 300,
["Piloswine"] = 8000,
["Corsola"] = 4500,
["Remoraid"] = 300,
["Octillery"] = 6000,
["Delibird"] = 4500,
["Mantine"] = 35000,
["Skarmory"] = 30000,
["Houndour"] = 1500,
["Houndoom"] = 23500,
["Kingdra"] = 70000,
["Phanpy"] = 1500,
["Donphan"] = 8000,
["Porygon2"] = 15000,
["Stantler"] = 4500,
["Tyrogue"] = 11500,
["Hitmontop"] = 13350,
["Smoochum"] = 2500,
["Elikid"] = 45000,
["Magby"] = 2500,
["Miltank"] = 30000,
["Blissey"] = 30000,
["Larvitar"] = 3500,
["Pupitar"] = 35000,
["Electivire"] = 125000,
["Magmortar"] = 125000,
["Tyranitar"] = 125000,
-- shiny --
["Shiny Fearow"] = 500000,
["Shiny Vileplume"] = 500000,
["Shiny Golem"] = 500000,
["Shiny Nidoking"] = 500000,
["Shiny Hypno"] = 500000,
["Shiny Vaporeon"] = 500000,
["Shiny Jolteon"] = 500000,
["Shiny Flareon"] = 500000,
["Shiny Hitmontop"] = 200000,
}

local gastostones = {
[0] = 0,
[1] = 1,
[2] = 2,
[3] = 3,
[4] = 4,
[5] = 6,
[6] = 8,
[7] = 10,
[8] = 12,
[9] = 15,
[10] = 18,
[11] = 21,
[12] = 24,
[13] = 28,
[14] = 32,
[15] = 36,
[16] = 40,
[17] = 45,
[18] = 50,
[19] = 55,
[20] = 60,
[21] = 66,
[22] = 72,
[23] = 78,
[24] = 84,
[25] = 91,
[26] = 98,
[27] = 105,
[28] = 112,
[29] = 120,
[30] = 128,
[31] = 136,
[32] = 144,
[33] = 153,
[34] = 162,
[35] = 171,
[36] = 180,
[37] = 190,
[38] = 200,
[39] = 210,
[40] = 220,
[41] = 231,
[42] = 242,
[43] = 253,
[44] = 264,
[45] = 276,
[46] = 288,
[47] = 300,
[48] = 312,
[49] = 325,
[50] = 338,
}
function sellPokemon(cid, name, price)

	local bp = getPlayerSlotItem(cid, CONST_SLOT_BACKPACK)
    if #getCreatureSummons(cid) >= 1 then
       selfSay("Back your pokemon to do that!")
       focus = 0                                --alterado v1.8
       return true
    end
    local storages = {17000, 63215, 17001, 13008, 5700}   --alterado v1.8
    for s = 1, #storages do
        if getPlayerStorageValue(cid, storages[s]) >= 1 then
           selfSay("You can't do that while is Flying, Riding, Surfing, Diving or mount a bike!") 
           focus = 0 
           return true
        end
    end
    if getPlayerSlotItem(cid, 8).uid ~= 0 then 
	local boosts = getItemAttribute(getPlayerSlotItem(cid, 8).uid, "boost") or 0
		local precocertos = ((gastostones[boosts] ))
       if string.lower(getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke")) == string.lower(name) then
          if not getItemAttribute(getPlayerSlotItem(cid, 8).uid, "unique") then  --alterado v1.6
             selfSay("Wow! Thanks for this wonderful "..name.."! Take yours "..price.." dollars. Would you like to sell another pokemon?")
             doPlayerAddMoney(cid, (price) + precocertos)
			 doRemoveItem(getPlayerSlotItem(cid, 8).uid, 1)
             doTransformItem(getPlayerSlotItem(cid, CONST_SLOT_LEGS).uid, 2395)
             return true
          end
       end
    end   
       
	for a, b in pairs(pokeballs) do
		local balls = getItemsInContainerById(bp.uid, b.on)
		for _, ball in pairs (balls) do
			local boost = getItemAttribute(ball, "boost") or 0
			local precocerto = ((gastostones[boost]) )
			if string.lower(getItemAttribute(ball, "poke")) == string.lower(name) then
				if not getItemAttribute(ball, "unique") then --alterado v1.6
                   selfSay("Wow! Thanks for this wonderful "..getItemAttribute(ball, "poke").."! Take yours "..price.." dollars. Would you like to sell another pokemon?")
				   doPlayerAddMoney(cid, price + precocerto)
				   doRemoveItem(ball, 1)
	               return true
                end
			end
		end
	end

	selfSay("You don't have a "..name..", make sure it is in your backpack and it is not fainted and it is not in a Unique Ball!")  --alterado v1.6
return false
end

function onCreatureSay(cid, type, msg)

	local msg = string.lower(msg)

	if string.find(msg, "!") or string.find(msg, ",") then
	return true
	end

	if focus == cid then
		talk_start = os.clock()
	end

	if msgcontains(msg, 'hi') and focus == 0 and getDistanceToCreature(cid) <= 3 then
		selfSay('Welcome to my store! I buy pokemons of all species, just tell me the name of the pokemon you want to sell.')
		focus = cid
		conv = 1
		talk_start = os.clock()
		cost = 0
		pname = ""
	return true
	end

	if msgcontains(msg, 'bye') and focus == cid then
		selfSay('See you around then!')
		focus = 0
	return true
	end

	if msgcontains(msg, 'yes') and focus == cid and conv == 4 then
		selfSay('Tell me the name of the pokemon you would like to sell.')
		conv = 1
	return true
	end

	if msgcontains(msg, 'no') and conv == 4 and focus == cid then
		selfSay('Ok, see you around then!')
		focus = 0
	return true
	end

	local common = {"rattata", "caterpie", "weedle", "magikarp"}

	if conv == 1 and focus == cid then
		for a = 1, #common do
			if msgcontains(msg, common[a]) then
				selfSay('I dont buy such a common pokemon!')
			return true
			end
		end
	end

	if msgcontains(msg, 'no') and conv == 3 and focus == cid then
		selfSay('Well, then what pokemon would you like to sell?')
		conv = 1
	return true
	end

	if (conv == 1 or conv == 4) and focus == cid then
		local name = doCorrectPokemonName(msg)
		local pokemon = pokes[name]
		if not pokemon then
			selfSay("Sorry, I don't know what pokemon you're talking about! Are you sure you spelled it correctly?")
		return true
		end

        cost = pokePrice[name]
        pname = name
		if not cost then print(name .. " Pokemon nao esta registrado no Pokemon Collector, colocar preco e nome na tabela.") return true end
        selfSay("Are you sure you want to sell a "..name.." for "..cost.." dollars + boost?")
        conv = 3       
	end

	if isConfirmMsg(msg) and focus == cid and conv == 3 then
		if sellPokemon(cid, pname, cost) then
			conv = 4
		else
			conv = 1
		end
	return true
	end

end

local intervalmin = 38
local intervalmax = 70
local delay = 25
local number = 1
local messages = {"Buying some beautiful pokemons! Come here to sell them!",
		  "Wanna sell a pokemon? Came to the right place!",
		  "Buy pokemon! Excellent offers!",
		  "Tired of a pokemon? Why don't you sell it to me then?",
		 }

function onThink()

	-- if focus == 0 then
		-- selfTurn(1)
		-- return true
	-- else

	if not isCreature(focus) then
		focus = 0
	return true
	end

		local npcpos = getThingPos(getThis())
		local focpos = getThingPos(focus)

		if npcpos.z ~= focpos.z then
			focus = 0
		return true
		end
		if (os.clock() - talk_start) > 70 then
			focus = 0
			selfSay("I have other clients too, talk to me when you feel like selling a pokemon.")
		end

		if getDistanceToCreature(focus) > 3 then
			selfSay("Good bye then and thanks!")
			focus = 0
		return true
		end

		-- local dir = doDirectPos(npcpos, focpos)	
		-- selfTurn(dir)
	-- end


return true
end 
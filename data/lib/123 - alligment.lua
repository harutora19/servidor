--rocket vs police
--npc por level
--andares de prédios
--nomes e teams aleatórios
--statschange police e rocket
--playerattack police e rocket
-- 605 rfemale 604 rmale
-- 1184 pfemale 1183 pmale

stor_npcmypoke = 38993
stor_npcsex = 38994
stor_pokemaster = 38995
stor_npcalign = 38996
stor_npcname = 38997
stor_npcexp = 38998
stor_npclevel = 38999
stor_npcteam = 39000

local npc_names = {
[0] = {"Amelia", "Elsie", "Tiana", "Alicia", "Skye", "Larissa", "Karli", "Aliana", "Skylar", "Theresa", "Summer", "Sanaa", "Cora", "Alani", "Riley", "Nylah", "Kaliyah", "Mareli", "Mikayla", "Sandra", "Avah", "Brianna", "Lana", "Lizbeth", "Macey", "Maryjane", "Bryanna", "Eve", "Kaila", "Tara", "Rayne", "Eden", "Talia", "Kara", "Peyton", "Jillian", "Yesenia", "Bianca", "Alondra", "Maritza", "Anabelle", "Cailyn", "Julianna", "Margaret", "Cassandra", "Jamya", "Clare", "Ann", "Mackenzie", "Kendal", "Jayla", "Zariah", "Maci", "Faith", "Daniella", "Haley", "Kimberly", "Makaila", "Hillary", "Heaven", "Libby", "Salma", "Rosemary", "Madelyn", "Lilia", "Yuliana", "Regan", "Mireya", "Ally", "Samantha", "Laci", "Selena", "Jaylene", "Julissa", "Virginia", "Maddison", "Cierra", "Kaylin", "Desiree", "Evie", "Georgia", "Kaitlyn", "Naomi", "Katrina", "Malia", "Kathryn", "Taliyah", "Mayra", "Melina", "Marina", "Carly", "Janiyah", "Charity", "Aisha", "Jacquelyn", "Abril", "Marlie", "Mckinley", "Shyla", "Kaya", "Carlie", "Gracelyn"},
[1] = {"Hunt", "Elias", "Alfred", "Cameron", "Jorge", "Travis", "Jamarcus", "Salvatore", "Geovanni", "Marcel", "Carsen", "Aryan", "Giancarlo", "Zavier", "Memphis", "Aaron", "Gavyn", "Jude", "Bryant", "Jerome", "Michael", "Gary", "Chaz", "Braiden", "Sammy", "Chris", "Xzavier", "German", "Cristian", "Porter", "Rohan", "Kamari", "Muhammad", "Kyson", "Cyrus", "Orlando", "Erik", "Tyrell", "Devyn", "Trevin", "Nolan", "Santiago", "Marlon", "Jack", "Davion", "Brayan", "Ross", "Edward", "Reagan", "Ernest", "Shaun", "Asher", "Winston", "Jesse", "Owen", "Harold", "Fernando", "Messiah", "Noah", "Scott", "Rudy", "Cedric", "Easton", "Makhi", "Landon", "Bronson", "Jeremiah", "Braylon", "Semaj", "Braxton", "Jordon", "Caden", "Elliott", "Dexter", "Samuel", "Amari", "Tucker", "Odin", "Kadin", "Broderick", "Deegan", "Augustus", "Christopher", "Jaeden", "Ishaan", "Bridger", "Jayden", "Carson", "Quinten", "Bentley", "Jax", "Levi", "Jasper", "Quincy", "Maddox", "Cale", "River", "Paul", "Ari", "Ricardo", "Krish", "Kale"},
}

local npc_out = {
	['rocket'] = {
		[0] = {605},
		[1] = {604},
			},
	['police'] = {
		[0] = {1184},
		[1] = {1183},
			},
}

local npc_pokes = {
['rocket'] = {
	[80] = {"Arbok", "Muk", "Weezing", "Victreebel", "Pinsir", "Yanma", "Cloyster", "Gengar", "Kingler", "Machamp", "Rhydon", "Charizard", "Jynx"},
	[120] = {"Houndoom", "Shiny Muk", "Shiny Weezing", "Venusaur", "Shiny Pinsir", "Shiny Jynx", "Shiny Exeggutor", "Gengar", "Shiny Kingler", "Shiny Machamp", "Shiny Golem", "Shiny Flareon", "Shiny Hitmontop"},
	[150] = {"Shiny Kabutops", "Shiny Muk", "Weezing", "Shiny Venusaur", "Shiny Scyther", "Shiny Magmar", "Dragonite", "Shiny Gengar", "Slowking", "Aerodactyl", "Shiny Rhydon", "Shiny Charizard", "Shiny Xatu"},
	[200] = {"Shiny Blastoise", "Shiny Electabuzz", "Shiny Pinsir", "Shiny Jolteon", "Shiny Typhlosion", "Shiny Umbreon", "Shiny Ariados", "Shiny Gengar", "Shiny Alakazam", "Shiny Heracross", "Shiny Infernape", "Shiny Charizard", "Shiny Jynx"},
	[250] = {"Tyranitar", "Venusaur", "Glalie", "Blastoise", "Crawdaunt", "Gengar", "Alakazam", "Kangaskhan", "Shiny Magmortar", "Shiny Flygon", "Shiny Golem", "Shiny Gengar", "Shiny Venusaur"},
			},
['police'] = {
	[80] = {"Arcanine", "Shiny Butterfree", "Alakazam", "Victreebel", "Pinsir", "Yanma", "Cloyster", "Gengar", "Kingler", "Machamp", "Rhydon", "Charizard", "Jynx"},
	[120] = {"Arcanine", "Shiny Muk", "Shiny Weezing", "Venusaur", "Shiny Pinsir", "Shiny Jynx", "Shiny Exeggutor", "Gengar", "Shiny Kingler", "Shiny Machamp", "Shiny Golem", "Shiny Flareon", "Shiny Hitmontop"},
	[150] = {"Shiny Kabutops", "Shiny Muk", "Weezing", "Shiny Venusaur", "Shiny Scyther", "Shiny Magmar", "Dragonite", "Shiny Gengar", "Slowking", "Aerodactyl", "Shiny Rhydon", "Shiny Charizard", "Shiny Xatu"},
	[200] = {"Shiny Blastoise", "Shiny Electabuzz", "Shiny Pinsir", "Shiny Jolteon", "Shiny Typhlosion", "Shiny Umbreon", "Shiny Ariados", "Shiny Gengar", "Shiny Alakazam", "Shiny Heracross", "Shiny Infernape", "Shiny Charizard", "Shiny Jynx"},
	[250] = {"Aerodactyl", "Venusaur", "Glalie", "Blastoise", "Crawdaunt", "Gengar", "Alakazam", "Kangaskhan", "Shiny Magmortar", "Shiny Flygon", "Shiny Golem", "Shiny Gengar", "Shiny Venusaur"},
			},
}

local npc_colors = {85, 82, 79, 78, 77, 94}

function doSummonWildNPCA(pos, alignment, level)

	local thislevel, counter = 0, 0
	for index,t in pairs(npc_pokes[alignment]) do
		if index <= level then
			counter = counter + 1
			thislevel = index
		end
	end
	
	local sex = math.random(0, 1)
	local nick = npc_names[sex][math.random(#npc_names[sex])]
	local wildNPC = doCreateMonsterNick(121212, "NPCA", nick, pos, false)
	local out = npc_out[alignment][sex][1]
	if wildNPC ~= "Nao" then	
		doSetCreatureOutfit(wildNPC, {lookType = out}, -1)
		doSetCreatureOutfit(wildNPC, {lookType = out, lookHead = 116, lookBody = npc_colors[counter], lookLegs = npc_colors[counter], lookFeet = 76}, -1)
		--setCreatureTargetDistance(wildNPC, 4) 
		--setPlayerStorageValue(wildNPC, storages.isWildTrainer, 1)
		setPlayerStorageValue(wildNPC, stor_npcteam, 6)
		setPlayerStorageValue(wildNPC, stor_npcsex, sex)
		setPlayerStorageValue(wildNPC, stor_npcname, nick)
		setPlayerStorageValue(wildNPC, stor_npclevel, level)
		setPlayerStorageValue(wildNPC, stor_npcalign, alignment)
		--setPlayerStorageValue(wildNPC, storages.NPCPOSDESC, desc)
		--setPlayerStorageValue(wildNPC, storages.NPCCITY, city)
		doSetNPCAPokemons(wildNPC, alignment, level)
		doSummonNextPokemon(wildNPC)
		registerCreatureEvent(wildNPC, "AlignAttack")
		--setPokemonPassive(wildNPC, true)
	end 
	return wildNPC
end

function getCreatureAlignment(cid)
	local ret = getPlayerStorageValue(cid, stor_npcalign)
	if ret and isInArray({'police', 'rocket'}, ret) then return ret end
	return 'none'
end

function doSummonNextPokemon(npc)
	if getPlayerStorageValue(npc, stor_npcteam) <= 0 then return true end
	local mylevel = getPlayerStorageValue(npc, stor_npclevel)
	local pokeToSummon = getPlayerStorageValue(npc, stor_npcteam + getPlayerStorageValue(npc, stor_npcteam))
	local npcPoke = doCreateMonsterNick(npc, pokeToSummon, retireShinyName(pokeToSummon), getThingPos(npc), false)
	local myalign = getCreatureAlignment(npc)
	if getCreatureTarget(npc) >= 1 then
	   local master = not isPlayer(getCreatureTarget(npc)) and getCreatureMaster(getCreatureTarget(npc)) or getCreatureTarget(npc)
	   doSetPokemonAgressiveToPlayer(npcPoke, master)
	end
	setPlayerStorageValue(npcPoke, stor_pokemaster, npc)
	setPlayerStorageValue(npcPoke, stor_npcalign, myalign)
	setPlayerStorageValue(npc, stor_npcmypoke, npcPoke)
	if mylevel >= 250 then checkChenceToMega(npcPoke, true) end -- megas no 250
	adjustNPCPoke(npcPoke, math.max(1, math.floor(mylevel/100)), mylevel)
	local mgo = gobackmsgs[math.random(1, #gobackmsgs)].go:gsub("doka", retireShinyName(pokeToSummon))
	doCreatureSay(npc, mgo, TALKTYPE_ORANGE_1)
	doSendMagicEffect(getThingPos(npcPoke), 376)
	registerCreatureEvent(npcPoke, "AlignAttack")
	--setPokemonPassive(npcPoke, true)
end

function getNPCSummon(npc)
	local mypoke = getPlayerStorageValue(npc, stor_npcmypoke)
	if not isCreature(mypoke) then return false end
	return mypoke
end

function doSetNPCAPokemons(npc, alignment, level)
	local thislevel, counter = 0, 0
	for index,t in pairs(npc_pokes[alignment]) do
		if index <= level then
			counter = counter + 1
			thislevel = index
		end
	end
	for x=1,6 do
		setPlayerStorageValue(npc, stor_npcteam+x, npc_pokes[alignment][thislevel][math.random(#npc_pokes[alignment][thislevel])]) -- ex: shiny muk, arbok, weezing
	end
end

function isNPCA(cid)
	return (getPlayerStorageValue(cid, stor_npclevel) and getPlayerStorageValue(cid, stor_npclevel) > 0)
end

function getNPCMaster(cid)
	return getPlayerStorageValue(cid, stor_pokemaster)
end

function isNPCSummon(cid)
	return (getPlayerStorageValue(cid, stor_pokemaster) and getPlayerStorageValue(cid, stor_pokemaster) > 0)
end

function adjustNPCPoke(cid, rate, npclvl)

	if not isCreature(cid) then return true end
	
	local r = rate or 1
		
	local nick = doCorrectString(getCreatureName(cid))
    local level = npclvl
	
	if not pokes[nick] then return false end -- rever isto
	 
	setPlayerStorageValue(cid, 1000, level) --alterado v1.8
    setPlayerStorageValue(cid, 1001, pokes[nick].attack * (1 + r / 10) * (1 + level/100))
	setPlayerStorageValue(cid, 1002, pokes[nick].defense * (1 + r / 10) * (1 + level/100))
	setPlayerStorageValue(cid, 1003, pokes[nick].agility)                                  
	setPlayerStorageValue(cid, 1004, pokes[nick].vitality * level * r)
	setPlayerStorageValue(cid, 1005, pokes[nick].specialattack * (1 + r / 10) * (1 + level/100))
	
    doRegainSpeed(cid)	     --alterado!
		
	local pokeLifeMax = pokes[nick].life + (pokes[nick].vitality * npclvl * 4.25) * (1 + level/100)
	if r > 1 then
		pokeLifeMax = pokeLifeMax * r * 2
	end
	
	setCreatureMaxHealth(cid, pokeLifeMax)
	doCreatureAddHealth(cid, getCreatureMaxHealth(cid))
end

function updateNPCSummonPos(cid)
	local npc = getPlayerStorageValue(cid, stor_pokemaster)
	if not isCreature(npc) then
		return doRemoveCreature(cid)
	end
	local npcpos = getThingPos(npc)
	local p = getThingPos(cid)
	if getDistanceBetween(npcpos, p) == 3 then
	elseif getDistanceBetween(npcpos, p) >= 6 then
		doTeleportThing(cid, npcpos, false)
	elseif getDistanceBetween(npcpos, p) >= 4 then
	end
end

function getNPCLevel(cid)
	return getPlayerStorageValue(cid, stor_npclevel) or 0
end

function addAlignmentExp(cid, exp)
	return setPlayerStorageValue(cid, stor_npcexp, (getPlayerStorageValue(cid, stor_npcexp) or 0)+exp)
end

function getPlayerAlignmentExp(cid)
	return (getPlayerStorageValue(cid, stor_npcexp) or 0)
end

function getPlayerAlignmentLevel(cid)
	local myexp, ret = getPlayerStorageValue(cid, stor_npcexp) or 0, 0
	for x=1,#aliexptable do
		if myexp >= aliexptable[x] then
			ret = x
		end
	end	
	return ret
end

-- ON LOOK!

aliexptable = {
[1] = 0,
[2] = 100,
[3] = 200,
[4] = 400,
[5] = 800,
[6] = 1500,
[7] = 2600,
[8] = 4200,
[9] = 6400,
[10] = 9300,
[11] = 13000,
[12] = 17600,
[13] = 23200,
[14] = 29900,
[15] = 37800,
[16] = 47000,
[17] = 57600,
[18] = 69700,
[19] = 83400,
[20] = 98800,
[21] = 116000,
[22] = 135100,
[23] = 156200,
[24] = 179400,
[25] = 204800,
[26] = 232500,
[27] = 262600,
[28] = 295200,
[29] = 330400,
[30] = 368300,
[31] = 409000,
[32] = 452600,
[33] = 499200,
[34] = 548900,
[35] = 601800,
[36] = 658000,
[37] = 717600,
[38] = 780700,
[39] = 847400,
[40] = 917800,
[41] = 992000,
[42] = 1070100,
[43] = 1152200,
[44] = 1238400,
[45] = 1328800,
[46] = 1423500,
[47] = 1522600,
[48] = 1626200,
[49] = 1734400,
[50] = 1847300,
[51] = 1965000,
[52] = 2087600,
[53] = 2215200,
[54] = 2347900,
[55] = 2485800,
[56] = 2629000,
[57] = 2777600,
[58] = 2931700,
[59] = 3091400,
[60] = 3256800,
[61] = 3428000,
[62] = 3605100,
[63] = 3788200,
[64] = 3977400,
[65] = 4172800,
[66] = 4374500,
[67] = 4582600,
[68] = 4797200,
[69] = 5018400,
[70] = 5246300,
[71] = 5481000,
[72] = 5722600,
[73] = 5971200,
[74] = 6226900,
[75] = 6489800,
[76] = 6760000,
[77] = 7037600,
[78] = 7322700,
[79] = 7615400,
[80] = 7915800,
[81] = 8224000,
[82] = 8540100,
[83] = 8864200,
[84] = 9196400,
[85] = 9536800,
[86] = 9885500,
[87] = 10242600,
[88] = 10608200,
[89] = 10982400,
[90] = 11365300,
[91] = 11757000,
[92] = 12157600,
[93] = 12567200,
[94] = 12985900,
[95] = 13413800,
[96] = 13851000,
[97] = 14297600,
[98] = 14753700,
[99] = 15219400,
[100] = 15694800,
}
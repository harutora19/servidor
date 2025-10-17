towerSpawnPos = {
-- {posição, bioma}
{{x=208,y=864,z=6}, "rock"},
{{x=201,y=867,z=6}, "rock"},
{{x=192,y=869,z=6}, "rock"},
{{x=185,y=869,z=6}, "rock"},

{{x=185,y=876,z=6}, "fly"},
{{x=182,y=883,z=6}, "fly"},
{{x=182,y=892,z=6}, "fly"},
{{x=181,y=899,z=6}, "fly"},

{{x=209,y=890,z=6}, "fire"},
{{x=205,y=881,z=6}, "fire"},
{{x=199,y=889,z=6}, "fire"},
{{x=194,y=883,z=6}, "fire"},


{{x=187,y=904,z=6}, "desert"},
{{x=195,y=911,z=6}, "desert"},
{{x=193,y=919,z=6}, "desert"},
{{x=201,y=916,z=6}, "desert"},

{{x=209,y=917,z=6}, "ghost"},
{{x=216,y=922,z=6}, "ghost"},

{{x=194,y=931,z=6}, "electric"},
{{x=201,y=934,z=6}, "electric"},
{{x=213,y=936,z=6}, "electric"},
{{x=213,y=929,z=6}, "electric"},

{{x=234,y=915,z=6}, "ground"},
{{x=225,y=916,z=6}, "ground"},
{{x=223,y=917,z=6}, "ground"},
{{x=242,y=914,z=6}, "ground"},


{{x=248,y=908,z=6}, "snow"},
{{x=252,y=898,z=6}, "snow"},
{{x=252,y=887,z=6}, "snow"},
{{x=252,y=877,z=6}, "snow"},
{{x=254,y=868, z=6}, "dragon"},
{{x=249,y=869,z=6}, "dragon"},

{{x=239,y=868,z=6}, "moss"},
{{x=232,y=864,z=6}, "moss"},
{{x=223,y=866,z=6}, "moss"},
{{x=217,y=863,z=6}, "moss"},

{{x=219,y=910,z=6}, "fairy"},
{{x=211,y=904,z=6}, "fairy"},
{{x=218,y=898,z=6}, "fairy"},

{{x=230,y=900,z=6}, "water"},
{{x=238,y=901,z=6}, "water"},
{{x=235,y=891,z=6}, "water"},
}

towerBiomePokes = {
-- level = {['biome'] = {poke1, poke2}},
[1] = {
['rock'] = {'Golem', 'Rhydon', 'Kabutops', 'Omastar', 'Onix', 'Steelix', 'Tyranitar'},
['fly'] = {"Pidgeot", "Fearow", "Skarmory"},
['fire'] = {"Charizard", "Flareon", "Typhlosion", "Magcargo", "Houndoom", "Arcanine", "Ninetales"},
['desert'] = {"Espeon", "Umbreon", "Alakazam", "Hypno", "Xatu", "Wobbuffet"},
['electric'] = {"Magneton", "Jolteon", "Electabuzz", "Electrode", "Ampharos", "Raichu"},
['ground'] = {"Marowak", "Sandslash", "Donphan", "Pupitar"},
['snow'] = {"Dewgong", "Cloyster", "Jynx", "Piloswine"},
['dragon'] = {"Dragonite", "Kingdra", "Dragonair"},
['moss'] = {"Muk", "Weezing", "Venusaur", "Venomoth", "Scyther", "Pinsir", "Weezing", "Arbok", "Vileplume"},
['fairy'] = {"Granbull", "Snorlax", "Miltank", "Clefable", "Wigglytuff"},
['water'] = {"Gyarados", "Blastoise", "Vaporeon", "Mantine", "Octillery", "Lanturn", "Feraligatr"},
['ghost'] = {"Gengar", "Misdreavus"},
},
}

towerOutsidePos = {x=3979,y=4097,z=6}
towerGlobalStorage = 38319
towerPointsStorage = 38320
towerPotionStorage = 38321
towerReviveStorage = 38322
towerMonsterStorage = 38323
towerMonsterLevel = 38324
towerMonsterWildLvl = 38325
towerPlayerLevel = 38326
getPlayerTowerEntry = 38327
towerPlayerEnter = 38328
towerPosStart = {x=221,y=882,z=6}
towerPosBoss = towerPosStart
towerPosBoss.z = towerPosStart.z + 1
towerTopCorner = {x=171,y=856,z=6}
towerBottomCorner = {x=261,y=944,z=6}
towerTopBossCorner = {x=215,y=878,z=5}
towerBottomBossCorner = {x=227,y=886,z=5}

towerPoints = {
[1] = {points = 20, exp = 500000},
}

towerConfig = {
	reviveCount = {[1] = 3,},
	potionCount = {[1] = 50,},
	timeLimit = {[1] = 1800}, -- 30 minutos
	spawnMultiplier = {[1] = {1, 2}},
	pokeStatus = {[1] = {offense = 2.7, defense = 14.0, specialattack = 15.6, life = 50000, vitality = 15, agility = 250, boost = 75, level = 150, wildLvl = 500}}, -- level = boost
}

towerBosses = {
[1] = {'Rhyperior','Magmortar','Electivire','Dusknoir','Milotic','Metagross','Tangrowth','Magnezone','Slaking','Salamence'},
}

function doSendTrapDamage(pos, eff, dmg, name, color, area)
	local posf = {x=pos.x, y=pos.y, z=pos.z, stackpos=253}
	local arrs = {
		[2] = {{x=posf.x-1,y=posf.y,z=posf.z,stackpos=posf.stackpos},{x=posf.x-1,y=posf.y-1,z=posf.z,stackpos=posf.stackpos},{x=posf.x,y=posf.y-1,z=posf.z,stackpos=posf.stackpos},}, -- 2x2
		[3] = {{x=posf.x-1,y=posf.y,z=posf.z,stackpos=posf.stackpos},{x=posf.x-1,y=posf.y-1,z=posf.z,stackpos=posf.stackpos},{x=posf.x,y=posf.y-1,z=posf.z,stackpos=posf.stackpos},{x=posf.x,y=posf.y-2,z=posf.z,stackpos=posf.stackpos},{x=posf.x-1,y=posf.y-2,z=posf.z,stackpos=posf.stackpos},{x=posf.x-2,y=posf.y-2,z=posf.z,stackpos=posf.stackpos},{x=posf.x-2,y=posf.y-1,z=posf.z,stackpos=posf.stackpos},{x=posf.x-2,y=posf.y,z=posf.z,stackpos=posf.stackpos},}, -- 3x3
	}
	doSendMagicEffect(posf, eff)
	local pid = getThingFromPos(posf).uid
	local damage = math.random(dmg * 0.9, dmg * 1.1)
	if isCreature(pid) and not isWild(pid) then
		if getCreatureHealth(pid) < damage then
			doKillPlayer(pid, name, -damage)
		end
		doCreatureAddHealth(pid, -damage)
		if isSummon(pid) or isPlayer(pid) and damage > 0 then
			doSendAnimatedText(posf, "-".. damage, color or COLOR_RED)
			doSendMagicEffect(posf, 13)
		end
	end
	if arrs[area] then
		for i,ta in pairs(arrs[area]) do
			doSendTrapDamage(ta, 0, dmg, name, color)
		end
	end
end

towerTrapInfo = {
["magma"] = {color = COLOR_RED, damage = 4000, cycle = 3000, 
			arr = {
				{{x=211,y=881,z=6}, 309, 2, math.random(0, 1500)},
				{{x=212,y=884,z=6}, 309, 2, math.random(0, 1500)},
				{{x=207,y=881,z=6}, 309, 2, math.random(0, 1500)},
				{{x=208,y=884,z=6}, 309, 2, math.random(0, 1500)},
				{{x=203,y=881,z=6}, 309, 2, math.random(0, 1500)},
				{{x=202,y=884,z=6}, 309, 2, math.random(0, 1500)},
				{{x=205,y=886,z=6}, 309, 2, math.random(0, 1500)},
				{{x=209,y=888,z=6}, 309, 2, math.random(0, 1500)},
				{{x=211,y=891,z=6}, 309, 2, math.random(0, 1500)},
				{{x=209,y=892,z=6}, 309, 2, math.random(0, 1500)},
				{{x=211,y=887,z=6}, 309, 2, math.random(0, 1500)},
				{{x=202,y=887,z=6}, 309, 2, math.random(0, 1500)},
				{{x=199,y=887,z=6}, 309, 2, math.random(0, 1500)},
				{{x=200,y=890,z=6}, 309, 2, math.random(0, 1500)},
				{{x=198,y=885,z=6}, 309, 2, math.random(0, 1500)},
				{{x=197,y=883,z=6}, 309, 2, math.random(0, 1500)},
				{{x=199,y=882,z=6}, 309, 2, math.random(0, 1500)},
				{{x=204,y=883,z=6}, 309, 2, math.random(0, 1500)},
				{{x=206,y=888,z=6}, 309, 2, math.random(0, 1500)},
				{{x=202,y=892,z=6}, 309, 2, math.random(0, 1500)},
				{{x=209,y=879,z=6}, 309, 2, math.random(0, 1500)},
			}
		}, 
["desert"] = {color = COLOR_BROWN+1, damage = 6000, cycle = 4000, 
			arr = {
				{{x=185, y=913, z=6}, 311, 3, math.random(0, 2000)},
				{{x=189, y=912, z=6}, 311, 3, math.random(0, 2000)},
				{{x=191, y=910, z=6}, 311, 3, math.random(0, 2000)},
				{{x=192, y=907, z=6}, 311, 3, math.random(0, 2000)},
				{{x=195, y=909, z=6}, 311, 3, math.random(0, 2000)},
				{{x=191, y=918, z=6}, 311, 3, math.random(0, 2000)},
				{{x=195, y=918, z=6}, 311, 3, math.random(0, 2000)},
				{{x=197, y=914, z=6}, 311, 3, math.random(0, 2000)},
				{{x=200, y=913, z=6}, 311, 3, math.random(0, 2000)},
				{{x=199, y=917, z=6}, 311, 3, math.random(0, 2000)},
				{{x=196, y=920, z=6}, 311, 3, math.random(0, 2000)},
				{{x=200, y=921, z=6}, 311, 3, math.random(0, 2000)},
				{{x=203, y=923, z=6}, 311, 3, math.random(0, 2000)},
				{{x=203, y=918, z=6}, 311, 3, math.random(0, 2000)},
				{{x=204, y=914, z=6}, 311, 3, math.random(0, 2000)},
			}
		}, 
["rockEmote"] = {color = COLOR_GREY+1, damage = 0, cycle = 4000,
			arr = {
				{{x=210,y=864,z=6}, 310, 1, 0, 0},
				{{x=206,y=866,z=6}, 310, 1, 0, 0},
				{{x=201,y=868,z=6}, 310, 1, 0, 0},
				{{x=201,y=865,z=6}, 310, 1, 0, 0},
				{{x=196,y=869,z=6}, 310, 1, 0, 0},
			}
			},
["rock"] = {color = COLOR_GREY, damage = 7000, cycle = 4000, 
			arr = {
				{{x=210,y=862,z=6}, 307, 1, 3000},
				{{x=210,y=863,z=6}, 307, 1, 3000},
				{{x=210,y=864,z=6}, 307, 1, 3000},
				{{x=210,y=865,z=6}, 307, 1, 3000},
				{{x=210,y=866,z=6}, 307, 1, 3000},
				{{x=210,y=867,z=6}, 307, 1, 3000},
				{{x=210,y=868,z=6}, 307, 1, 3000},
				{{x=211,y=864,z=6}, 307, 1, 3000},
				{{x=212,y=864,z=6}, 307, 1, 3000},
				{{x=213,y=864,z=6}, 307, 1, 3000},
				{{x=209,y=864,z=6}, 307, 1, 3000},
				{{x=208,y=864,z=6}, 307, 1, 3000},
				{{x=207,y=864,z=6}, 307, 1, 3000},
				
				{{x=206,y=866,z=6}, 307, 1, 3000},
				{{x=206,y=865,z=6}, 307, 1, 3000},
				{{x=206,y=864,z=6}, 307, 1, 3000},
				{{x=206,y=863,z=6}, 307, 1, 3000},
				{{x=206,y=862,z=6}, 307, 1, 3000},
				{{x=206,y=867,z=6}, 307, 1, 3000},
				{{x=206,y=868,z=6}, 307, 1, 3000},
				{{x=206,y=869,z=6}, 307, 1, 3000},
				{{x=207,y=866,z=6}, 307, 1, 3000},
				{{x=208,y=866,z=6}, 307, 1, 3000},
				{{x=209,y=866,z=6}, 307, 1, 3000},
				{{x=205,y=866,z=6}, 307, 1, 3000},
				{{x=204,y=866,z=6}, 307, 1, 3000},
				{{x=203,y=866,z=6}, 307, 1, 3000},
				{{x=202,y=866,z=6}, 307, 1, 3000},
				
				{{x=201,y=868,z=6}, 307, 1, 3000},
				{{x=202,y=868,z=6}, 307, 1, 3000},
				{{x=203,y=868,z=6}, 307, 1, 3000},
				{{x=204,y=868,z=6}, 307, 1, 3000},
				{{x=205,y=868,z=6}, 307, 1, 3000},
				{{x=200,y=868,z=6}, 307, 1, 3000},
				{{x=199,y=868,z=6}, 307, 1, 3000},
				{{x=198,y=868,z=6}, 307, 1, 3000},
				{{x=197,y=868,z=6}, 307, 1, 3000},
				{{x=201,y=867,z=6}, 307, 1, 3000},
				{{x=201,y=869,z=6}, 307, 1, 3000},
				{{x=201,y=870,z=6}, 307, 1, 3000},
				
				{{x=201,y=865,z=6}, 307, 1, 3000},
				{{x=201,y=864,z=6}, 307, 1, 3000},
				{{x=200,y=865,z=6}, 307, 1, 3000},
				{{x=202,y=865,z=6}, 307, 1, 3000},
				{{x=203,y=865,z=6}, 307, 1, 3000},
				{{x=204,y=865,z=6}, 307, 1, 3000},
				
				{{x=196,y=869,z=6}, 307, 1, 3000},
				{{x=196,y=868,z=6}, 307, 1, 3000},
				{{x=196,y=867,z=6}, 307, 1, 3000},
				{{x=196,y=866,z=6}, 307, 1, 3000},
				{{x=196,y=870,z=6}, 307, 1, 3000},
				{{x=197,y=869,z=6}, 307, 1, 3000},
				{{x=198,y=869,z=6}, 307, 1, 3000},
				{{x=199,y=869,z=6}, 307, 1, 3000},
				{{x=200,y=869,z=6}, 307, 1, 3000},
				{{x=195,y=869,z=6}, 307, 1, 3000},
				{{x=194,y=869,z=6}, 307, 1, 3000},
				{{x=193,y=869,z=6}, 307, 1, 3000},
				{{x=192,y=869,z=6}, 307, 1, 3000},
				{{x=191,y=869,z=6}, 307, 1, 3000},
			}
		}, 
["swamp"] = {color = COLOR_PURPLE, damage = 2000, cycle = 750, 
	arr = {
		{{x=223,y=866,z=6}, 470, 2, math.random(250, 1000)},
		{{x=223,y=869,z=6}, 470, 2, math.random(250, 1000)},
		{{x=225,y=862,z=6}, 470, 2, math.random(250, 1000)},
		{{x=226,y=868,z=6}, 470, 2, math.random(250, 1000)},
		{{x=228,y=867,z=6}, 470, 2, math.random(250, 1000)},
		{{x=229,y=863,z=6}, 470, 2, math.random(250, 1000)},
		{{x=234,y=869,z=6}, 470, 2, math.random(250, 1000)},
		{{x=234,y=864,z=6}, 470, 2, math.random(250, 1000)},
		{{x=237,y=870,z=6}, 470, 2, math.random(250, 1000)},
		{{x=237,y=866,z=6}, 470, 2, math.random(250, 1000)},
		{{x=230,y=866,z=6}, 470, 2, math.random(250, 1000)},
		{{x=231,y=864,z=6}, 470, 2, math.random(250, 1000)},
		{{x=241,y=870,z=6}, 470, 2, math.random(250, 1000)},
		{{x=242,y=867,z=6}, 470, 2, math.random(250, 1000)},
		{{x=245,y=869,z=6}, 470, 2, math.random(250, 1000)},
	}
}, 
["iceEmote"] = {color = COLOR_LIGHTBLUE, damage = 0, cycle = 5000, 
	arr = {
		{{x=248,y=902,z=6}, 312, 0, 0},
		{{x=253,y=897,z=6}, 312, 0, 0},
		{{x=255,y=889,z=6}, 312, 0, 0},
		{{x=250,y=882,z=6}, 312, 0, 0},
		{{x=248,y=902,z=6}, 312, 0, 0},
		{{x=247,y=877,z=6}, 312, 0, 0},
	}
},  
["electric"] = {color = COLOR_YELLOW, damage = 3000, cycle = 4000, 
	arr = {
{{x=194, y=932, z=6}, 501, 0, 0},
{{x=195, y=932, z=6}, 501, 0, 500},
{{x=196, y=932, z=6}, 501, 0, 1000},
{{x=196, y=933, z=6}, 501, 0, 1500},
{{x=196, y=934, z=6}, 501, 0, 2000},
{{x=195, y=934, z=6}, 501, 0, 2500},
{{x=194, y=934, z=6}, 501, 0, 3000},
{{x=194, y=933, z=6}, 501, 0, 3500},
{{x=198, y=934, z=6}, 501, 0, 0},
{{x=198, y=935, z=6}, 501, 0, 500},
{{x=199, y=935, z=6}, 501, 0, 1000},
{{x=200, y=935, z=6}, 501, 0, 1500},
{{x=200, y=934, z=6}, 501, 0, 2000},
{{x=200, y=933, z=6}, 501, 0, 2500},
{{x=199, y=933, z=6}, 501, 0, 3000},
{{x=198, y=933, z=6}, 501, 0, 3500},
{{x=202, y=934, z=6}, 501, 0, 0},
{{x=202, y=935, z=6}, 501, 0, 500},
{{x=203, y=935, z=6}, 501, 0, 1000},
{{x=204, y=935, z=6}, 501, 0, 1500},
{{x=204, y=934, z=6}, 501, 0, 2000},
{{x=204, y=933, z=6}, 501, 0, 2500},
{{x=203, y=933, z=6}, 501, 0, 3000},
{{x=202, y=933, z=6}, 501, 0, 3500},
{{x=206, y=934, z=6}, 501, 0, 0},
{{x=207, y=934, z=6}, 501, 0, 500},
{{x=208, y=934, z=6}, 501, 0, 1000},
{{x=208, y=935, z=6}, 501, 0, 1500},
{{x=208, y=936, z=6}, 501, 0, 2000},
{{x=207, y=936, z=6}, 501, 0, 2500},
{{x=206, y=936, z=6}, 501, 0, 3000},
{{x=206, y=935, z=6}, 501, 0, 3500},
{{x=212, y=935, z=6}, 501, 0, 0},
{{x=212, y=936, z=6}, 501, 0, 500},
{{x=212, y=937, z=6}, 501, 0, 1000},
{{x=213, y=937, z=6}, 501, 0, 1500},
{{x=214, y=937, z=6}, 501, 0, 2000},
{{x=214, y=936, z=6}, 501, 0, 2500},
{{x=214, y=935, z=6}, 501, 0, 3000},
{{x=213, y=935, z=6}, 501, 0, 3500},
{{x=211, y=932, z=6}, 501, 0, 0},
{{x=211, y=933, z=6}, 501, 0, 500},
{{x=212, y=933, z=6}, 501, 0, 1000},
{{x=213, y=933, z=6}, 501, 0, 1500},
{{x=213, y=932, z=6}, 501, 0, 2000},
{{x=213, y=931, z=6}, 501, 0, 2500},
{{x=212, y=931, z=6}, 501, 0, 3000},
{{x=211, y=931, z=6}, 501, 0, 3500},
{{x=213, y=927, z=6}, 501, 0, 0},
{{x=214, y=927, z=6}, 501, 0, 500},
{{x=214, y=928, z=6}, 501, 0, 1000},
{{x=214, y=929, z=6}, 501, 0, 1500},
{{x=214, y=930, z=6}, 501, 0, 2000},
{{x=213, y=930, z=6}, 501, 0, 2500},
{{x=213, y=929, z=6}, 501, 0, 3000},
{{x=213, y=928, z=6}, 501, 0, 3500},
	}
},  
["whirlpool"] = {color = COLOR_BLUE+5, damage = 4000, cycle = 6000, 
	arr = {
	{{x=229, y=901, z=6}, 416, 0, 0},
{{x=228, y=901, z=6}, 415, 0, 0},
{{x=230, y=901, z=6}, 415, 0, 0},
{{x=228, y=902, z=6}, 416, 0, 500},
{{x=227, y=903, z=6}, 415, 0, 500},
{{x=229, y=901, z=6}, 415, 0, 500},
{{x=230, y=902, z=6}, 416, 0, 1000},
{{x=230, y=903, z=6}, 415, 0, 1000},
{{x=230, y=901, z=6}, 415, 0, 1000},
{{x=230, y=902, z=6}, 416, 0, 1500},
{{x=231, y=903, z=6}, 415, 0, 1500},
{{x=229, y=901, z=6}, 415, 0, 1500},
{{x=231, y=902, z=6}, 416, 0, 2000},
{{x=232, y=902, z=6}, 415, 0, 2000},
{{x=230, y=902, z=6}, 415, 0, 2000},
{{x=232, y=902, z=6}, 416, 0, 2500},
{{x=233, y=901, z=6}, 415, 0, 2500},
{{x=231, y=903, z=6}, 415, 0, 2500},
{{x=233, y=902, z=6}, 416, 0, 3000},
{{x=233, y=901, z=6}, 415, 0, 3000},
{{x=233, y=903, z=6}, 415, 0, 3000},
{{x=233, y=902, z=6}, 416, 0, 3500},
{{x=232, y=901, z=6}, 415, 0, 3500},
{{x=234, y=903, z=6}, 415, 0, 3500},
{{x=234, y=902, z=6}, 416, 0, 4000},
{{x=233, y=902, z=6}, 415, 0, 4000},
{{x=235, y=902, z=6}, 415, 0, 4000},
{{x=235, y=902, z=6}, 416, 0, 4500},
{{x=234, y=903, z=6}, 415, 0, 4500},
{{x=236, y=901, z=6}, 415, 0, 4500},
{{x=236, y=902, z=6}, 416, 0, 5000},
{{x=236, y=903, z=6}, 415, 0, 5000},
{{x=236, y=901, z=6}, 415, 0, 5000},
{{x=236, y=901, z=6}, 416, 0, 5500},
{{x=237, y=902, z=6}, 415, 0, 5500},
{{x=235, y=900, z=6}, 415, 0, 5500},
{{x=236, y=900, z=6}, 416, 0, 6000},
{{x=237, y=900, z=6}, 415, 0, 6000},
{{x=235, y=900, z=6}, 415, 0, 6000},
{{x=236, y=899, z=6}, 416, 0, 6500},
{{x=237, y=898, z=6}, 415, 0, 6500},
{{x=235, y=900, z=6}, 415, 0, 6500},
{{x=235, y=899, z=6}, 416, 0, 7000},
{{x=235, y=898, z=6}, 415, 0, 7000},
{{x=235, y=900, z=6}, 415, 0, 7000},
{{x=234, y=899, z=6}, 416, 0, 7500},
{{x=233, y=898, z=6}, 415, 0, 7500},
{{x=235, y=900, z=6}, 415, 0, 7500},
{{x=234, y=899, z=6}, 416, 0, 8000},
{{x=233, y=899, z=6}, 415, 0, 8000},
{{x=235, y=899, z=6}, 415, 0, 8000},
{{x=233, y=899, z=6}, 416, 0, 8500},
{{x=232, y=900, z=6}, 415, 0, 8500},
{{x=234, y=898, z=6}, 415, 0, 8500},
{{x=232, y=899, z=6}, 416, 0, 9000},
{{x=232, y=900, z=6}, 415, 0, 9000},
{{x=232, y=898, z=6}, 415, 0, 9000},
{{x=232, y=899, z=6}, 416, 0, 9500},
{{x=233, y=900, z=6}, 415, 0, 9500},
{{x=231, y=898, z=6}, 415, 0, 9500},
{{x=231, y=899, z=6}, 416, 0, 10000},
{{x=232, y=899, z=6}, 415, 0, 10000},
{{x=230, y=899, z=6}, 415, 0, 10000},
{{x=230, y=899, z=6}, 416, 0, 10500},
{{x=231, y=898, z=6}, 415, 0, 10500},
{{x=229, y=900, z=6}, 415, 0, 10500},
{{x=229, y=899, z=6}, 416, 0, 11000},
{{x=229, y=898, z=6}, 415, 0, 11000},
{{x=229, y=900, z=6}, 415, 0, 11000},
{{x=228, y=899, z=6}, 416, 0, 11500},
{{x=227, y=898, z=6}, 415, 0, 11500},
{{x=229, y=900, z=6}, 415, 0, 11500},
	}
},
["whirlpool2"] = {color = COLOR_BLUE+5, damage = 4000, cycle = 8500, 
	arr = {
{{x=233, y=893, z=6}, 416, 0, 0},
{{x=232, y=893, z=6}, 415, 0, 0},
{{x=234, y=893, z=6}, 415, 0, 0},
{{x=234, y=893, z=6}, 416, 0, 500},
{{x=233, y=894, z=6}, 415, 0, 500},
{{x=235, y=892, z=6}, 415, 0, 500},
{{x=235, y=893, z=6}, 416, 0, 1000},
{{x=235, y=894, z=6}, 415, 0, 1000},
{{x=235, y=892, z=6}, 415, 0, 1000},
{{x=236, y=893, z=6}, 416, 0, 1500},
{{x=237, y=894, z=6}, 415, 0, 1500},
{{x=235, y=892, z=6}, 415, 0, 1500},
{{x=237, y=893, z=6}, 416, 0, 2000},
{{x=238, y=893, z=6}, 415, 0, 2000},
{{x=236, y=893, z=6}, 415, 0, 2000},
{{x=237, y=893, z=6}, 416, 0, 2500},
{{x=238, y=892, z=6}, 415, 0, 2500},
{{x=236, y=894, z=6}, 415, 0, 2500},
{{x=237, y=892, z=6}, 416, 0, 3000},
{{x=237, y=891, z=6}, 415, 0, 3000},
{{x=237, y=893, z=6}, 415, 0, 3000},
{{x=237, y=891, z=6}, 416, 0, 3500},
{{x=236, y=890, z=6}, 415, 0, 3500},
{{x=238, y=892, z=6}, 415, 0, 3500},
{{x=237, y=890, z=6}, 416, 0, 4000},
{{x=236, y=890, z=6}, 415, 0, 4000},
{{x=238, y=890, z=6}, 415, 0, 4000},
{{x=236, y=890, z=6}, 416, 0, 4500},
{{x=235, y=891, z=6}, 415, 0, 4500},
{{x=237, y=889, z=6}, 415, 0, 4500},
{{x=235, y=890, z=6}, 416, 0, 5000},
{{x=235, y=891, z=6}, 415, 0, 5000},
{{x=235, y=889, z=6}, 415, 0, 5000},
{{x=235, y=890, z=6}, 416, 0, 5500},
{{x=236, y=891, z=6}, 415, 0, 5500},
{{x=234, y=889, z=6}, 415, 0, 5500},
{{x=234, y=890, z=6}, 416, 0, 6000},
{{x=235, y=890, z=6}, 415, 0, 6000},
{{x=233, y=890, z=6}, 415, 0, 6000},
{{x=233, y=890, z=6}, 416, 0, 6500},
{{x=234, y=889, z=6}, 415, 0, 6500},
{{x=232, y=891, z=6}, 415, 0, 6500},
{{x=233, y=891, z=6}, 416, 0, 7000},
{{x=233, y=890, z=6}, 415, 0, 7000},
{{x=233, y=892, z=6}, 415, 0, 7000},
{{x=233, y=892, z=6}, 416, 0, 7500},
{{x=232, y=891, z=6}, 415, 0, 7500},
{{x=234, y=893, z=6}, 415, 0, 7500},
{{x=233, y=893, z=6}, 416, 0, 8000},
{{x=232, y=893, z=6}, 415, 0, 8000},
{{x=234, y=893, z=6}, 415, 0, 8000},
	}
},
["groundCollapse"] = {color = COLOR_BROWN+1, damage = 6000, cycle = 4000, 
	arr = {
		{{x=220, y=920, z=6}, 515, 2, 500},
		{{x=220, y=918, z=6}, 515, 2, 500},
		{{x=220, y=916, z=6}, 515, 2, 500},
		{{x=222, y=916, z=6}, 515, 2, 1000},
		{{x=222, y=918, z=6}, 515, 2, 1000},
		{{x=222, y=920, z=6}, 515, 2, 1000},
		{{x=224, y=920, z=6}, 515, 2, 1500},
		{{x=224, y=917, z=6}, 515, 2, 1500},
		{{x=224, y=913, z=6}, 515, 2, 1500},
		{{x=226, y=916, z=6}, 515, 2, 2000},
		{{x=226, y=920, z=6}, 515, 2, 2000},
		{{x=228, y=920, z=6}, 515, 2, 2500},
		{{x=228, y=916, z=6}, 515, 2, 2500},
		{{x=228, y=914, z=6}, 515, 2, 2500},
		{{x=230, y=923, z=6}, 515, 2, 3000},
		{{x=230, y=921, z=6}, 515, 2, 3000},
		{{x=230, y=916, z=6}, 515, 2, 3000},
		{{x=230, y=914, z=6}, 515, 2, 3000},
		{{x=232, y=912, z=6}, 515, 2, 3500},
		{{x=232, y=914, z=6}, 515, 2, 3500},
		{{x=232, y=918, z=6}, 515, 2, 3500},
		{{x=232, y=920, z=6}, 515, 2, 3500},
		{{x=234, y=921, z=6}, 515, 2, 4000},
		{{x=234, y=919, z=6}, 515, 2, 4000},
		{{x=234, y=917, z=6}, 515, 2, 4000},
		{{x=234, y=913, z=6}, 515, 2, 4000},
		{{x=236, y=914, z=6}, 515, 2, 4500},
		{{x=236, y=916, z=6}, 515, 2, 4500},
		{{x=236, y=918, z=6}, 515, 2, 4500},
		{{x=238, y=917, z=6}, 515, 2, 5000},
		{{x=238, y=915, z=6}, 515, 2, 5000},
		{{x=240, y=913, z=6}, 515, 2, 5500},
		{{x=240, y=917, z=6}, 515, 2, 5500},
		{{x=242, y=917, z=6}, 515, 2, 6000},
		{{x=242, y=912, z=6}, 515, 2, 6000},
		{{x=244, y=912, z=6}, 515, 2, 6500},
		{{x=244, y=916, z=6}, 515, 2, 6500},
		{{x=244, y=918, z=6}, 515, 2, 6500},
		{{x=246, y=915, z=6}, 515, 2, 7000},
	}
},
["water"] = {color = COLOR_BLUE+5, damage = 5000, cycle = 2500, 
	arr = {
			{{x=183, y=895, z=6}, 155, 0, 0},
			{{x=181, y=895, z=6}, 155, 0, 0},
			{{x=181, y=897, z=6}, 155, 0, 0},
			{{x=183, y=897, z=6}, 155, 0, 0},
			{{x=181, y=899, z=6}, 155, 0, 0},
			{{x=183, y=899, z=6}, 155, 0, 0},
			{{x=184, y=899, z=6}, 155, 0, 0},
			{{x=185, y=899, z=6}, 155, 0, 0},
			{{x=186, y=899, z=6}, 155, 0, 0},
			{{x=187, y=899, z=6}, 155, 0, 0},
			{{x=188, y=899, z=6}, 155, 0, 0},
			{{x=181, y=901, z=6}, 155, 0, 0},
			{{x=182, y=901, z=6}, 155, 0, 0},
			{{x=183, y=901, z=6}, 155, 0, 0},
			{{x=184, y=901, z=6}, 155, 0, 0},
			{{x=185, y=901, z=6}, 155, 0, 0},
			{{x=186, y=901, z=6}, 155, 0, 0},
			{{x=188, y=901, z=6}, 155, 0, 0},
			{{x=186, y=903, z=6}, 155, 0, 0},
			{{x=186, y=905, z=6}, 155, 0, 0},
			{{x=188, y=905, z=6}, 155, 0, 0},
			{{x=188, y=903, z=6}, 155, 0, 0},
			{{x=181, y=896, z=6}, 155, 0, 0},
			{{x=183, y=896, z=6}, 155, 0, 0},
			{{x=181, y=898, z=6}, 155, 0, 0},
			{{x=183, y=898, z=6}, 155, 0, 0},
			{{x=181, y=900, z=6}, 155, 0, 0},
			{{x=186, y=906, z=6}, 155, 0, 0},
			{{x=186, y=904, z=6}, 155, 0, 0},
			{{x=186, y=902, z=6}, 155, 0, 0},
			{{x=188, y=902, z=6}, 155, 0, 0},
			{{x=188, y=904, z=6}, 155, 0, 0},
			{{x=188, y=906, z=6}, 155, 0, 0},
			{{x=188, y=906, z=6}, 155, 0, 0},
			{{x=188, y=906, z=6}, 155, 0, 0},
			{{x=188, y=904, z=6}, 155, 0, 0},
			{{x=188, y=904, z=6}, 155, 0, 0},
			{{x=188, y=902, z=6}, 155, 0, 0},
			{{x=188, y=902, z=6}, 155, 0, 0},
			{{x=188, y=900, z=6}, 155, 0, 0},
			{{x=188, y=900, z=6}, 155, 0, 0},			
			{{x=182, y=895, z=6}, 155, 0, 1000},
			{{x=182, y=896, z=6}, 155, 0, 1000},
			{{x=182, y=897, z=6}, 155, 0, 1000},
			{{x=182, y=898, z=6}, 155, 0, 1000},
			{{x=182, y=899, z=6}, 155, 0, 1000},
			{{x=182, y=900, z=6}, 155, 0, 1000},
			{{x=183, y=900, z=6}, 155, 0, 1000},
			{{x=184, y=900, z=6}, 155, 0, 1000},
			{{x=185, y=900, z=6}, 155, 0, 1000},
			{{x=186, y=900, z=6}, 155, 0, 1000},
			{{x=187, y=900, z=6}, 155, 0, 1000},
			{{x=187, y=901, z=6}, 155, 0, 1000},
			{{x=187, y=902, z=6}, 155, 0, 1000},
			{{x=187, y=903, z=6}, 155, 0, 1000},
			{{x=187, y=904, z=6}, 155, 0, 1000},
			{{x=187, y=905, z=6}, 155, 0, 1000},
			{{x=187, y=906, z=6}, 155, 0, 1000},
	}
}, 
["ice"] = {color = COLOR_LIGHTBLUE, damage = 3000, cycle = 5000, 
	arr = {
			{{x=257, y=906, z=6}, 17, 0, 2000},
			{{x=257, y=905, z=6}, 17, 0, 2000},
			{{x=256, y=905, z=6}, 17, 0, 2000},
			{{x=256, y=906, z=6}, 17, 0, 2000},
			{{x=256, y=907, z=6}, 17, 0, 2000},
			{{x=255, y=907, z=6}, 17, 0, 2000},
			{{x=255, y=906, z=6}, 17, 0, 2000},
			{{x=255, y=905, z=6}, 17, 0, 2000},
			{{x=254, y=905, z=6}, 17, 0, 2000},
			{{x=254, y=906, z=6}, 17, 0, 2000},
			{{x=254, y=907, z=6}, 17, 0, 2000},
			{{x=253, y=906, z=6}, 17, 0, 2000},
			{{x=252, y=906, z=6}, 17, 0, 2000},
			{{x=252, y=905, z=6}, 17, 0, 2000},
			{{x=248, y=906, z=6}, 17, 0, 2000},
			{{x=248, y=905, z=6}, 17, 0, 2000},
			{{x=249, y=905, z=6}, 17, 0, 2000},
			{{x=249, y=907, z=6}, 17, 0, 2000},
			{{x=250, y=907, z=6}, 17, 0, 2000},
			{{x=250, y=906, z=6}, 17, 0, 2000},
			{{x=250, y=905, z=6}, 17, 0, 2000},
			{{x=251, y=905, z=6}, 17, 0, 2000},
			{{x=251, y=906, z=6}, 17, 0, 2000},
			{{x=251, y=907, z=6}, 17, 0, 2000},
			{{x=250, y=908, z=6}, 17, 0, 2000},
			{{x=257, y=907, z=6}, 17, 0, 2000},
			{{x=257, y=908, z=6}, 17, 0, 2000},
			{{x=257, y=904, z=6}, 17, 0, 2000},
			{{x=256, y=904, z=6}, 17, 0, 2000},
			{{x=256, y=903, z=6}, 17, 0, 2000},
			{{x=257, y=903, z=6}, 17, 0, 2000},
			{{x=257, y=902, z=6}, 17, 0, 2000},
			{{x=257, y=901, z=6}, 17, 0, 2000},
			{{x=257, y=900, z=6}, 17, 0, 2000},
			{{x=258, y=900, z=6}, 17, 0, 2000},
			{{x=256, y=900, z=6}, 17, 0, 2000},
			{{x=256, y=901, z=6}, 17, 0, 2000},
			{{x=256, y=899, z=6}, 17, 0, 2000},
			{{x=255, y=900, z=6}, 17, 0, 2000},
			{{x=255, y=901, z=6}, 17, 0, 2000},
			{{x=255, y=902, z=6}, 17, 0, 2000},
			{{x=254, y=902, z=6}, 17, 0, 2000},
			{{x=254, y=903, z=6}, 17, 0, 2000},
			{{x=253, y=903, z=6}, 17, 0, 2000},
			{{x=252, y=903, z=6}, 17, 0, 2000},
			{{x=252, y=904, z=6}, 17, 0, 2000},
			{{x=253, y=904, z=6}, 17, 0, 2000},
			{{x=251, y=904, z=6}, 17, 0, 2000},
			{{x=251, y=903, z=6}, 17, 0, 2000},
			{{x=250, y=903, z=6}, 17, 0, 2000},
			{{x=250, y=904, z=6}, 17, 0, 2000},
			{{x=249, y=904, z=6}, 17, 0, 2000},
			{{x=250, y=902, z=6}, 17, 0, 2000},
			{{x=250, y=901, z=6}, 17, 0, 2000},
			{{x=250, y=900, z=6}, 17, 0, 2000},
			{{x=249, y=900, z=6}, 17, 0, 2000},
			{{x=248, y=900, z=6}, 17, 0, 2000},
			{{x=247, y=900, z=6}, 17, 0, 2000},
			{{x=246, y=900, z=6}, 17, 0, 2000},
			{{x=246, y=901, z=6}, 17, 0, 2000},
			{{x=246, y=902, z=6}, 17, 0, 2000},
			{{x=248, y=899, z=6}, 17, 0, 2000},
			{{x=249, y=899, z=6}, 17, 0, 2000},
			{{x=247, y=899, z=6}, 17, 0, 2000},
			{{x=250, y=899, z=6}, 17, 0, 2000},
			{{x=251, y=899, z=6}, 17, 0, 2000},
			{{x=252, y=899, z=6}, 17, 0, 2000},
			{{x=253, y=899, z=6}, 17, 0, 2000},
			{{x=254, y=899, z=6}, 17, 0, 2000},
			{{x=254, y=900, z=6}, 17, 0, 2000},
			{{x=252, y=900, z=6}, 17, 0, 2000},
			{{x=251, y=900, z=6}, 17, 0, 2000},
			{{x=251, y=901, z=6}, 17, 0, 2000},
			{{x=252, y=901, z=6}, 17, 0, 2000},
			{{x=253, y=901, z=6}, 17, 0, 2000},
			{{x=254, y=901, z=6}, 17, 0, 2000},
			{{x=256, y=898, z=6}, 17, 0, 2000},
			{{x=255, y=898, z=6}, 17, 0, 2000},
			{{x=255, y=897, z=6}, 17, 0, 2000},
			{{x=255, y=896, z=6}, 17, 0, 2000},
			{{x=254, y=895, z=6}, 17, 0, 2000},
			{{x=253, y=895, z=6}, 17, 0, 2000},
			{{x=252, y=895, z=6}, 17, 0, 2000},
			{{x=251, y=895, z=6}, 17, 0, 2000},
			{{x=251, y=896, z=6}, 17, 0, 2000},
			{{x=251, y=897, z=6}, 17, 0, 2000},
			{{x=249, y=897, z=6}, 17, 0, 2000},
			{{x=250, y=896, z=6}, 17, 0, 2000},
			{{x=250, y=895, z=6}, 17, 0, 2000},
			{{x=248, y=895, z=6}, 17, 0, 2000},
			{{x=249, y=896, z=6}, 17, 0, 2000},
			{{x=248, y=896, z=6}, 17, 0, 2000},
			{{x=248, y=897, z=6}, 17, 0, 2000},
			{{x=249, y=898, z=6}, 17, 0, 2000},
			{{x=248, y=898, z=6}, 17, 0, 2000},
			{{x=249, y=894, z=6}, 17, 0, 2000},
			{{x=250, y=894, z=6}, 17, 0, 2000},
			{{x=250, y=893, z=6}, 17, 0, 2000},
			{{x=251, y=893, z=6}, 17, 0, 2000},
			{{x=251, y=894, z=6}, 17, 0, 2000},
			{{x=252, y=893, z=6}, 17, 0, 2000},
			{{x=253, y=893, z=6}, 17, 0, 2000},
			{{x=253, y=894, z=6}, 17, 0, 2000},
			{{x=254, y=894, z=6}, 17, 0, 2000},
			{{x=254, y=893, z=6}, 17, 0, 2000},
			{{x=255, y=893, z=6}, 17, 0, 2000},
			{{x=255, y=894, z=6}, 17, 0, 2000},
			{{x=254, y=892, z=6}, 17, 0, 2000},
			{{x=255, y=892, z=6}, 17, 0, 2000},
			{{x=256, y=892, z=6}, 17, 0, 2000},
			{{x=257, y=892, z=6}, 17, 0, 2000},
			{{x=257, y=891, z=6}, 17, 0, 2000},
			{{x=254, y=891, z=6}, 17, 0, 2000},
			{{x=253, y=891, z=6}, 17, 0, 2000},
			{{x=251, y=891, z=6}, 17, 0, 2000},
			{{x=252, y=892, z=6}, 17, 0, 2000},
			{{x=251, y=892, z=6}, 17, 0, 2000},
			{{x=250, y=891, z=6}, 17, 0, 2000},
			{{x=250, y=892, z=6}, 17, 0, 2000},
			{{x=249, y=892, z=6}, 17, 0, 2000},
			{{x=249, y=891, z=6}, 17, 0, 2000},
			{{x=248, y=892, z=6}, 17, 0, 2000},
			{{x=248, y=893, z=6}, 17, 0, 2000},
			{{x=250, y=890, z=6}, 17, 0, 2000},
			{{x=250, y=889, z=6}, 17, 0, 2000},
			{{x=251, y=889, z=6}, 17, 0, 2000},
			{{x=252, y=889, z=6}, 17, 0, 2000},
			{{x=252, y=890, z=6}, 17, 0, 2000},
			{{x=253, y=890, z=6}, 17, 0, 2000},
			{{x=253, y=889, z=6}, 17, 0, 2000},
			{{x=255, y=891, z=6}, 17, 0, 2000},
			{{x=253, y=888, z=6}, 17, 0, 2000},
			{{x=253, y=887, z=6}, 17, 0, 2000},
			{{x=252, y=888, z=6}, 17, 0, 2000},
			{{x=252, y=887, z=6}, 17, 0, 2000},
			{{x=252, y=886, z=6}, 17, 0, 2000},
			{{x=253, y=886, z=6}, 17, 0, 2000},
			{{x=254, y=886, z=6}, 17, 0, 2000},
			{{x=254, y=885, z=6}, 17, 0, 2000},
			{{x=253, y=885, z=6}, 17, 0, 2000},
			{{x=252, y=885, z=6}, 17, 0, 2000},
			{{x=251, y=885, z=6}, 17, 0, 2000},
			{{x=251, y=884, z=6}, 17, 0, 2000},
			{{x=252, y=884, z=6}, 17, 0, 2000},
			{{x=253, y=884, z=6}, 17, 0, 2000},
			{{x=254, y=884, z=6}, 17, 0, 2000},
			{{x=255, y=884, z=6}, 17, 0, 2000},
			{{x=255, y=883, z=6}, 17, 0, 2000},
			{{x=255, y=882, z=6}, 17, 0, 2000},
			{{x=254, y=883, z=6}, 17, 0, 2000},
			{{x=253, y=883, z=6}, 17, 0, 2000},
			{{x=252, y=883, z=6}, 17, 0, 2000},
			{{x=252, y=882, z=6}, 17, 0, 2000},
			{{x=253, y=882, z=6}, 17, 0, 2000},
			{{x=254, y=881, z=6}, 17, 0, 2000},
			{{x=253, y=881, z=6}, 17, 0, 2000},
			{{x=252, y=881, z=6}, 17, 0, 2000},
			{{x=252, y=880, z=6}, 17, 0, 2000},
			{{x=253, y=880, z=6}, 17, 0, 2000},
			{{x=253, y=879, z=6}, 17, 0, 2000},
			{{x=254, y=880, z=6}, 17, 0, 2000},
			{{x=253, y=878, z=6}, 17, 0, 2000},
			{{x=252, y=878, z=6}, 17, 0, 2000},
			{{x=251, y=878, z=6}, 17, 0, 2000},
			{{x=251, y=879, z=6}, 17, 0, 2000},
			{{x=250, y=880, z=6}, 17, 0, 2000},
			{{x=249, y=880, z=6}, 17, 0, 2000},
			{{x=248, y=880, z=6}, 17, 0, 2000},
			{{x=247, y=881, z=6}, 17, 0, 2000},
			{{x=247, y=880, z=6}, 17, 0, 2000},
			{{x=246, y=880, z=6}, 17, 0, 2000},
			{{x=247, y=879, z=6}, 17, 0, 2000},
			{{x=245, y=879, z=6}, 17, 0, 2000},
			{{x=244, y=878, z=6}, 17, 0, 2000},
			{{x=245, y=877, z=6}, 17, 0, 2000},
			{{x=249, y=877, z=6}, 17, 0, 2000},
			{{x=249, y=875, z=6}, 17, 0, 2000},
			{{x=250, y=875, z=6}, 17, 0, 2000},
			{{x=250, y=876, z=6}, 17, 0, 2000},
			{{x=251, y=876, z=6}, 17, 0, 2000},
			{{x=251, y=875, z=6}, 17, 0, 2000},
			{{x=252, y=875, z=6}, 17, 0, 2000},
			{{x=252, y=876, z=6}, 17, 0, 2000},
			{{x=253, y=875, z=6}, 17, 0, 2000},
			{{x=253, y=877, z=6}, 17, 0, 2000},
			{{x=252, y=877, z=6}, 17, 0, 2000},
			{{x=251, y=877, z=6}, 17, 0, 2000},
			{{x=250, y=878, z=6}, 17, 0, 2000},
			{{x=249, y=878, z=6}, 17, 0, 2000},
			{{x=249, y=879, z=6}, 17, 0, 2000},
			{{x=250, y=879, z=6}, 17, 0, 2000},
			{{x=251, y=880, z=6}, 17, 0, 2000},
			{{x=252, y=874, z=6}, 17, 0, 2000},
			{{x=251, y=874, z=6}, 17, 0, 2000},
			{{x=252, y=873, z=6}, 17, 0, 2000},
			{{x=251, y=873, z=6}, 17, 0, 2000},
			{{x=250, y=873, z=6}, 17, 0, 2000},
			{{x=250, y=874, z=6}, 17, 0, 2000},
			{{x=249, y=876, z=6}, 17, 0, 2000},
			{{x=249, y=906, z=6}, 17, 0, 2000},
			{{x=251, y=902, z=6}, 17, 0, 2000},
			{{x=252, y=902, z=6}, 17, 0, 2000},
			{{x=253, y=902, z=6}, 17, 0, 2000},
			{{x=253, y=900, z=6}, 17, 0, 2000},
			{{x=249, y=895, z=6}, 17, 0, 2000},
			{{x=252, y=894, z=6}, 17, 0, 2000},
			{{x=252, y=891, z=6}, 17, 0, 2000},
			{{x=248, y=879, z=6}, 17, 0, 2000},
			{{x=255, y=904, z=6}, 17, 0, 2000},
			{{x=254, y=904, z=6}, 17, 0, 2000},					
	}
}, 
}

function towerTrapCycles(trapname)
	local get = towerGetCreatures()
	if #get.players <= 0 then return true end
	if trapname == "all" then
		for tname,t in pairs(towerTrapInfo) do
			for i,v in pairs(t.arr) do
				addEvent(doSendTrapDamage, v[4], v[1], v[2], v[5] and v[5] or t.damage, "Feral Trap", t.color, v[3])
			end
			addEvent(towerTrapCycles, t.cycle, tname)
		end
	else
		local t = towerTrapInfo[trapname]
		for i,v in pairs(t.arr) do
			addEvent(doSendTrapDamage, v[4], v[1], v[2], t.damage, "Feral Trap", t.color, v[3])
		end
		return addEvent(towerTrapCycles, t.cycle, trapname)
	end
end

function towerGetCreatures()
	local ret = {
	players = {},
	monsters = {},
	}
	for x=towerTopCorner.x,towerBottomCorner.x do
		for y=towerTopCorner.y,towerBottomCorner.y do
			local checkpos = {x=x,y=y,z=towerBottomCorner.z,stackpos=253}
			local c = getThingFromPos(checkpos).uid
			if isCreature(c) and not isSummon(c) and not isPlayer(c) then
				table.insert(ret.monsters, c)
			end
			if isPlayer(c) then
				table.insert(ret.players, c)
			end
		end
	end
	return ret
end

function towerSendUpdate()
	local t = towerGetCreatures()
	if #t.monsters > 0 then
		for i,pid in pairs(t.players) do
			if isPlayer(pid) then
				doSendMsg(pid, "You still have to defeat ".. #t.monsters .." pokemons to proceed to the next floor.")
			end
		end
	else
		for i,pid in pairs(t.players) do
			if isPlayer(pid) then
				doSendMsg(pid, "All feral pokemons are defeated. Now you'll challenge the feral boss. Good luck!")
				doTeleportThing(pid, {x=221,y=882,z=5})
			end
		end
		towerSpawnBoss(1)
	end
end

function towerSpawnBoss(level)
	local name = towerBosses[level][math.random(#towerBosses[level])]
	local spawn = doCreateMonsterNick(121212, name, "Feral ".. name, {x=221,y=880,z=5}, true)
	towerAdjustPoke(spawn, level, true)
end

function towerAdjustPoke(cid, level, isBoss)
	if not isCreature(cid) then return true end
	if isSummon(cid) then return true end
	local name = doCorrectString(getCreatureName(cid))
	local t = towerConfig.pokeStatus[level]
	local t2 = pokes[name]
	local pokeLifeMax = t.life + (pokes[name].vitality * t.wildLvl * 5)
	if isBoss then pokeLifeMax = pokeLifeMax * 10 end
    setPlayerStorageValue(cid, towerMonsterStorage, t.boost)
    setPlayerStorageValue(cid, towerMonsterLevel, t.level)
    setPlayerStorageValue(cid, towerMonsterWildLvl, t.wildLvl)
	setPlayerStorageValue(cid, 1000, t.boost)
    setPlayerStorageValue(cid, 1001, t.attack)
	setPlayerStorageValue(cid, 1002, t.defense)
	setPlayerStorageValue(cid, 1003, pokes[name].agility)                                  
	setPlayerStorageValue(cid, 1004, t.vitality)
	setPlayerStorageValue(cid, 1005, t.specialattack)	
	doRegainSpeed(cid)
	setCreatureMaxHealth(cid, pokeLifeMax)
	doCreatureAddHealth(cid, getCreatureMaxHealth(cid))
end

function towerGen(cid, level)
	setPlayerStorageValue(cid, towerPotionStorage, towerConfig.potionCount[level])
	setPlayerStorageValue(cid, towerReviveStorage, towerConfig.reviveCount[level])
	setPlayerStorageValue(cid, towerPlayerEnter, 1)
	doSendMsg(cid, "You've entered the Feral Tower. You'll have ".. towerConfig.timeLimit[level] / 60 .." minutes to clear the dungeon. Your revives are limited to ".. towerConfig.reviveCount[level] .." and potions to ".. towerConfig.potionCount[level] .." use them wisely!")
	local count = 0
	for _,v in pairs(towerSpawnPos) do
		local pos, biome = v[1], v[2]
		for x=1,math.random(towerConfig.spawnMultiplier[level][1], towerConfig.spawnMultiplier[level][2]) do
			local name = towerBiomePokes[level][biome][math.random(#towerBiomePokes[level][biome])]
			local spawn = doCreateMonsterNick(121212, name, "Feral ".. name, pos, true)
			towerAdjustPoke(spawn, level)
			count = count + 1
		end
	end
	towerTrapCycles("all")
	setGlobalStorageValue(towerGlobalStorage, level)
	doSendMsg(cid, count .." feral pokemons have spawned in this floor. Finish them all to challenge the feral boss.")
end

function towerEnter(cid, level)
	local t = towerGetCreatures()
	if #t.players > 0 then
		doSendMsg(cid, "Someone is inside the tower. You must wait.")
		return false
	end
	if #t.monsters > 0 then
		for _,mid in pairs(t.monsters) do
			if isCreature(mid) then
				doRemoveCreature(mid)
			end
		end
	end
	doTeleportThing(cid,  {x=221,y=882,z=6})
	towerGen(cid, level)
end

-- function getPlayerTowerLevel(cid)
	-- if getPlayerStorageValue(cid, towerLevelStorage) == 0 then
		-- setPlayerStorageValue(cid, towerLevelStorage, 1)
	-- end
-- return getPlayerStorageValue(cid, towerLevelStorage)
-- end

-- function getPlayerTowerPoints(cid)
	-- if getPlayerStorageValue(cid, towerLevelStorage) == 0 then
		-- setPlayerStorageValue(cid, towerLevelStorage, 1)
	-- end
-- return getPlayerStorageValue(cid, towerLevelStorage)
-- end

function getPlayerTowerPoints(cid)
	if getPlayerStorageValue(cid, towerPointsStorage) == -1 then
		setPlayerStorageValue(cid, towerPointsStorage, 0)
	end
	-- return towerPoints[getPlayerStorageValue(cid, towerPointsStorage)].points
	return getPlayerStorageValue(cid, towerPointsStorage)
end

function getTowerEntrys(cid)
	if getPlayerStorageValue(cid, getPlayerTowerEntry) == -1 or getPlayerStorageValue(cid, getPlayerTowerEntry) == 0 then
		setPlayerStorageValue(cid, getPlayerTowerEntry, 1)
	end
	return getPlayerStorageValue(cid, getPlayerTowerEntry)
end

function getPlayerTowerLevel(cid)
	if getPlayerStorageValue(cid, towerPlayerLevel) == -1 or getPlayerStorageValue(cid, towerPlayerLevel) == 0 then
		setPlayerStorageValue(cid, towerPlayerLevel, 1)
	end
return getPlayerStorageValue(cid, towerPlayerLevel)
end
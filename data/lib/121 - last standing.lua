arenatopsurv, arenabotsurv = {x=1285, y=472, z=6}, {x=1318, y=489, z=6}
surv_stor_wave = 55555

surv_monsters = {
[0] = {{'Rhyperior','Magmortar','Electivire','Dusknoir','Milotic','Metagross','Tangrowth','Magnezone','Slaking','Salamence'}, multcounter = 1, strmult = 2},

[1] = {{"Ivysaur", "Tangela", "Charmeleon", "Wartortle", "Bayleef", "Quilava", "Croconaw", "Noctowl", "Hypno", "Kadabra",
"Golbat", "Raticate", "Fearow", "Umbreon", "Lickitung", "Haunter", "Hitmonlee", "Hitmonchan", "Jumpluff", "Magcargo"}, multcounter = 6, strmult = 2},

[2] = {{"Voltorb", "Rattata", "Krabby", "Paras", "Horsea",
"Growlithe", "Grimer", "Larvitar", "Dratini", "Tentacool", "Zubat", "Cubone", "Venonat",
"Golbat", "Parasect", "Beedrill", "Seadra", "Kingler", "Raticate", "Electrode"}, multcounter = 5, shinywave = true, strmult = 2},

[3] = {{"Charizard", "Golem", "Blastoise", "Venusaur", "Typhlosion", "Feraligatr", "Meganium", "Alakazam", "Gengar", "Xatu",
"Forretress", "Gyarados", "Heracross", "Qwilfish", "Skarmory", "Mantine", "Scyther", "Scizor", "Lapras", "Ampharos", "Arcanine", "Kangaskhan"}, multcounter = 6, strmult = 2},

[4] = {{"Magcargo", "Crobat", "Venomoth", "Feraligatr", "Lanturn", "Blastoise", "Pidgeot", "Arcanine", "Charizard", "Mr. Mime", "Tangela", "Machamp", "Weezing", "Sandslash",
"Venusaur", "Tauros", "Tentacruel", "Jynx", "Ampharos", "Muk", "Typhlosion", "Marowak", "Xatu", "Raichu", "Pinsir", "Meganium", "Butterfree"}, multcounter = 5, shinywave = true, strmult = 2},

[5] = {{'Swablu','Snorunt','Spheal','Riolu','Seedot','Treecko','Taillow','Torchic','Mudkip','Lotad','Ralts','Slakoth','Whismur','Makuhita',
'Aron','Meditite','Electrike','Numel','Trapinch','Corphish','Feebas','Shuppet','Duskull','Bagon','Beldum'}, multcounter = 7, strmult = 2},

[6] = {{'Shiny Fearow','Shiny Hypno','Shiny Nidoking','Shiny Hitmontop','Shiny Lucario','Shiny Flareon','Shiny Vileplume','Shiny Vaporeon','Shiny Jolteon','Shiny Golem'}, multcounter = 5, strmult = 2},

[7] = {{'Sealeo','Nuzleaf','Grovyle','Combusken','Marshtomp','Lombre','Kirlia','Vigoroth','Loudred','Lairon','Vibrava'}, multcounter = 6, strmult = 2},

[8] = {{'Altaria','Glalie','Walrein','Lucario','Shiftry','Sceptile','Swellow','Blaziken','Swampert','Ludicolo','Gardevoir','Exploud','Hariyama','Sableye','Mawile',
'Aggron','Medicham','Manectric','Camerupt', 'Flygon','Zangoose','Seviper','Crawdaunt','Claydol','Banette','Dusclops','Shelgon','Metang', 'Toxicroak', 'Breloom', 'Togekiss'}, multcounter = 5, strmult = 2},

[9] = {{"Gyarados", "Magmar", "Electabuzz", "Scyther", "Exeggutor", "Kabutops", "Alakazam", "Dragonair", "Pupitar", "Gengar"}, multcounter = 3, shinywave = true, strmult = 2},
}


function doTeleportThingWithPk(cid, topos)
	if not isCreature(cid) then return false end
	if #getCreatureSummons(cid) > 0 then
		doTeleportThing(getCreatureSummons(cid)[1], topos)
	end
	return doTeleportThing(cid, topos)
end

function getRandomWalkablePos(pos1,pos2)
	local topos = {x=math.random(pos1.x,pos2.x),y=math.random(pos1.y,pos2.y),z=math.random(pos1.z,pos2.z)}
	if isWalkable(topos) then
		return topos
	end
	return getRandomWalkablePos(pos1,pos2)
end

function removeTpLast(pos)
	local t = getTileItemById(pos, 1387)
	if t then
		doRemoveItem(t.uid, 1)
		doSendMagicEffect(pos, 3)
	end
end

function sendMsgInArea(msg, postop, posbot)
	for _,pid in pairs(getPlayersOnline()) do
		if isInArea(getThingPos(pid), postop, posbot) then
			doPlayerSendTextMessage(pid, MESSAGE_STATUS_WARNING, msg)
		end
	end
end

function spawnTimer()
	local count = 0
	if getGlobalStorageValue(surv_stor_wave) == 0 then return true end
	for x=arenatopsurv.x,arenabotsurv.x do
		for y=arenatopsurv.y,arenabotsurv.y do
			for stack=250,255 do
				local checkpos = {x=x,y=y,z=arenatopsurv.z,stackpos=stack}
				local c = getThingFromPos(checkpos).uid
				if isCreature(c) and not isSummon(c) and not isPlayer(c) then
					count = count + 1
				end
			end
		end
	end
	if count > 0 then
		return addEvent(spawnTimer,5000)
	end
	return nextWave()
end

function getTableByWave(num)
	local nowwave = tonumber(num) or getGlobalStorageValue(surv_stor_wave)
	while nowwave >= 10 do
		nowwave = nowwave - 10
	end
	return nowwave
end

function spawnWave(num)
	local nowwave = tonumber(num) or getGlobalStorageValue(surv_stor_wave)
	local fullcicles = math.max(1, math.floor(nowwave/10))
	local tm = surv_monsters[getTableByWave(num)]
	local cspawn = (fullcicles * tm.multcounter) + math.floor(nowwave/2)
	if tm.forcecount then cspawn = tm.multcounter end
	for n=1,cspawn do
		local namespawn = tm[1][math.random(#tm[1])]
		if tm.shinywave then namespawn = "Shiny ".. namespawn end
		local cr = doSummonCreature(namespawn, getRandomWalkablePos(arenatopsurv,arenabotsurv))
		adjustWildPoke(cr, fullcicles * tm.strmult)
	end
	sendMsgInArea("Wave number ".. nowwave .." started. ".. cspawn .." pokemons were spawned.", arenatopsurv, arenabotsurv)
	return spawnTimer()
end

function lastStandingDeath(cid)
	if getGlobalStorageValue(surv_stor_wave) == 0 then return true end
	local alive = {}
	for _,pid in pairs(getPlayersOnline()) do
		if getPlayerGroupId(pid) <= 3 and isInArea(getThingPos(pid), arenatopsurv, arenabotsurv) then
			table.insert(alive, pid)
		end
	end
	local w = math.max(1, getGlobalStorageValue(surv_stor_wave))
	if(math.floor(w/10) > 0 and math.floor(w/10) < 15) then doPlayerAddItem(cid, 15644, math.floor(w/10)) end
	if getPlayerLevel(cid) > 150 then addExpByStages(cid, w * 25000 + math.floor(w/10) * 200000, true) end
	doSendMsg(cid, "You've survived for ".. w .." waves!")
	print("> ".. #alive)
	if #alive == 0 then
		doBroadcastMessage(getCreatureName(cid) .." won the survival event!")
		doSendMsg(cid, "You were the last survivor! Here's a prize for you.")
		doPlayerAddItem(cid, 15644, 100)
		return survClean()
	end
end

function nextWave()
	setGlobalStorageValue(surv_stor_wave, getGlobalStorageValue(surv_stor_wave)+1)
	local nowwave = getGlobalStorageValue(surv_stor_wave)
	sendMsgInArea("Wave number ".. nowwave .." starting in 10 seconds.", arenatopsurv, arenabotsurv)
	return addEvent(spawnWave, 10 * 1000)
end

function survStart2()
	local count = 0
	for _,pid in pairs(getPlayersOnline()) do
		if getPlayerGroupId(pid) < 3 and isInArea(getThingPos(pid), arenatopsurv, arenabotsurv) then
			count = count + 1
			doPlayerSendTextMessage(pid, MESSAGE_STATUS_WARNING, "The survival has begun. First wave starts in 30 seconds, good luck!")
		end
	end
	doBroadcastMessage("The survival has begun, ".. count .." players are inside the arena.")
	removeTp({x=1021,y=1020,z=7})
	addEvent(nextWave, 1000 * 20)
end


function dmClean()
	for x=1285,1318 do
		for y=472,489 do
			for stack=250,255 do
				local checkpos = {x=x,y=y,z=6,stackpos=stack}
				local c = getThingFromPos(checkpos).uid
				if isCreature(c) and not isSummon(c) and not isPlayer(c) then
					doRemoveCreature(c)
				end
			end
		end
	end
end

function survClean()
	setGlobalStorageValue(surv_stor_wave, 0)
	for x=arenatopsurv.x,arenabotsurv.x do
		for y=arenatopsurv.y,arenabotsurv.y do
			for stack=250,255 do
				local checkpos = {x=x,y=y,z=arenatopsurv.z,stackpos=stack}
				local c = getThingFromPos(checkpos).uid
				if isCreature(c) and not isSummon(c) and not isPlayer(c) then
					doRemoveCreature(c)
				end
			end
		end
	end
end

function survStart1()
	survClean()
	doSendAnimatedText({x=1021,y=1020,z=7}, "SURVIVAL!", COLOR_BURN)
	doCreateTeleport(1387,{x=1301,y=480,z=6},{x=1021,y=1020,z=7})
	doBroadcastMessage("A survival event is starting in 1 minutes, the teleport to the arena has been created. At least 5 are needed for the battle to start.")
	addEvent(survStart2, 1 * 60 * 1000)
end
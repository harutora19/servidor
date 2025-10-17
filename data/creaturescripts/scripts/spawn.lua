local shinysName = {
"Magikarp", "Voltorb", "Rattata", "Krabby", "Paras", "Horsea",

"Growlithe", "Grimer", "Larvitar", "Dratini", "Tentacool", "Zubat", "Cubone", "Venonat",

"Golbat", "Parasect", "Butterfree", "Beedrill", "Seadra", "Kingler", "Raticate",

"Magcargo", "Crobat", "Electrode", "Venomoth",

"Feraligatr", "Lanturn", "Blastoise", "Pidgeot", "Arcanine", "Charizard", "Mr. Mime", "Tangela", "Machamp", "Weezing", "Alakazam", "Dragonair",
"Venusaur", "Tauros", "Tentacruel", "Jynx", "Pupitar", "Ampharos", "Muk", "Typhlosion", "Marowak", "Xatu", "Raichu", "Pinsir", "Gengar", "Meganium",

"Gyarados", "Magmar", "Electabuzz", "Scyther", "Giant Magikarp", "Farfetch'd",

}

local shinyOutland = {
"Venusaur", 'Blastoise', 'Charizard', 'Tentacruel', 'Tangela', 'Jynx', 'Venomoth', 'Machamp', 'Marowak', 'Muk', 'Raichu', 'Pidgeot', 'Pinsir', 'Giant Magikarp', "Farfetch'D", "Mr. Mime", "Weezing", "Sandslash",
"Meganium", 'Feraligatr', 'Typhlosion', 'Lanturn', 'Ampharos', 'Crobat', 'Magcargo', 'Xatu', 
}

local phBoss = {'Rhyperior','Magmortar','Electivire','Dusknoir','Milotic','Metagross','Tangrowth','Slaking','Salamence'}
local shinyPhenac = {"Manectric", "Gardevoir", "Sceptile", "Swampert", "Flygon", "Grumpig"}

-- local phenacPokes = {'Zoroark', 'Pangoro', 'Archeops', 'Carracosta', 'Shiny Rampardos', "Shiny Heatmor"}

function onSpawn(cid)
	if getCreatureName(cid) == "" or getCreatureName(cid) == nil then
	   setPlayerStorageValue(cid, 510, getCreatureNick(cid))
	end
	
	
	--if isTwoGerenetion(doCorrectString(getCreatureName(cid))) then doRemoveCreature(cid) return false end
	registerCreatureEvent(cid, "GeneralConfiguration")
	registerCreatureEvent(cid, "WildAttack")
	registerCreatureEvent(cid, "Experience")
	registerCreatureEvent(cid, "Matou")
	registerCreatureEvent(cid, "PokeWalk")
	registerCreatureEvent(cid, "StatsChange")
	
	if not ehMonstro(cid) then
		registerCreatureEvent(cid, "Target")
		registerCreatureEvent(cid, "Matou")
		registerCreatureEvent(cid, "SummonDeath")
		getPokeDistanceToTeleport(cid)
		setPokemonGhost(cid)
		if getCreatureName(cid):find("Shiny ") then
		   setPlayerStorageValue(cid, storages.EhShiny, 1)
		end
	return true
	end
	
	addEvent(doShiny, 1, cid)
	addEvent(doSpawnMega, 1, cid)
	addEvent(spawnBoss, 1, cid)
	addEvent(spawnShinyPhenac, 1, cid)
	addEvent(spawnShinyOutland, 1, cid)
	adjustWildPoke(cid, rate)
	setPokemonGhost(cid)
	doMarkedPos(cid, getThingPos(cid))
	
	   if isPokePassive(cid) then
	      setPokemonPassive(cid, true)
	   end

return true
end

function doSpawnMega(cid)
	if isSummon(cid) then return true end
	if isCreature(cid) then
	if isInArray({"Alakazam", "Blastoise", "Gengar", "Ampharos", "Venusaur", "Tyranitar", "Kangaskhan", "Scizor", "Aerodactyl", "Pidgeot", "Mawile", "Gardevoir", "Absol", "Lucario", "Sceptile", "Swampert", "Aggron", "Blaziken", "Slowbro", "Glalie", "Steelix", "Banette", "Sableye", "Manectric", "Gyarados", "Camerupt", "Abomasnow", "Loppuny", "Beedrill", "Houndoom", "Pinsir", "Salamence"}, doCorrectString(getCreatureName(cid))) then
		local sid = cid
		local chance = 60
		if math.random(1, 10000) <= chance then  
			local pos = getThingPosWithDebug(cid)
			pos.x = pos.x +1
			pos.y = pos.y +1
			doSendMagicEffect(pos, 574)               
			local name, pos = "Mega ".. getCreatureName(cid), getThingPos(cid)
			if not pokes[name] then return true end
			doRemoveCreature(cid)
			local mega = doCreateMonsterNick(sid, name, retireShinyName(name), pos, false)
			adjustWildPoke(mega, 5)
		end 
	end
	end
return true
end

function spawnBoss(cid)
	if isSummon(cid) then return true end
	if isCreature(cid) then
		if isWild(cid) and isPhenac(doCorrectString(getCreatureName(cid))) then
			local chance = 40
			if math.random(1, 10000) <= chance then
				local boss = doSummonCreature(phBoss[math.random(1, #phBoss)], getThingPos(cid))
				adjustWildPoke(boss, 2)
				return true
			end
			return true
		end
		return true
	end
end

function spawnShinyPhenac(cid)
	if isCreature(cid) then
		if isSummon(cid) then return true end
		if isNPCSummon(cid) then return true end
		local chance = 0
		if isInArray(shinyPhenac, doCorrectString(getCreatureName(cid))) then
		   chance = 100    --2.5% chance  
		end    
		local sid = cid
		if math.random(1, 10000) <= chance then  
		  doSendMagicEffect(getThingPos(cid), 18)               
		  local name, pos = "Shiny ".. getCreatureName(cid), getThingPos(cid)
		  if not pokes[name] then return true end
		  doRemoveCreature(cid)
		  --print(name .. ", " .. retireShinyName(name))
		local shi = doCreateMonsterNick(sid, name, retireShinyName(name), pos, false)
		adjustWildPoke(shi, 3)		  
		end 
		return true
	end
	return false
end

function spawnShinyOutland(cid)
	if isCreature(cid) then
		if isSummon(cid) then return true end
		if isNPCSummon(cid) then return true end
		if isOutlandPoke(getCreatureName(cid)) then
			local namee = "Shiny ".. shinyOutland[math.random(21, #shinyOutland)]
			local side, pose = cid, getThingPos(cid)
			if pokes[namee] then
				if math.random(1,10000) <= 30 then
					doSendMagicEffect(getThingPos(cid), 18)    
					local shi = doCreateMonsterNick(side, namee, retireShinyName(namee), pose, false)
					adjustWildPoke(shi, 1)
				end
			else
				print(namee .." doesn't exists!")
			end
		end
	end
end


-- local chShinyOut = 200 -- 4%
		
function doShiny(cid)
	if isCreature(cid) then
		if isSummon(cid) then return true end
		if isNPCSummon(cid) then return true end
		local chance = 0
		if isInArray(shinysName, doCorrectString(getCreatureName(cid))) then  --alterado v1.9 \/
		   chance = 400    --2.5% chance  
		end    
		local sid = cid
		if math.random(1, 10000) <= chance then  
		  doSendMagicEffect(getThingPos(cid), 18)               
		  local name, pos = "Shiny ".. getCreatureName(cid), getThingPos(cid)
		  if not pokes[name] then return true end
		  doRemoveCreature(cid)
		  --print(name .. ", " .. retireShinyName(name))
			local shi = doCreateMonsterNick(sid, name, retireShinyName(name), pos, false)
			-- local boss = doSummonCreature(phBoss[math.random(1, #phBoss)], getThingPos(cid))
			adjustWildPoke(shi, 1.20)		  
		end 
		return true
	end
	return false
end
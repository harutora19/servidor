local damages = {GROUNDDAMAGE, ELECTRICDAMAGE, ROCKDAMAGE, FLYDAMAGE, BUGDAMAGE, FIGHTINGDAMAGE, DRAGONDAMAGE, POISONDAMAGE, DARKDAMAGE, STEELDAMAGE}
local fixdmgs = {PSYCHICDAMAGE, COMBAT_PHYSICALDAMAGE, GRASSDAMAGE, FIREDAMAGE, WATERDAMAGE, ICEDAMAGE, NORMALDAMAGE, GHOSTDAMAGE}
local ignored = {POISONEDDAMAGE, BURNEDDAMAGE}                --alterado v1.6
local cannotkill = {BURNEDDAMAGE, POISONEDDAMAGE}

local typesXE = {
["dark"] = {efct = 432, dmg = DARKDAMAGE},
["ghost"] = {efct = 138, dmg = GHOSTDAMAGE},
["poison"] = {efct = 114, dmg = POISONDAMAGE},
["grass"] = {efct = 45, dmg = GRASSDAMAGE},
["bug"] = {efct = 105, dmg = BUGDAMAGE},
["rock"] = {efct = 44, dmg = ROCKDAMAGE},
["ground"] = {efct = 100, dmg = GROUNDDAMAGE},
["steel"] = {efct = 77, dmg = STEELDAMAGE},
["ice"] = {efct = 43, dmg = ICEDAMAGE},
["water"] = {efct = 154, dmg = WATERDAMAGE},
["electric"] = {efct = 48, dmg = ELECTRICDAMAGE},
["fire"] = {efct = 35, dmg = FIREDAMAGE},
["psychic"] = {efct = 133, dmg = PSYCHICDAMAGE},
["flying"] = {efct = 42, dmg = FLYINGDAMAGE},
["dragon"] = {efct = 143, dmg = DRAGONDAMAGE},
["normal"] = {efct = 111, dmg = NORMALDAMAGE},
["fighting"] = {efct = 112, dmg = FIGHTINGDAMAGE},
["fairy"] = {efct = 431, dmg = FAIRYDAMAGE},
["crystal"] = {efct = 175, dmg = CRYSTALDAMAGE},
}

function doXElemental(cid, damage)
	local ptype = pokes[getCreatureName(cid)].type
	local ptype2 = pokes[getCreatureName(cid)].type2
	local eff, damag = 1392, 0
	
	if ptype2 ~= "no type" then
		if math.random(1,100) <= 50 then
			eff = typesXE[ptype].efct
			damag = typesXE[ptype].dmg
		else
			eff = typesXE[ptype2].efct
			damag = typesXE[ptype2].dmg
		end
	else
		eff = typesXE[ptype].efct
		damag = typesXE[ptype].dmg
	end
	
	local function sendStickEff(cid, dir)
		if not isCreature(cid) then return true end
		doAreaCombatHealth(cid, damag, getPosByDir(getThingPosWithDebug(cid), dir), 0, -damage*0.9, -damage*1.1, eff)
	end
	
	local t = {
	      [1] = SOUTHWEST,
	      [2] = SOUTH,
	      [3] = SOUTHEAST,
	      [4] = EAST,
	      [5] = NORTHEAST,
	      [6] = NORTH,
	      [7] = NORTHWEST,
	      [8] = WEST,
	      [9] = SOUTHWEST,
		}
	for a = 1, 9 do
		addEvent(sendStickEff, a * 800, cid, t[a])
	end
	
	--doMoveInArea2(cid, eff, check, damag, -damage*0.9, -damage*1.1)
	--stopNow(cid, 250)
end		
		
local combineTable = {
["X-Return"] = {"X-Critical", "X-Defense", "X-Vitality", "X-Attack", "X-Block"},
["X-Block"] = {"X-Critical", "X-Defense", "X-Vitality", "X-Attack", "X-Block", "X-Vampiric"},
["X-Critical"] = {"X-Vampiric", "X-Attack", "X-Vitality", "X-Return", "X-Block"},
["X-Vampiric"] = {"X-Critical", "X-Defense", "X-Return", "X-Block"},
["X-Elemental"] = {"X-Block"},
["X-Attack"] = {"X-Critical", "X-Defense", "X-Vitality", "X-Return", "X-Block"},
["X-Defense"] = {"X-Critical", "X-Attack", "X-Vitality", "X-Return", "X-Block"},
}

local posa1, posa2 = {x=2558,y=2478,z=9}, {x=3368,y=3491,z=1}

function doEffectiveDamage(cid, value, combat, attacker)
	-- if getCreatureName(cid):lower() == 'npca' then return 250 end
	
	local spellRace, pokeElement1, pokeElement2 = getElementByCombat(combat), getPokemonType(cid).type1, getPokemonType(cid).type2
	local master = ""
	if isSummon(attacker) then master = getCreatureMaster(attacker) end
	-- local god = getPlayerByName("Nautilus")
	
	if combat == 1 then	return value end
	if not typeTable[spellRace] then 
		print("spellRace not on typeTable when combat = ".. combat ..".")
		return false
	end
	
	local vinicial = value
	
	if isInArray(typeTable[spellRace].super, pokeElement1) then -- 50% dano a mais para elemento1
		value = value * 2
	end
	if isInArray(typeTable[spellRace].super, pokeElement2) then -- 50% dano a mais para elemento2
		value = value * 2
	end
	if isInArray(typeTable[spellRace].week, pokeElement1) then -- 50% dano a menos para elemento1
		value = value / 1.5
	end
	if isInArray(typeTable[spellRace].week, pokeElement2) then -- 50% dano a menos para elemento2
		value = value / 1.5
	end
	if isInArray(typeTable[spellRace].non, pokeElement1) or isInArray(typeTable[spellRace].non, pokeElement2) then -- dano zero
		if isPlayer(master) then
			local clan, rank = getPlayerClan(master):lower(), getPlayerClanRank(master)
			if (isInArray(clanTypes[clan], spellRace) and rank == 5) or (isInDuel(master)) then
				value = value / 2
			else
				value = 0 
			end
		elseif isConditionImune(attacker) and isWild(attacker) then
			value = value / 3
		else
			value = 0
		end
	end
	if isInArray({"ice", "fire"}, spellRace) then
		if (getCreatureName(cid) == "Mega Venusaur" and value ~= 0) or isInArray(specialabilities["thick fat"], getCreatureName(cid)) then -- Passiva thick fat
		   value = value / 2
		end
	end
	if isInArray({"bug", "rock", "dark", "normal"}, spellRace) then
		if isInArray(specialabilities["tough spirit"], getCreatureName(cid)) then
			value = value / 2
		end
	end
	
	if isInArray({"fire"}, spellRace) then
		if isInArray(specialabilities["water sport"], getCreatureName(cid)) then
			value = 0.5
		end
	end
	
	if getCreatureName(cid) == "Camerupt" then
		value = math.min(vinicial, value)
	end
	
	return value
end

function addSelfDano(cid, newDano)
if not isCreature(cid) then return true end
local playerName = "Self"
local str = getPlayerStorageValue(cid, storages.damageKillExp)
if str == -1 then
   setPlayerStorageValue(cid, storages.damageKillExp, playerName .. "/" .. newDano .. "|")	
   return true
end
	local players = string.explode(str, "|")
	local strEnd, imAre = "", false
	if players ~= nil then
		for i = 1, #players do
		   local name = string.explode(players[i], "/")[1]
		   local dano = string.explode(players[i], "/")[2]
		   
		   if name == playerName then
			  strEnd = strEnd .. name .. "/" .. dano + newDano .. "|"
			  imAre = true
		   else
		      strEnd = strEnd .. name .. "/" .. dano .. "|"
		   end
		   
		end
		if not imAre then
		   strEnd = strEnd .. playerName .. "/" .. newDano .. "|"
		end
		setPlayerStorageValue(cid, storages.damageKillExp, strEnd)
    end		
end

DPS_STORAGE = 50392
PLAYER_DPS = {}
PLAYER_EVENTS = {}

local function ReadDPS(cid, attacker)
    if isCreature(cid) and isCreature(attacker) then
        if PLAYER_DPS[attacker] > getPlayerStorageValue(attacker, DPS_STORAGE) then
            setPlayerStorageValue(attacker, DPS_STORAGE, PLAYER_DPS[attacker])
            doCreatureSay(cid, string.format("New Record! DPS: %d", PLAYER_DPS[attacker]), TALKTYPE_MONSTER, nil, nil, getCreaturePosition(cid))
        else
            doCreatureSay(cid, string.format("DPS: %d", PLAYER_DPS[attacker]), TALKTYPE_MONSTER, nil, nil, getCreaturePosition(cid))
        end
        PLAYER_DPS[attacker] = 0
        PLAYER_EVENTS[attacker] = nil
    end
end

function onStatsChange(cid, attacker, type, combat, value)
if isPlayer(cid) and isInArea(getThingPos(cid), towerTopCorner, towerBottomCorner) then
	if not isCreature(attacker) then
		return true -- trap dar dano na tower
	end
end
--------------------- healarea ---------------------
if type == STATSCHANGE_HEALTHGAIN then
	if cid == attacker then
		if isInArea(getThingPos(cid), posa1, posa2) then
			doSendMagicEffect(getThingPos(cid), 301)
			return false
		else
			return true
		end
		return true
	end
	if isSummon(cid) and isInDuel(getCreatureMaster(cid)) and attacker ~= 0 then
		return false
	end
	if isSummon(cid) and isSummon(attacker) and canAttackOther(cid, attacker) == "Cant" then
		return false
	end
	if isPlayer(cid) and isInArea(getThingPos(cid), posa1, posa2) then -- nao curar na deathmatch
		doSendMagicEffect(getThingPos(cid), 301)
		return false
	end
	if isWild(cid) and isWild(attacker) then -- monstros se curarem
		if isInArea(getThingPos(cid), {x=125, y=767, z=6}, {x=148, y=789, z=6}) then
			value = math.min(100000, value)
		end
		return true 
	end
return true
end
--------------------- healarea ---------------------
if isSleeping(attacker) then return false end
if isPlayer(cid) and isSummon(attacker) and canAttackOther(cid, attacker) == "Cant" and not isInArea(getThingPos(cid), posa1, posa2) then return false end
if combat == FLYSYSTEMDAMAGE then return false end
-- if isPlayer(cid) and getCreatureOutfit(cid).lookType == 814 then return false end -- TV
if (isPlayer(cid) and #getCreatureSummons(cid) >= 1 and not getTileInfo(getThingPos(getCreatureSummons(cid)[1])).protection) or isPlayer(attacker) then
	if not isInArea(getThingPos(cid), posa1, posa2) then return false end
end -- seguranca do player nao atacar
if isGod(cid)  then return false end
if isWild(cid) and isWild(attacker) then return false end
if getTileInfo(getThingPos(cid)).protection then return false end
-- if isInArray({"Armadilha Blizzard"}, doCorrectString(getCreatureName(cid))) then return true end
-- duel system e outros

--- alignment
-- if isNPCA(cid) then
	-- if getNPCSummon(cid) then
		-- return false
	-- end
-- end
-- if isNPCSummon(cid) then
	-- if isCreature(getNPCMaster(cid)) then
		-- local npc = getNPCMaster(cid)
		-- local master = getCreatureMaster(attacker)
		-- if getCreatureAlignment(master) == 'none' or (getCreatureAlignment(master) == getCreatureAlignment(npc)) then
			-- return false
		-- end
	-- end
-- end
-- if isNPCSummon(attacker) then
	-- if isCreature(getNPCMaster(attacker)) then
		-- local npc = getNPCMaster(attacker)
		-- local master = getCreatureMaster(cid)
		-- if getCreatureAlignment(master) == 'none' or (getCreatureAlignment(master) == getCreatureAlignment(npc)) then
			-- return false
		-- end
	-- end
-- end
---

if isSummon(cid) and isSummon(attacker) then
	local p1, p2 = getCreatureMaster(cid), getCreatureMaster(attacker)
	if not CanAttackerInDuel(p1, p2) and not isInArea(getThingPos(cid), posa1, posa2) then
	   return false
	end
end

if isSummon(attacker) and isPlayer(cid) then
	if isInArea(getThingPos(cid), posa1, posa2) then
		if #getCreatureSummons(cid) >= 1 then
			return false
		end
	else
	return false -- quandotiver pvp colocar storage do pvp aqui
	end
end

if (isSummon(cid) and isSummon(attacker) and not isInDuel(cid)) or (isSummon(attacker) and isWild(cid)) or (isWild(attacker) and not isWild(cid)) then

	-- if isSummon(cid) and isSummon(attacker) and canAttackOther(cid, attacker) == "Cant" then
		-- return false
	-- end

	if isSummon(attacker) and getCreatureName(cid) == "Dummy" then
		if not PLAYER_DPS[attacker] then
            PLAYER_DPS[attacker] = 0
        end
        PLAYER_DPS[attacker] = PLAYER_DPS[attacker] - value * 10
        if not PLAYER_EVENTS[attacker] then
            PLAYER_EVENTS[attacker] = addEvent(ReadDPS, 10000, cid, attacker)
        end
	end

    if combat == STATUS_SLEEP then
        setPokemonStatus(cid, "sleep", value, 0, true, attacker)
        return false
    elseif combat == STATUS_STUN10 or combat == STATUS_STUN7 then
		if isCreature(cid) and isCreature(attacker) then
			if pokes[getCreatureName(cid)].type == "ground" or pokes[getCreatureName(cid)].type2 == "ground" and pokes[getCreatureName(attacker)].type == "electric" or pokes[getCreatureName(attacker)].type2 == "electric" then
				return true
			else
				setPokemonStatus(cid, "stun", (combat == STATUS_STUN10 and 10 or 4), value, true, attacker)
			end
		end
        
        return false
    elseif combat == STATUS_STRING then
        setPokemonStatus(cid, "string", value, 0, true, attacker)
        return false
    elseif combat == STATUS_BLIND then
		if isCreature(cid) and isCreature(attacker) then
			if pokes[getCreatureName(cid)].type == "flying" or pokes[getCreatureName(cid)].type2 == "flying" and pokes[getCreatureName(attacker)].type == "ground" or pokes[getCreatureName(attacker)].type2 == "ground" then
				return true
			else
				setPokemonStatus(cid, "blind", value, 0, true, attacker)
			end
		end
        
        return false
    elseif combat == STATUS_CONFUSION10 or combat == STATUS_CONFUSION7 then
        setPokemonStatus(cid, "confusion", (combat == STATUS_CONFUSION10 and 3 or 4), value, true, attacker)
        return false
    elseif combat == STATUS_POISON20 or combat == STATUS_POISON10 or combat == STATUS_POISON5 then
        setPokemonStatus(cid, "poison", (combat == STATUS_POISON5 and 5 or combat == STATUS_POISON10 and 10 or 20), value, true, attacker)
        return false
    elseif combat == STATUS_BURN5 or combat == STATUS_BURN10 then
        setPokemonStatus(cid, "burn", (combat == STATUS_BURN5 and 5 or 10), value, true, attacker)
        return false
    elseif combat == STATUS_LEECHSEED then
        setPokemonStatus(cid, "leechSeed", 20, value, true, attacker)
        return false
    elseif combat == STATUS_FEAR then
        -- setPokemonStatus(cid, "fear", value, 0, true, attacker)
		setPokemonStatus(cid, "silence", 5, value, true, attacker)
		-- setPokemonStatus(cid, "silence", 8, value, true, attacker)
        return false
    elseif combat == STATUS_SLOW then
        setPokemonStatus(cid, "speedDown", value, 0, true, attacker)
        return false
    elseif combat == STATUS_SILENCE then
        setPokemonStatus(cid, "silence", 5, value, true, attacker)
		-- setPokemonStatus(cid, "silence", 8, value, true, attacker)
    elseif combat == STATUS_PARALYZE then
        setPokemonStatus(cid, "paralyze", 3, value, true, attacker)
        return false
    end
end


if not (isCreature(attacker)) then return true end
if not isCreature(cid) then return false end

local raceCombat = typeTable[getElementByCombat(combat)] -- funciona ?
local spellNameFromAttacker = getPlayerStorageValue(attacker, 21102)

	if isWild(cid) and getCreatureName(cid) == "Shadow" and isSummon(attacker) then
		local toposi = {{x=1909,y=2003,z=10},{x=1931,y=1995,z=10},{x=1930,y=2008,z=10}}
		local isInAPos = false
		local master = getCreatureMaster(attacker)
		for i,v in pairs(toposi) do
			if v.x == getThingPos(master).x and v.y == getThingPos(master).y then
				isInAPos = true
			end
		end
		if not isInAPos then return false end -- não está na posição para matar os summons
	end
	if isWild(cid) and getCreatureName(cid) == "Lugia" and isSummon(attacker) then
		local poscrystals = {{x=2011,y=1960,z=4},{x=2009,y=1939,z=4},{x=1983,y=1939,z=4},{x=1982,y=1959,z=4},}
		for i,v in pairs(poscrystals) do
			local chpos = v
			chpos.stackpos = 255
			if isCreature(getThingFromPos(chpos).uid) then
				local pid = getCreatureMaster(attacker)
				if not getPlayerStorageValue(pid, 123713) or getPlayerStorageValue(pid, 123713) < os.time() then
					setPlayerStorageValue(pid, 123713, os.time() + 10)
					doSendMsg(pid, "Lugia is protected by the crystals, you have to break them before targeting it.")
				end
				return false
			end
		end
	end
	if isWild(cid) and getCreatureName(cid) == "Crystal" and isSummon(attacker) then
		if getPlayerStorageValue(cid, 42415) ~= 1 then
			local pid = getCreatureMaster(attacker)
			if not getPlayerStorageValue(pid, 123714) or getPlayerStorageValue(pid, 123714) < os.time() then
				setPlayerStorageValue(pid, 123714, os.time() + 10)
				doSendMsg(pid, "This crystal is not vulnerable.")
			end
			return false
		end
	end
	
	if isWild(cid) and getCreatureName(cid) == "Entei" and isSummon(attacker) then
		local posEntei = {{x=2942,y=2953,z=9},{x=2942,y=2967,z=9},{x=2967,y=2953,z=9},{x=2967,y=2967,z=9}}
		for i,v in pairs(posEntei) do
			local chpos = v
			chpos.stackpos = 255
			if isCreature(getThingFromPos(chpos).uid) then
				local pid = getCreatureMaster(attacker)
				if not getPlayerStorageValue(pid, 123715) or getPlayerStorageValue(pid, 123715) < os.time() then
					setPlayerStorageValue(pid, 123715, os.time() + 10)
					doSendMsg(pid, "Entei is protected by the crystals, you have to break them before targeting it.")
				end
				return false
			end
		end
	end
	if isWild(cid) and getCreatureName(cid) == "Pedestal Entei" and isSummon(attacker) then
		if getPlayerStorageValue(cid, 65009) ~= 1 then
			local pid = getCreatureMaster(attacker)
			if not getPlayerStorageValue(pid, 123716) or getPlayerStorageValue(pid, 123716) < os.time() then
				setPlayerStorageValue(pid, 123716, os.time() + 10)
				doSendMsg(pid, "This pedestal is not vulnerable.")
			end
			return false
		end
	end
	
	-- player morte e ataques
	if isPlayer(cid) and (#getCreatureSummons(cid) <= 0 or #getCreatureSummons(cid) >= 1 and getTileInfo(getThingPos(getCreatureSummons(cid)[1])).protection) then
		
		local mynamea = getCreatureName(attacker)
		if isWild(attacker) then mynamea = getCreatureName(attacker) end
		
		local color = 180
		if (combat == 128 or combat == 1) and spellNameFromAttacker == -1  then
			local at = pokes[getCreatureName(attacker)].attack or getPlayerStorageValue(attacker, 1001) or getAttack(attacker)
			if getPlayerStorageValue(attacker, towerMonsterStorage) > 0 then
				at = math.max(at, getPlayerStorageValue(attacker, 1001))
			end 
			value = - math.random(at * 50, at * 100)
		else
			if not typeTable[getMoveType(mynamea, spellNameFromAttacker)] then
				color = 180
			else
			    color = typeTable[getMoveType(mynamea, spellNameFromAttacker)].color or 180
			end
		end
		
		if isInArray({"Armadilha Fogo Grande", "Armadilha Raio Grande", "Armadilha Gelo Grande", "Armadilha Raio Pequena"}, doCorrectString(getCreatureName(attacker))) then
				value = (getCreatureMaxHealth(cid) * 70) / 100
			elseif isInArray({"Armadilha Fogo Pequena"}, doCorrectString(getCreatureName(attacker))) then
				value = (getCreatureMaxHealth(cid) * 40) / 100
			elseif isInArray({"Parede de Fogo"}, doCorrectString(getCreatureName(attacker))) then
				value = (getCreatureMaxHealth(cid) * 5) / 100
		end


		if value >= getCreatureHealth(cid) then
			value = getCreatureHealth(cid)
		end
	
		value = math.ceil(value)
	
	   if value < 0 then value = value*-1 end

	   if (value) >= getCreatureHealth(cid) then
			if isInArea(getThingPos(cid), posa1, posa2) then
				doTeleportThing(cid, {x=2433,y=2632,z=8})
				return false
			end
			if isInArea(getThingPos(cid), {x=1285, y=472, z=6}, {x=1318, y=489, z=6}) then
				doTeleportThing(cid, {x=1018,y=1017,z=7})
				lastStandingDeath(cid)
				return false
			end
		  doKillPlayer(cid, attacker, (value*-1))
		  return false
	   end
	   doSendAnimatedText(getThingPosWithDebug(cid), (convertToString(value * -1)), color) 
	   doCreatureAddHealth(cid, value*-1)
	   setPlayerStorageValue(attacker, 21102, -1) -- reseta a spellName do pokemon atacante
	   return false
	end
	-- player morte e ataques


	if not isPlayer(cid) then
	-- valores do atacante
	
	if isPokePassive(cid) and isSummon(attacker) then
	   doSetPokemonAgressiveToPlayer(cid, getCreatureMaster(attacker))
	end
	
	if doCorrectString(getCreatureName(cid)) == "Dummy" then
		doSetCreatureOutfit(cid, {lookType = 2465}, 1000)
	end
	
	--local myName = doCorrectString(getCreatureName(cid))
	-- local myName = isMega(cid) and doCorrectString(getPlayerStorageValue(cid, storages.isMega)) or doCorrectString(getCreatureName(cid))
	-- if isInArray(specialabilities["evasion"], myName) and isSummon(cid) then 
	   -- local target = cid
	   -- if getCreatureTarget(getCreatureMaster(cid)) == attacker then 
		   -- if math.random(1, 100) <= passivesChances["Evasion"][myName] then                                                                                      
			  -- if isCreature(attacker) then  --alterado v1.6 
				 -- doSendMagicEffect(getThingPosWithDebug(target), 211)
				 -- doSendAnimatedText(getThingPosWithDebug(target), "TOO BAD", 215)                                 
				 -- doTeleportThing(target, getClosestFreeTile(target, getThingPosWithDebug(attacker)), false)
				 -- doSendMagicEffect(getThingPosWithDebug(target), 211)
				 -- doFaceCreature(target, getThingPosWithDebug(attacker)) 
				 -- return false    
			  -- end
			-- end   
		-- end
	-- end

	if isSummon(attacker) then
		local m = getCreatureMaster(attacker)
		value = value < getPlayerLevel(m) and math.ceil(getPlayerLevel(m) * math.random(0.99,2.99)) or value
	end
	
	local critical, criticalValue = false, 0
	local vampiric, vampiricValue = false, 0
	local xattack, xattackValue = false, 1
	local returnDamage = false

	------------- Helds 
	if isSummon(cid) then
		local master = getCreatureMaster(cid)
		local heldx = getItemAttribute(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "xHeldItem")
		local heldName, heldTier = "", ""
		if heldx then
			  heldName, heldTier = string.explode(heldx, "|")[1], string.explode(heldx, "|")[2]
			  if heldName == "X-Block" and isSummon(cid) then 	     -- bloquear alguns ataques
				local chance = heldBlockChance[tonumber(heldTier)]
				if isInDuel(master) then chance = chance / 2 end
				if (math.random(1, 100) <= chance) then
					doSendAnimatedText(getThingPos(cid), "BLOCKED", 215)
					return false
				end
			  end
			  -- if heldName == "X-Return" and isSummon(cid) then 	     -- bloquear alguns ataques
				-- local chance = heldReturn[tonumber(heldTier)]
				-- if (math.random(1, 100) <= chance) then
					-- returnDamage = true
					-- returnDamageValue = heldReturn[tonumber(heldTier)]
				-- end
			  -- end
			 if heldName == "X-Elemental" and isSummon(cid) then
				local chance = heldElemental[tonumber(heldTier)]
				local mboost = getPokemonBoost(cid) or 1
				local dm = getPlayerStorageValue(cid, 1005) > 0 and getPlayerStorageValue(cid, 1005) or 5
				local d = getPlayerLevel(getCreatureMaster(cid)) * dm / 3 + mboost * 10
				
				if math.random(1,100) <= chance then
					doXElemental(cid, d / 2)
				end
			end
		end		
		
		local heldz = getItemAttribute(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, "zHeldItem")
		if heldz and heldz ~= -1 and not isInTourArea(getCreatureMaster(cid)) then
		local heldNameZ, heldTierZ = string.explode(heldz, "|")[1], string.explode(heldz, "|")[2]
			if heldNameZ ~= heldName then
			
			  if heldNameZ == "X-Block" and isSummon(cid) then 	     -- bloquear alguns ataques
				local chance = heldBlockChance[tonumber(heldTierZ)]
				if isInDuel(master) then chance = chance / 2 end
				if (math.random(1, 100) <= chance) then
					doSendAnimatedText(getThingPos(cid), "BLOCKED", 215)
					return false
				end
			  end
			  
			  -- if heldNameZ == "X-Return" and isSummon(cid) then 	     -- bloquear alguns ataques
				-- local chance = heldReturn[tonumber(heldTierZ)]
				-- if (math.random(1, 100) <= chance) then
					-- returnDamage = true
					-- returnDamageValue = heldReturn[tonumber(heldTierZ)]
				-- end
			  -- end

			 if heldNameZ == "X-Elemental" and isSummon(cid) then
				local chance = heldElemental[tonumber(heldTierZ)]
				local mboost = getPokemonBoost(cid) or 1
				local dm = getPlayerStorageValue(cid, 1005) > 0 and getPlayerStorageValue(cid, 1005) or 5
				local d = getPlayerLevel(getCreatureMaster(cid)) * dm / 3 + mboost * 10

				if math.random(1,100) <= chance then
					doXElemental(cid, d / 2)
				end
			end
		  end
		end
	end
	
	
	if isSummon(attacker) then
		local heldx = getItemAttribute(getPlayerSlotItem(getCreatureMaster(attacker), 8).uid, "xHeldItem")
		local heldName, heldTier = "", ""
		if heldx then
			 heldName, heldTier = string.explode(heldx, "|")[1], string.explode(heldx, "|")[2]
		
			  if heldName == "X-Critical" then -- dar critico nos ataques
				local chance = heldCriticalChance[tonumber(heldTier)]
				if (math.random(1, 100) <= chance) then
					critical = true
					criticalValue = ((math.random(50, 100))/100)
				end
			  end
			  
			  if heldName == "X-Vampiric" then -- curar parte do dano nos ataques
				vampiric = true
				vampiricValue = heldVampiric[tonumber(heldTier)]
			  end
		end
	-- if getCreatureOutfit(cid).lookType == 3194 and pokes[getCreatureName(cid)].type or pokes[getCreatureName(cid)].type2 == "fire" then
		-- if getCreatureOutfit(getCreatureMaster(attacker)).lookType == 3194 and pokes[getCreatureName(attacker)].type == "fire" or pokes[getCreatureName(attacker)].type2 == "fire" then
		-- if getCreatureOutfit(getCreatureMaster(attacker)).lookType == 3194 and pokes[getCreatureName(attacker)].type == "fire" or pokes[getCreatureName(attacker)].type2 == "fire" then
			-- value = value * 1.10 
			-- value = value * 3
		-- end
		-- if getCreatureOutfit(getCreatureMaster(attacker)).lookType == 965 then
			-- value = value * 1.10 
			-- vampiric = true
			-- vampiricValue = 50
		-- end
		
		local heldz = getItemAttribute(getPlayerSlotItem(getCreatureMaster(attacker), 8).uid, "zHeldItem")
		if heldz and heldz ~= -1 and not isInTourArea(getCreatureMaster(attacker)) then
			local heldNameZ, heldTierZ = string.explode(heldz, "|")[1], string.explode(heldz, "|")[2]
			if heldNameZ ~= heldName then
			
				  if heldNameZ == "X-Critical" then -- dar critico nos ataques
					local chance = heldCriticalChance[tonumber(heldTierZ)]
					if (math.random(1, 100) <= chance) then
						critical = true
						criticalValue = ((math.random(50, 100))/100)
					end
				  end
				  
				  if heldNameZ == "X-Vampiric" then -- curar parte do dano nos ataques
					vampiric = true
					vampiricValue = heldVampiric[tonumber(heldTierZ)]
				  end
			    
				  if heldNameZ == "X-Attack" then
					xattack = true
					xattackValue = heldAttack[tonumber(heldTierZ)]
				  end
			end
		end
	end

	------------- Helds 
	
	if isReflect(attacker) then
		local spellName = getPlayerStorageValue(attacker, 21102)
		setPlayerStorageValue(attacker, 21102, -1) 
		if spellName ~= -1 then
			local valueReflected = tonumber(getPlayerStorageValue(attacker, 21105))
			if valueReflected > 0 then
			   removeReflect(attacker)
			   -- sendOpcodeStatusInfo(attacker)
			   --value = valueReflected
			   doCreatureAddHealth(cid, -math.floor(value))
			   doSendAnimatedText(getThingPos(cid), (convertToString(value) == 0 and "" or convertToString(value)), COLOR_GRASS)
			   if isSummon(cid) then doSendLifePokeToOTC(getCreatureMaster(cid)) end
				if value >= getCreatureHealth(cid) then
					if isSummon(cid) then
						if isInDuel(getCreatureMaster(cid)) then
						   doRemoveCountPokemon(getCreatureMaster(cid))
						end
					end
				-- if isNPCSummon(cid) then
					-- local npc = getNPCMaster(cid)
					-- doSendMagicEffect(getThingPos(cid), 376)
					-- doRemoveCreature(cid)
					-- setPlayerStorageValue(npc, stor_npcteam, getPlayerStorageValue(npc, stor_npcteam)-1)
					-- doSummonNextPokemon(npc)
					-- return false
				-- end
				if isNpcSummon(cid) then
					local master = getCreatureMaster(cid)
					doSendMagicEffect(getThingPos(cid), getPlayerStorageValue(cid, 10000))
					doCreatureSay(master, getPlayerStorageValue(cid, 10001), 1)
					doRemoveCreature(cid)
				return false
				end
				doKillWildPoke(attacker, cid)
				return false
				end
			   return false
			end
		end
	end
	
	------------------------------------POTIONS-------------------------------------------
	if(combat == 128 or combat == 1) then -- ataque basico uissu: tirei efetividade de ataque básico!
			if isSummon(attacker) then
				if getPlayerStorageValue(attacker, 374896) == 1 then -- agility,strafe,etc
					if getPlayerStorageValue(attacker, 3748961) < os.time() then
						setPlayerStorageValue(attacker, 3748961, os.time() + 1)
						addEvent(docastspell,750,attacker, "melee")
						addEvent(docastspell,1500,attacker, "melee")
					end
				end
			end
			
		   doSendMagicEffect(getThingPos(cid), 3)
		   local name = getCreatureName(attacker)
		   if not pokes[name] and isCreature(attacker) then
				print(name..' nao encontrado! (statschange melee)')
				if isSummon(cid) then
					print(' quando atacando '.. getCreatureName(getCreatureMaster(cid)))
				end
		   end
			
		   local lvla, lvlw, offa = 1, 0, 1
		   if isSummon(attacker) then
				lvla = getPlayerLevel(getCreatureMaster(attacker))/2
		   end
		   if isWild(attacker) then
				lvla = pokes[name].level
				lvlw = pokes[name].wildLvl
		   end
		   if isCreature(attacker) then
				offa = getAttack(attacker) or pokes[name].attack
		   end
		   
		   local forma = (offa * math.random(4,5) * lvla) + lvlw
		   if forma then value = -math.random(forma * 0.9, forma * 1.1) value = math.ceil(value/2) end -- buff ataque system (depois nerf, rs)
		   
		   
			local specialmelee = {
			["Shiny Tentacruel"] = {POISONDAMAGE, 14},
			["Tentacruel"] = {POISONDAMAGE, 14},
			["Gardevoir"] = {FAIRYDAMAGE, 38},
			["Shiny Gardevoir"] = {FAIRYDAMAGE, 38},
			["Lanturn"] = {WATERDAMAGE, 2},
			["Shiny Lanturn"] = {WATERDAMAGE, 2},
			["Venomoth"] = {BUGDAMAGE, 22},
			["Shiny Venomoth"] = {BUGDAMAGE, 22},
			["Flygon"] = {GROUNDDAMAGE, 22},
			["Shiny Flygon"] = {DRAGONDAMAGE, 22},
			["Shiny Magneton"] = {ELECTRICDAMAGE, 38},
			["Magneton"] = {ELECTRICDAMAGE, 38}, 
			["Magnezone"] = {ELECTRICDAMAGE, 38},
			["Shiny Alakazam"] = {PSYCHICDAMAGE, 38},
			["Alakazam"] = {PSYCHICDAMAGE, 38},
			["Abra"] = {PSYCHICDAMAGE, 38}, 
			["Kadabra"] = {PSYCHICDAMAGE, 38}, 
			["Gastly"] = {GHOSTDAMAGE, 38},
			["Haunter"] = {GHOSTDAMAGE, 38}
			}
			
			if specialmelee[getCreatureName(attacker)] then
				value = math.floor(value / 2)
				combat = specialmelee[getCreatureName(attacker)][1]
				raceCombat = typeTable[getElementByCombat(combat)]
				value = doEffectiveDamage(cid, value, combat, attacker)
				doSendDistanceShoot(getThingPosWithDebug(attacker), getThingPosWithDebug(cid), specialmelee[getCreatureName(attacker)][2])
			end
			
		   if isSummon(cid) then
			local master = getCreatureMaster(cid)
			local heldy = getItemAttribute(getPlayerSlotItem(master, 8).uid, "yHeldItem")
			if heldy then
				if heldy:find("GHOST") then
					value = 0
				end
			end
			end
			if getCreatureCondition(cid, CONDITION_INVISIBLE) then value = 0 end
		   if pokes[getCreatureName(cid)].type == 'ghost' or pokes[getCreatureName(cid)].type2 == 'ghost' then -- ataque básico não acertar ghosts
			  value = 0
		   end
		   if value == 0 then doCastPassive(cid) return false end
	else -- magia
		--if isGod(getCreatureMaster(attacker)) then doSendMsg(getCreatureMaster(attacker), value) end
		value = doEffectiveDamage(cid, value, combat, attacker)
		if isInArray(specialabilities["levitate"], getCreatureName(cid)) and combat == 3000 then -- levitate
			if isSummon(cid) and isInDuel(getCreatureMaster(cid)) then
				value = value / 2
			elseif not isSummon(attacker) and isConditionImune(attacker) then
				value = value / 1.5
			else
				value = 0
			end
		end
		if getCreatureCondition(cid, CONDITION_INVISIBLE) then value = 0 end
		if value == 0 then
			doCastPassive(cid)
			return false
		else
			local level = 0
			if isSummon(attacker) then
				local master = getCreatureMaster(attacker)
				level = getPlayerLevel(getCreatureMaster(attacker))
			elseif isWild(attacker) then
				if pokes[getCreatureName(attacker)] then
					level = pokes[getCreatureName(attacker)].wildLvl
				else
					print("> ERROR: player\statsChange.lua -> attempt to index field '?' (a nil value): ".. getCreatureName(attacker))
				end
			end
			if getPlayerStorageValue(attacker, 38323) > 0 then
				level = getPlayerStorageValue(attacker, 38325)
			end
			if isSummon(attacker) then
				value = value * (getSpecialAttack(attacker)) * (level / 100) + math.random(1, 50)
			else
				value = value * (getSpecialAttack(attacker))
			end
		end
	end
		
		value = value / (getDefense(cid)) -- dano dividido pela def (acho que é a melhor forma)

		
		local myBoostD = 0
		if getPlayerStorageValue(cid, towerMonsterStorage) > 0 then
			myBoostD = getPlayerStorageValue(cid, towerMonsterStorage)
		elseif isSummon(cid) then 
			myBoostD = getPokemonBoost(cid)
		elseif isWild(cid) then
			if pokes[getCreatureName(cid)] then
				myBoostD = math.floor(pokes[getCreatureName(cid)].wildLvl / 10)
			end
		end
		local myBoostA = 0
		if getPlayerStorageValue(attacker, towerMonsterStorage) > 0 then
			myBoostA = getPlayerStorageValue(attacker, towerMonsterStorage)
		elseif isSummon(attacker) then 
			myBoostA = getPokemonBoost(attacker)
		elseif isWild(attacker) then
			if pokes[getCreatureName(attacker)] then
				myBoostA = math.floor(pokes[getCreatureName(attacker)].wildLvl / 10)
			end
		end
		
		local boost_def = (math.min(50, myBoostD) * 0.50 + math.max(0, myBoostD - 50) * 0.33) / 100
		local boost_attk = (math.min(50, myBoostA) * 0.50 + math.max(0, myBoostA - 50) * 0.33) / 100
		-- if isGod(getCreatureMaster(attacker)) then
			--doSendMsg(getCreatureMaster(attacker), "Value before: ".. value .." myBoostA: ".. myBoostA .." myBoostD: ".. myBoostD .." boost_def: ".. boost_def .." boost_attk: ".. boost_attk)
		-- end
		-------- boost system
		value = (value) + (boost_def * (value * -1))
		value = (value - getMasterLevel(attacker)) - (boost_attk * (value * -1))
		-------- boost system
		-- if isGod(getCreatureMaster(attacker)) then
			--doSendMsg(getCreatureMaster(attacker), "Value after: ".. value .." myBoostA: ".. myBoostA .." myBoostD: ".. myBoostD .." boost_def: ".. boost_def .." boost_attk: ".. boost_attk)
		-- end
		
		value = math.ceil(value * -1)
		if value >= getCreatureHealth(cid) then value = getCreatureHealth(cid) end
		
		if value < 0 then 
		   value = value * -1
		end
		
		if isSummon(attacker) then
			if #getCreatureSummons(getCreatureMaster(attacker)) > 1 then -- tem shredder / mais de um summon
				value = math.ceil(value / #getCreatureSummons(getCreatureMaster(attacker)) * 1.25)
			end
		end
		
		if xattack then
			value = math.floor(value * xattackValue)
		end
		
		if critical then -- X-Critical system
		    value = math.floor(value * (1 + criticalValue))
			if getPlayerStorageValue(cid, 9658783) ~= 1 then
				doSendAnimatedText(getThingPos(cid), (convertToString(value) == 0 and "" or convertToString(value) .." STK"), COLOR_PINK-3)
			else
				if isInArray(specialabilities["mold breaker"], getCreatureName(attacker)) then
					doSendAnimatedText(getThingPos(cid), (convertToString(value) == 0 and "" or convertToString(value).." STK"), COLOR_PURPLE+1)
				end
			end
			--addEvent(doSendAnimatedText, 100, getThingPos(cid), "CRITICAL!", COLOR_BURN)
		else
			if getPlayerStorageValue(cid, 9658783) ~= 1 then
				doSendAnimatedText(getThingPos(cid), (convertToString(value) == 0 and "" or convertToString(value)), raceCombat.color)
			else
				if isInArray(specialabilities["mold breaker"], getCreatureName(attacker)) then
					doSendAnimatedText(getThingPos(cid), (convertToString(value) == 0 and "" or convertToString(value) .." MB"), COLOR_PURPLE+1)
				end	
			end
		end
		
		if vampiric then -- X-Vampiric
			local valueToHeal = math.floor(value * vampiricValue / 200)
			doCreatureAddHealth(attacker, valueToHeal)
			local hpToMax = getCreatureMaxHealth(attacker) - getCreatureHealth(attacker)
			local hpToShow = math.min(valueToHeal, hpToMax)
			doSendAnimatedText(getThingPos(attacker), (convertToString(hpToShow) == 0 and "" or ("+".. convertToString(hpToShow))), COLOR_BURN)
		end
			
		if returnDamage then
			local valueToReturn = math.ceil(value * (returnDamageValue / 100))
			if (isConditionImune(attacker) and isWild(attacker)) and (not string.find(getCreatureName(attacker), "Elder") and getCreatureName(attacker) ~= "Iron Steelix") then valueToReturn = math.ceil(valueToReturn/3) end -- lendários recebem dano reduzido
			if isSummon(attacker) and isInDuel(getCreatureMaster(attacker)) then valueToReturn = math.ceil(valueToReturn/5) end -- summon recebe 5x menos dano de return em duel
			
			if valueToReturn > getCreatureHealth(attacker) then 
				valueToReturn = (getCreatureHealth(attacker) -1)
			end
			
			if valueToReturn > 1 then
				doSendAnimatedText(getThingPos(attacker), (convertToString(valueToReturn) == 0 and "" or convertToString(valueToReturn)), COLOR_TEAL)
				doSendMagicEffect(getThingPos(cid), 135)
				if valueToReturn > getCreatureHealth(attacker) then valueToReturn = getCreatureHealth(attacker)-1 end
				doCreatureAddHealth(attacker, -valueToReturn)
				addPlayerDano(attacker, getCreatureMaster(cid), valueToReturn)
				doMoveInArea2(cid, 1392, check, CRYSTALDAMAGE, -valueToReturn/2, -valueToReturn/2, "Reflect")
			end
		end
		if getPlayerStorageValue(cid, 9658783) == 1 and not isInArray(specialabilities["mold breaker"], getCreatureName(attacker)) then return false end -- novo?
		
		-------- xp por dano
		if isSummon(attacker) and not isSummon(cid) then
			if getPlayerStorageValue(getCreatureMaster(attacker), 23283) ~= -1 then -- self-destruction
				if isConditionImune(cid) then return false end
				addSelfDano(cid, value)
			else
				addPlayerDano(cid, getCreatureMaster(attacker), value)
			end
		end
		-------- xp por dano
		
		local spellName = getPlayerStorageValue(attacker, 21102)
		setPlayerStorageValue(attacker, 21102, -1) -- reseta a spellName do pokemon atacante
		
		if getCreatureName(cid) == "Mega Sableye" then
			local sto = 128328
			
			local function ro(cid)
				if not isCreature(cid) then return true end
				if getCreatureOutfit(cid).lookType == 2478 then
					doSetCreatureOutfit(cid, {lookType = 2177}, -1)
				end
			end
			
			if getPlayerStorageValue(cid, sto) < 0 then
				if math.random(100) <= 30 then
					doSetCreatureOutfit(cid, {lookType = 2478}, -1)
					addEvent(ro,1000,cid)
					setPlayerStorageValue(cid, storages.reflect, 1)
				end
			else
				local pos = getPosfromArea(cid, db1, getPlayerStorageValue(cid, sto))
				local n = 0
				local refSuc = false
				local apos = getThingPosWithDebug(attacker)
				while n < #pos do
					n = n+1
					if apos.x == pos[n].x and apos.y == pos[n].y then
						refSuc = true
						break
					end
				end
				if refSuc and not isConditionImune(attacker) then
					setPlayerStorageValue(cid, storages.reflect, 1)
				else
					value = value * 2
					doSendAnimatedText(getThingPosWithDebug(cid), "FAIL!", COLOR_BURN)
				end
			end
		end
		
		if(isReflect(cid))then -- reflect system igual GBA
		   if spellName ~= -1 then 
			   if not isInArray({"Team Claw", "Team Slice"}, spellName) then
				  doSendMagicEffect(getThingPosWithDebug(cid), 135)
				  doSendAnimatedText(getThingPosWithDebug(cid), (getCreatureName(cid) == "Mega Sableye") and "BOUNCE" or "REFLECT", (getCreatureName(cid) == "Mega Sableye") and COLOR_PURPLE or COLOR_GRASS)
				  -- addEvent(docastspell, 100, cid, spellName, isMega(attacker) and getPlayerStorageValue(attacker, storages.isMega) or getCreatureName(attacker), attacker, getTableMove(isMega(attacker) and getPlayerStorageValue(attacker, storages.isMega) or getCreatureName(attacker), spellName) and getTableMove(isMega(attacker) and getPlayerStorageValue(attacker, storages.isMega) or getCreatureName(attacker), spellName).f or 0)
				  if getCreatureName(cid) == "Wobbuffet" then
					 doRemoveCondition(cid, CONDITION_OUTFIT)    
				  end
				  setPlayerStorageValue(cid, 21099, -1)                    --alterado v1.6
				  setPlayerStorageValue(cid, 21100, 1)
				  setPlayerStorageValue(cid, 21101, attacker)
				  if getTableMove(getCreatureName(attacker), spellName) then setPlayerStorageValue(cid, 21103, getTableMove(getCreatureName(attacker), spellName).f) end
				  if getCreatureOutfit(attacker) then
				  setPlayerStorageValue(cid, 21104, getCreatureOutfit(attacker).lookType)
				  end
				  setPlayerStorageValue(cid, 21105, value)
				  if spellName == "Rollout" then
					 doRolloutReflected(cid, doCorrectString(getCreatureName(attacker)))
				  end
				  removeReflect(cid)
				  -- sendOpcodeStatusInfo(cid)
				  return false
			   end
			end
        end
		
		-- if getCreatureName(cid) == "Kangaskhan" and math.random(1, 100) < 25 and isMega(cid) then
		   -- docastspell(cid, "Groundshock", 0, 0)
		-- end
		-- if getCreatureName(cid) == "Blastoise" and math.random(1, 100) < 10 and isMega(cid) and isSummon(cid) then
		   -- docastspell(cid, "Water Passive", 0, 0)
		-- end
		-- if getCreatureName(cid) == "Scizor" and math.random(1, 100) < 10 and isMega(cid) then
		   -- docastspell(cid, "Counter Helix", 0, 0)
		-- end
		if isInArray({"Hitmonlee", "Shiny Hitmonlee"}, doCorrectString(getCreatureName(attacker))) and math.random(1, 100) <= 50 then
		-- if getCreatureName(attacker) == "Hitmonlee" and math.random(1, 100) <= 50 then
		   docastspell(attacker, "Demon Kicker", 0, 0)
		end
			
			
	if value >= getCreatureHealth(cid) then
		if isSummon(cid) then
			if isInArray({"Aggron", "Sudowoodo", "Mega Aggron", "Shiny Sudowoodo", "Carracosta", "Dusknoir"}, getCreatureName(cid)) then
			   doCreatureAddHealth(cid, -(getCreatureHealth(cid)-1))
			   docastspell(cid, "Sturdy", "Spirit Tomb")
			   if isSummon(cid) then doSendLifePokeToOTC(getCreatureMaster(cid)) end
			   return false
			end
		end
		-- if isNPCSummon(cid) then
			-- local npc = getNPCMaster(cid)
			-- doSendMagicEffect(getThingPos(cid), 376)
			-- doRemoveCreature(cid)
			-- setPlayerStorageValue(npc, stor_npcteam, getPlayerStorageValue(npc, stor_npcteam)-1)
			-- doSummonNextPokemon(npc)
			-- return false
		-- end
		if isNpcSummon(cid) then
			local master = getCreatureMaster(cid)
			doSendMagicEffect(getThingPos(cid), getPlayerStorageValue(cid, 10000))
			doCreatureSay(master, getPlayerStorageValue(cid, 10001), 1)
			doRemoveCreature(cid)
		return false
		end
		if isSummon(attacker) then
			checkDungeon(getCreatureMaster(attacker), cid)
		end
		-- if isWild(cid) and isInArea(getThingPos(cid), towerTopCorner, towerBottomCorner) then
			-- doRemoveCreature(cid)
			-- towerSendUpdate()
		-- end
		-- if isWild(cid) and isInArea(getThingPos(cid), towerTopBossCorner, towerBottomBossCorner) then
			-- doRemoveCreature(cid)
			-- local mid = getCreatureMaster(attacker)
			-- if mid then
				-- doBroadcastMessage(getCreatureName(mid).." defeated the feral boss.")
				-- doSendMsg(mid, "You've defeated the feral boss and earned ".. towerPoints[getGlobalStorageValue(towerGlobalStorage)].points .." points.")
				-- if getPlayerStorageValue(mid, towerPointsStorage) < 0 then setPlayerStorageValue(mid, towerPointsStorage, 0) end
				-- setPlayerStorageValue(mid, towerPointsStorage, getPlayerStorageValue(mid, towerPointsStorage) + towerPoints[getGlobalStorageValue(towerGlobalStorage)].points) 
				-- doSendMsg(mid, "You have now ".. getPlayerStorageValue(mid, towerPointsStorage) .." points.")
				-- addExpByStages(mid, towerPoints[getGlobalStorageValue(towerGlobalStorage)].exp)
				-- doTeleportThing(mid, {x=3979,y=4097,z=6})
			-- end
		-- end
		doKillWildPoke(attacker, cid)
		return false
	end
	-- if isSummon(cid) then
		    -- local currentHpPercent, textColor = math.round(getCreatureHealth(getCreatureSummons(cid)[1]) / getCreatureMaxHealth(getCreatureSummons(cid)[1]) * 100), 2
    -- if (currentHpPercent >= 80) then
        -- textColor = 0
    -- elseif (currentHpPercent >= 40) then
        -- textColor = 1
    -- end

    -- setBallPokemonLastHpPercent(getPlayerSlotItem(getCreatureMaster(cid), 8).uid, currentHpPercent)
    -- doPlayerSendPokemonWindowUpdatePokemonIcon(getCreatureMaster(cid), getFastcallNumber(ball), textColor, tostring(currentHpPercent) .. "%")
	-- end
	    --------------Passiva Lifesteal Clobat------------
		  if isInArray({"crobat", "shiny crobat"}, getCreatureName(attacker):lower())and (combat == 128 or combat == 1) and spellNameFromAttacker == -1 then                    
		    doCreatureAddHealth(attacker, math.floor(value))
		    doSendAnimatedText(getThingPos(attacker), "+ "..math.floor(convertToString(value)), 30)
	      end
	    --------------------------------------------
	doCastPassive(cid)
	doCreatureAddHealth(cid, -value)
	
	if isSummon(cid) then
		if getPlayerStorageValue(cid, 173) >= 1 then
			setPlayerStorageValue(cid, 173, -1)  --alterado v1.6
			doSendAnimatedText(getThingPos(cid), "LOST HEAL", 144)
		end
	end
		
	if isWild(cid) and isInArray({"Darkrai", "Moltres", "Articuno", "Zapdos", "Entei", "Suicune", "Raikou", "Evil Dusknoir", "Mewtwo", "Lugia", "Ho-oh", "Ho-Oh", "Keldeo", "Volcanion"}, getCreatureName(cid)) then
		if getExpByMoreDano(cid) ~= "" then
			local killers = string.explode(tostring(getExpByMoreDano(cid)), "|")
			if killers ~= nil then
				for i = 1, #killers do
					local player = getPlayerByName(string.explode(killers[i], "/")[1])
					doSendPlayerExtendedOpcode(player, 193, getCreatureName(cid).. ':'.. math.ceil(getCreatureHealth(cid) / getCreatureMaxHealth(cid) * 10000) / 100 ..':'..tostring(getExpByMoreDano(cid)))
					-- print(getExpByMoreDano(cid))
				end
			end
		end
	end
	
	-- if not isSummon(cid) and not isMega(cid) and not isInArea(getThingPos(cid), towerTopCorner, towerBottomCorner) then
	   -- checkChenceToMega(cid)
	-- end
	
	if isSummon(cid) then
		doSendLifePokeToOTC(getCreatureMaster(cid))
	end
end	
	return false
end

function getMasterLevel(cid)
	if isSummon(cid) then
	   return getPlayerLevel(getCreatureMaster(cid))
	end
	return 0
end
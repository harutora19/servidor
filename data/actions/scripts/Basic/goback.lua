local EFFECTS = {
	--[OutfitID] = {Effect}
	["Magmar"] = 35,   
	["Shiny Magmar"] = 35,
    ["Shiny Magmortar"] = 35,
    ["Shiny Electivire"] = 48,
    ["Magmortar"] = 35,
    ["Electivire"] = 48,	
	["Jynx"] = 41,          --alterado v1.5
	["Shiny Jynx"] = 41, 
    ["Piloswine"] = 41,  --alterado v1.8
    ["Swinub"] = 41,   
}

function onUse(cid, item, frompos, item2, topos)

local effect = 376
if exhaustion.get(cid, 6666) and exhaustion.get(cid, 6666) > 0 then return true end

if isRiderOrFlyOrSurf(cid) then return true end

if getPlayerStorageValue(cid, 17000) >= 1 or getPlayerStorageValue(cid, 17001) >= 1 or getPlayerStorageValue(cid, 63215) >= 1 
or getPlayerStorageValue(cid, 75846) >= 1 or getPlayerStorageValue(cid, 5700) >= 1  then    --alterado v1.9 <<
   return true                                                                                                                        
end

	if item.uid ~= getPlayerSlotItem(cid, CONST_SLOT_FEET).uid then
		doPlayerSendCancel(cid, "Você precisa colocar a pokéball no slot principal!")
	return TRUE
	end

local ballName = getItemAttribute(item.uid, "poke")
local staffitem = getItemAttribute(item.uid, "staffitem")
if staffitem then
	if getCreatureName(cid) ~= staffitem then
		doSendMsg(cid, "This is a staff member's pokemon. You can't use it.")
		doRemoveItem(item.uid, 1)
		
		local dir = "data/logs/staffballs.log"
		local arq = io.open(dir, "a+")
		local txt = arq:read("*all")
		arq:close()
		local arq = io.open(dir, "w")
		arq:write(""..txt.."\n[".. os.date("%x %X] ") .. getCreatureName(cid) .." -> ".. staffitem .."'s ".. ballName .."")
		arq:close()
		return true
	end
end


if type(getPlayerStorageValue(cid, 6667)) ~= "number" then setPlayerStorageValue(cid, 6667, 1) end
if getPlayerStorageValue(cid, 6667) > os.time() and getPlayerStorageValue(cid, 6668) == ballName then return true end
setPlayerStorageValue(cid, 6667, os.time() + 1)
setPlayerStorageValue(cid, 6668, ballName)

local btype = getPokeballType(item.itemid)
local pokeBallName = getItemAttribute(item.uid, "ball")
local boost,heldx,heldy = getItemAttribute(item.uid, "boost") or 0,getItemAttribute(item.uid, "xHeldItem") or "none",getItemAttribute(item.uid, "yHeldItem") or "none"
local usando = pokeballs[btype].use

	local fixBallName = {
	["ultra ball"] = "ultra",
	["poke ball"] = "poke",
	["pokeball"] = "poke",
	["super ball"] = "super",
	["great ball"] = "great",
	}


	local t = pokeballs[pokeBallName]

	if not t then
		if fixBallName[pokeBallName] then
			pokeBallName = fixBallName[pokeBallName]
			doItemSetAttribute(item.uid, "ball", pokeBallName)
		else
			print("weird pokeball name: ".. pokeBallName)
		end
	else
		effect = t.effect
	end
	
-- unLock(item.uid) --alterado v1.8

if (item.itemid == usando or #getCreatureSummons(cid) > 0) then                           
	local summon = getCreatureSummons(cid)[1]
	if getPlayerStorageValue(summon, 9658783) == 1 and isInArray({"Aggron", "Sudowoodo", "Mega Aggron"}, getCreatureName(summon)) then
	   doKillWildPoke(getCreatureSummons(cid)[1], getCreatureSummons(cid)[1])
	   doPlayerSendCancel(cid, "This pokemon is fainted.")
	   if isInDuel(cid) then
	      doRemoveCountPokemon(cid)
	   end
	   return true
	end

	if getPlayerStorageValue(cid, 990) == 1 then -- GYM
		doPlayerSendCancel(cid, "You can't return your pokemon during gym battles.")
	return true
	end
	if #getCreatureSummons(cid) > 1 and getPlayerStorageValue(cid, 212124) <= 0 then     --alterado v1.6
       if getPlayerStorageValue(cid, 637501) == -2 or getPlayerStorageValue(cid, 637501) >= 1 then  
          BackTeam(cid)       
       end
    end   
    if #getCreatureSummons(cid) == 2 and getPlayerStorageValue(cid, 212124) >= 1 then
       doPlayerSendCancel(cid, "You can't do that while is controling a mind")
       return true     --alterado v1.5
    end
    if #getCreatureSummons(cid) <= 0 then
		if isInArray(pokeballs[btype].all, item.itemid) then
			doTransformItem(item.uid, pokeballs[btype].off)
			doItemSetAttribute(item.uid, "hp", 0)
			doPlayerSendCancel(cid, "This pokemon is fainted.")
		    return true
		end
	end
	
	

    local cd = getCD(item.uid, "blink", 30)
    if cd > 0 then
       setCD(item.uid, "blink", 0)
    end
    
	local z = getCreatureSummons(cid)[1]
	
	if getCreatureCondition(z, CONDITION_INVISIBLE) and not isGhostPokemon(z) then
	   return true
	end
	
	if isInDuel(cid) then
	   doRemoveCountPokemon(cid)
	end
	
	checkGiveUp(cid)
	
	resetStatusInfo(cid)
	doReturnPokemon(cid, z, item, effect)
	doPlayerSendCancel(cid, '12//,hide') --alterado v1.7
	doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_DITTO_MEMORY, "sair") -- ditto memory system
	doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_USETM, "close")

elseif item.itemid == pokeballs[btype].on then

	-- rever a seguranca do pokemon ser sumanado com 0 de hp

	local pokemon = getItemAttribute(item.uid, "poke")
	
	if not pokes[pokemon] then
	return true
	end

----------------------- Sistema de nao poder carregar mais que 3 pokes lvl baixo e + q 1 poke de lvl medio/alto ---------------------------------
if not isInArray({5, 6}, getPlayerGroupId(cid)) then
   local balls = getPokeballsInContainer(getPlayerSlotItem(cid, 3).uid)
   local low = {}
   local lowPokes = {"Rattata", "Caterpie", "Weedle", "Oddish", "Pidgey", "Paras", "Poliwag", "Bellsprout", "Magikarp", "Hoppip", "Sunkern"}
   if #balls >= 2 then
      for _, uid in ipairs(balls) do
          local nome = getItemAttribute(uid, "poke")
          if not isInArray(lowPokes, pokemon) and nome == pokemon and not isGod(cid) then
             return doPlayerSendTextMessage(cid, 27, "Sorry, but you can't carry two pokemons equals!")
          else
             if nome == pokemon then
                table.insert(low, nome)
             end
          end
      end
   end
if #low >= 2 then
   return doPlayerSendTextMessage(cid, 27, "Sorry, but you can't carry more than three pokemons equals of low level!")
end   
end
---------------------------------------------------------------------------------------------------------------------------------------------------

	local x = pokes[pokemon]
	local boost = getItemAttribute(item.uid, "boost") or 0
	
	---------------------------- Sistema pokes de clan --------------------------------------
	-- local shinysClan = {	
	-- ["Shiny Dragonite"] = {4, "Wingeon"},
	-- ["Shiny Torkoal"] = {1, "Volcanic"},
	-- ["Shiny Swampert"] = {2, "Seavel"}, 
	-- ["Shiny Manectric"] = {9, "Raibolt"},
	-- ["Shiny Grumpig"] = {7, "Psycraft"},           
	-- ["Shiny Flygon"] = {3, "Orebound"},
	-- ["Shiny Sceptile"] = {8, "Naturia"},
	-- ["Shiny Ursaring"] = {5, "Malefic"},
	-- ["Shiny Gallade"] = {6, "Gardestrike"},
	-- ["Shiny Bronzong"] = {10, "Ironhard"},
	-- }
		
	if (getPlayerLevel(cid) < (x.level+boost) and not isInArray(box5pks, pokemon) and getPlayerGroupId(cid) < 4) then
	   doPlayerSendCancel(cid, "You need level "..(x.level+boost).." to use this pokemon.")
	   return true
	end

   -- local master = getCreatureMaster(cid)
   -- local clan = getPlayerClan(master):lower()
   -- local type1,type2 = megasConf[megaName].type, megasConf[megaName].type2
   -- if not (isInArray(clanTypes[clan], type1) or isInArray(clanTypes[clan], type2) or isGod(master)) then
   -- doPlayerSendCancel(master, "You can't control this mega evolution as ".. clan ..".")
   -- return false
   -- end


	-- if shinysClan[pokemon] and isInDuel(cid) then  -- Player não poder usar shiny no duel, mas fora dele.
	-- if shinysClan[pokemon] and getPlayerGroupId(cid) < 4 then  --alterado v1.9 \/
	   -- if getPlayerClanNum(cid) ~= shinysClan[pokemon][1] then
	      -- doPlayerSendCancel(cid, "You need be a member of the clan "..shinysClan[pokemon][2].." to use this pokemon!")
	      -- return true   
       -- elseif getPlayerClanRank(cid) ~= 5 then
          -- doPlayerSendCancel(cid, "You need be atleast rank 5 to use this pokemon!")
	      -- return true
       -- end
    -- end
    --------------------------------------------------------------------------------------
	local isNicked, nick, pokemonRealName = false, pokemon, pokemon
	
	if getItemAttribute(item.uid, "copyName") then -- ditto system
        pokemon = getItemAttribute(item.uid, "copyName")
		pokemonRealName = getItemAttribute(item.uid, "poke")
    end
	
	-- if getItemAttribute(item.uid, "nick") and getItemAttribute(item.uid, "nick") ~= "" then
		-- isNicked = true nick = getItemAttribute(item.uid, "nick")
		-- doCreateMonsterNick(cid, pokemon, getItemAttribute(item.uid, "nick"), getThingPos(cid), true)
	-- else 
	    -- doCreateMonsterNick(cid, pokemon, retireShinyName(pokemonRealName), getThingPos(cid), true) -- chama o pokemon com nome verdadeiro, mas se for shiny ja tera seu nome alterado
	-- end
	doSummonMonster(cid, pokemon)
	

	local pk = getCreatureSummons(cid)[1]
	
	setMoveSummon(cid, true)
	if not isCreature(pk) then return true end
    -- setCooldownLoop(pk, cid, item.uid)
	------------------------passiva hitmonchan------------------------------
	if isSummon(pk) then                                                  --alterado v1.8 \/
       if pokemon == "Shiny Hitmonchan" or pokemon == "Hitmonchan" then
          if not getItemAttribute(item.uid, "hands") then
             doSetItemAttribute(item.uid, "hands", 0)
          end
          local hands = getItemAttribute(item.uid, "hands")
          doSetCreatureOutfit(pk, {lookType = hitmonchans[pokemon][hands].out}, -1)
       end
    end
	-------------------------------------------------------------------------
	local function doMagnetField(cid)
	if not isCreature(cid) then return true end
		if isCreature(getCreatureTarget(cid)) then
			docastspell(cid, "Magnet Field")
		end
		return addEvent(doMagnetField, math.random(2,4) * 1000, cid)
	end
	if pokemon == "Magnezone" then
		doMagnetField(pk)
	end
    ---------movement magmar, jynx-------------
    if EFFECTS[getCreatureName(pk)] then             
       markPosEff(pk, getThingPos(pk))
       sendMovementEffect(pk, EFFECTS[getCreatureName(pk)], getThingPos(pk))  
    end
    --------------------------------------------------------------------------      

	doCreatureSetLookDir(pk, 2)
	
	-- addEvent(doSendCreatureEffect, 1000, pk, 13)
	-- doSendCreatureEffect(cid, 13)
	
	if string.find(pokemon, "Mega ") then
		local pos = getThingPosWithDebug(pk)
		pos.x = pos.x + 1
		pos.y = pos.y +1
		doSendMagicEffect(pos, 574)
	end
	-- doPlayerSendPokemonWindowUpdatePokemonIcon(cid, getFastcallNumber(ball.uid), 3, __L(cid, "USE"))
	-- if getPlayerWatchingTV(cid) then return true end
	adjustStatus(pk, item.uid, true, true, true)
	-- doRegenerateWithY(getCreatureMaster(pk), pk)
	-- doCureWithY(getCreatureMaster(pk), pk)

	doTransformItem(item.uid, pokeballs[btype].use)

	local mgo = gobackmsgs[math.random(1, #gobackmsgs)].go:gsub("doka", (isNicked and nick or retireShinyName(pokemon)))
	doCreatureSay(cid, mgo, TALKTYPE_ORANGE_1)
    
	doSendMagicEffect(getCreaturePosition(pk), effect)
	doPlayerSendCancel(cid, '12//,show')
	doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_BATTLE_POKEMON, tostring(pk))
	-- setPokemonGhost(pk)
	
		if getCreatureName(pk):find("Smeargle") then
			local id = getItemAttribute(getPlayerSlotItem(cid, 8).uid, "SmeargleID")
		  	setPlayerStorageValue(pk, storages.SmeargleID, "Smeargle " .. id) 
		end
	-- sendOpcodeStatusInfo(pk)
	-- ADDON SYSTEM
		local pk = getCreatureSummons(cid)[1]
		local pb = getPlayerSlotItem(cid, 8).uid
		local look = getAddonValue(pb, "addon")

		if look > 0 then
			doSetCreatureOutfit(pk, {lookType = look}, -1)
		end
	
else

    doPlayerSendCancel(cid, "This pokemon is fainted.")

end
	
	-- otclient life
		doSendLifePokeToOTC(cid)
		doUpdateMoves(cid)
	-- otclient life
	
return true
end

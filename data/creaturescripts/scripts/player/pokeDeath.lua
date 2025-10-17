function matou(cid, target)
if isSummon(target) and isPlayer(getCreatureMaster(target)) then
 
 	if isInDuel(getCreatureMaster(target)) then
	   doRemoveCountPokemon(getCreatureMaster(target))
	end
	doPlayerSendCancel(getCreatureMaster(target), '12//,hide') --alterado v1.7
	doUpdateMoves(getCreatureMaster(target))
	doKillPlayerPokemon(target)
	doRemoveCreature(target)
	doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_POKEMON_HEALTH, "0|0")

elseif isWild(target) then

if getPlayerStorageValue(target, 637500) >= 1 then -- sherdder team
	doRemoveCreature(target)
	return true
end


local nameDeath = doCorrectString(getCreatureName(target))
local pos = getThingPos(target)
local corpseID = getPokemonCorpse(nameDeath)
local corpse = false
	if (corpseID and corpseID > 0) then 
		corpse = doCreateItem(corpseID, 1, pos) 
	end
	-- if getPlayerStorageValue(getCreatureMaster(target), 232323) == 1 then
		-- if pokes[nameDeath] then
			-- corpse = doCreateItem(11861, 1, pos) 
		-- end
	-- end
	
	if isSummon(cid) then
		checkDirias(cid, nameDeath)
    end	   
	if corpse then
	  doItemSetAttribute(corpse, "pokeName", "fainted " .. nameDeath:lower())
      doDecayItem(corpse)
	  local name = getCreatureName(getCreatureMaster(cid))
	  doCorpseAddLoot(getCreatureName(target), corpse, getCreatureMaster(cid), target)
	  -- checkDungeon(cid, getCreatureName(target))
	else
		local nocorpseok = {"beg shiny tentacruel", "beg primeape", "beg champion primeape", "beg heracross", "beg machoke", "beg machamp", "beg poliwrath", "fighter blaziken", 'fire barricade', 'shadow', 'shiny vaporeon', 'shiny flareon', 'shiny jolteon', 'shiny fearow', 'shiny golem', 'shiny hypno', 'shiny nidoking', 'shiny hitmontop'}
		if not isInArray(nocorpseok, nameDeath:lower()) then
			print("No corpse on ".. nameDeath:lower())
		-- checkDungeon(cid, target)
			-- checkDungeon(cid, nameDeath:lower())
		end
	end
      doRemoveCreature(target)
end 



return false
end

local bosses = {
["articuno"] = {
loot = {{11454, 5}, {12244, 3}, {15644, 5}},
winner = {{15646, 1}, {12149, 1}, {12618, 1}},
expwinner = 100000,
storage = 11680,
},
["zapdos"] = {
loot = {{11444, 5}, {12244, 3}, {15644, 5}},
winner = {{15646, 1}, {12150, 1}, {12618, 1}},
expwinner = 100000,
storage = 11678,
},
["moltres"] = {
loot = {{11447, 5}, {12244, 3}, {15644, 5}},
winner = {{15646, 1}, {12151, 1}, {12618, 1}},
expwinner = 100000,
storage = 11679,
},

["mewtwo"] = {
loot = {{11452, 5}, {12244, 3}, {15644, 10}},
winner = {{15646, 1}, {12618, 2}},
expwinner = 1000000,
storage = 11684,
},

["evil dusknoir"] = {
loot = {{11452, 5}, {12244, 3}, {15644, 10}, {12230, 1}}, -- "rare candy"
winner = {{15646, 1}, {12618, 2}},
expwinner = 1000000,
storage = 11686,
},


["ho-oh"] = {
loot = {{11447, 5}, {12244, 3}, {15644, 10}},
winner = {{15646, 1}, {12618, 2}},
expwinner = 1000000,
storage = 11687,
},

["lugia"] = {
loot = {{11450, 5}, {12244, 3}, {15644, 10}},
winner = {{15646, 1}, {12618, 2}},
expwinner = 1000000,
storage = 11685,
},

["suicune"] = {
loot = {{11442, 5}, {12244, 3}, {15644, 5}},
winner = {{15646, 1}, {12618, 1}},
expwinner = 500000,
storage = 11681,
},
["raikou"] = {
loot = {{11444, 5}, {12244, 3}, {15644, 5}},
winner = {{15646, 1}, {12618, 1}},
expwinner = 500000,
storage = 11682,
},
["entei"] = {
loot = {{11447, 5}, {12244, 3}, {15644, 5}},
winner = {{15646, 1}, {12618, 1}},
expwinner = 500000,
storage = 11683,
},

}

function doBossReward(cid, bossname, winner)
	if not isPlayer(cid) then return true end
	local str, b = "", bosses[string.lower(bossname)]
	if not b then return true end
	
	if getCreatureName(cid) == winner then
		for l2 =1,#b.winner do
			local c = math.random(1,b.winner[l2][2])
			doPlayerAddItem(cid, b.winner[l2][1], c)
			str = str .. (str == "" and c .." ".. getItemNameById(b.winner[l2][1]) or ", "..c .." ".. getItemNameById(b.winner[l2][1]))
		end
		addExpByStages(cid, b.expwinner, true)
		setGlobalStorageValue(b.storage, os.time()+3600)
		
		local dir = "data/logs/boss kill.log"
			local arq = io.open(dir, "a+")
			local txt = arq:read("*all")
			arq:close()
			local arq = io.open(dir, "w")
			arq:write(""..txt.."\n[".. os.date("%x %X] ") .. getCreatureName(cid) .." -> ".. bossname)
			arq:close()
			
		doBroadcastMessage(winner.." defeated ".. bossname .." and received ".. str ..".")
	else
		for l=1,#b.loot do
			local c = math.random(1,b.loot[l][2])
			doPlayerAddItem(cid, b.loot[l][1], c)
			str = str .. (str == "" and c .." ".. getItemNameById(b.loot[l][1]) or ", "..c .." ".. getItemNameById(b.loot[l][1]))
		end
	end
	
	doSendMsg(cid, "[BOSS REWARD] ".. bossname ..": "..str..".")
	return true
end

function doSpawnCharm(cid, target)
    if getPlayerStorageValue(cid, 17226) and getPlayerStorageValue(cid, 17226) > os.time() and not getCreatureName(target):find("Shiny ") then
		if math.random(1, 10000) <= 300 then
			local name = "Shiny " .. getCreatureName(getCreatureMaster(target))
			-- addEvent(doCreateMonsterNick, 5000, cid, name, retireShinyName(name), getThingPos(cid), false)
			addEvent(doSummonMonster, 5000, cid, name)
			doPlayerSendTextMessage(cid, 20, "[Shiny Charm]: Irá nascer em 5 segundos um Shiny "..getCreatureName(target)..".")
			return true
		end
		local pos = getThingPos(target)
		pos.x = pos.x + 1
		pos.y = pos.y + 1
		doSendMagicEffect(pos, 681)
    end
    return true
end

local phBoss = {'Rhyperior','Magmortar','Electivire','Dusknoir','Milotic','Metagross','Tangrowth','Slaking','Salamence'}

function doSpawnBoss(cid, target)
    if getPlayerStorageValue(cid, 17226) and getPlayerStorageValue(cid, 17226) > os.time() and not isInArray(phBoss, getCreatureName(target)) then
		if isWild(target) and isPhenac(doCorrectString(getCreatureName(target))) then
			if math.random(1, 10000) <= 300 then
				local boss = doSummonCreature(phBoss[math.random(1, #phBoss)], getThingPos(cid))
				adjustWildPoke(boss, 3.5)
				return true
			end
			return true
		end
    end
    return true
end

function doSpawnMega(cid, target)
    if getPlayerStorageValue(cid, 17226) and getPlayerStorageValue(cid, 17226) > os.time() then
		if isWild(target) then
			if math.random(1, 10000) <= 300 then 
				checkChenceToMega(cid, true)
				return true
			end
		return true
		end
    end
    return true
end

local stoneEffect = {
	  ["fire stone"] = 774, -- new
	  ["water stone"] = 775, -- new
	  ["leaf stone"] = 776, -- new
	  ["heart stone"] = 777, -- new
	  ["thunder stone"] = 778,
	  ["venom stone"] = 779,
	  ["enigma stone"] = 780,
	  ["rock stone"] = 781,
	  ["earth stone"] = 782,
	  ["ice stone"] = 783,
	  ["darkness stone"] = 784,
	  ["punch stone"] = 785,
	  ["coccon stone"] = 786,
	  ["metal stone"] = 787,
	  ["ancient stone"] = 788,
	  ["crystal stone"] = 789,
	  ["feather stone"] = 790,
}

function doPlayerAutoLoot(cid, target)
	AutoLoot.Items(cid, getCreaturePosition(target))
	-- AutoLoot.Message(cid)
	
return true
end

function checkDungeon(cid, target)
-- function onKill(cid, target, lastHit)
  local name = getCreatureName(target)
  if (not isSummon(target)) then
    if isPlayer(cid) then
      local value = Dz.getPlayerStorage(cid)
	  -- print(value.state, value.diff, value.mapId, value.roomId)
      if value.state == DzStateBattle then
        local Map = Dz.Diff[value.diff].Maps[value.mapId]
        local Room = Map.rooms[value.roomId]
		if getCreatureName(target) == Room.boss.name then
          Dz.teleportToPrize(value.diff, value.mapId, value.roomId)
		else
          Room.variable.pokemonCount = Room.variable.pokemonCount - 1
          if Room.variable.pokemonCount == 0 then
			table.insert(Room.variable.pokemons, doCreateMonster(Room.boss.name, Room.boss.pos))
          end
		  for _, name in pairs(Room.variable.members) do
		    local player = getPlayerByName(name)
			if isPlayer(player) then
		      doSendPlayerExtendedOpcode(player, Dz.Opcode, json.encode({protocol = "pokemoncount", count = Room.variable.pokemonCount}))
		    end
		  end
		end
      end
	end
    -- doQuestDefeat(cid, name)
    -- if (lastHit) then
      -- RangerClub.onPlayerKill(cid, name)
      --            HalloweenEvent.onPlayerKill(cid, target, lastHit)
      -- AnniversaryEvent.onPlayerKill(cid, target, lastHit)
      --EasterEvent.ThisIsEaster.onPlayerKill(cid, target, lastHit)
      --            ChristmasEvent.onPlayerKill(cid, target, lastHit)
    -- end
  end
  -- return true
-- end
return true
end


function doCheckTaskKill(cid, target)
local continue = true

if isWild(target) then
   for i = 91001, (91000+maxTasks) do
       local sto = getPlayerStorageValue(cid, i)
       if type(sto) == "string" then
          local array = getArrayFromStorage(cid, i)
          if arrayHasContent(array) then
             for e, f in pairs(array) do
                 for a = 1, #f do
                     if tostring(f[a][1]) == getCreatureName(target) and tonumber(f[a][2]) >= 1 then
                        -- if getDamageMapPercent(cid, target) < 0.5 then
                           -- continue = false
                        -- elseif (pokes[getPlayerStorageValue(cid, 854787)] and getCreatureName(getCreatureSummons(cid)[1]) ~= getPlayerStorageValue(cid, 854787)) then
                           -- if npcsTask[tostring(e).."_1"] then
                              -- continue = false             --task clan
                           -- end
                        -- elseif e == "Agatha" and getCreatureName(target) == "Shiny Abra" and not isInRange(getThingPos(target), Agatha.fromPos, Agatha.toPos) then
                           -- continue = false    --alterado v1.9 agatha quest
                        -- end
                        if continue then
                           f[a][2] = f[a][2]-1
                           if f[a][2] == 0 then
                              sendMsgToPlayer(cid, 20, tostring(e)..": Quest Done!")
                           else   
                              sendMsgToPlayer(cid, 20, tostring(e)..": You need to kill more "..f[a][2].." "..f[a][1]..(f[a][2] == 1 and "." or "s."))
                           end
                           setStorageArray(cid, i, array)
                        end
                        continue = true
                     end
                 end
             end
          end
       end
   end
end   
    return true
end

function checkDailyTaskKill(cid, target)
 -- Se for um monstro summon que morreu, ignora
  if getCreatureMaster(target) ~= target then    
    return true
  end

  local _creature_name = getCreatureName(target):lower() -- lembrando que o nome da task é sempre diferente

  local _taskname, _tasktable = task.getTaskTableByTarget(cid, _creature_name) -- funcao retorna duplo parametro  
    
  -- Achievement de matar bosses (configurar em lib/task_kill.lua) 
  local achiev = TABLE_ACHIEVEMENT_BOSS[_creature_name]
  if achiev then
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, 'Parabéns você achou o Pokémon ditto.')
  end

  -- Sistema de Tasks de Monstros
  if not _taskname or not _tasktable then
    return true
  end

  if task.doing(cid, _taskname) then
    if not task.killedNeededCount(cid, _taskname) then
      local kills = task.kills(cid, _taskname)
      task.doSetKills(cid, _taskname, kills + 1)

      local response = {
         WindowName = "modulo",
         PokeName = _taskname,
         PokeInfo = {
         	PokeSprite = _taskname,
         	KillCount = kills + 1 .. " de " .. _tasktable.count,
         },
      }
	  doSendPlayerExtendedOpcode(cid, GameServerOpcodes.PokeKill, json.encode(response))
	  
      if kills + 1 == _tasktable.count then
      doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, 'Parabéns você completou sua missão, colete sua recompensa no painel de missões.')
	  end
      
    end
  end
return true
end

function doPlayerAddMoneyOnKillPoke(cid, target)

	local pokeAtk, pokeDef, pokeSpAtk, pokeVit, pokeAgi = pokes[getCreatureName(target)].attack, pokes[getCreatureName(target)].defense, pokes[getCreatureName(target)].specialattack, pokes[getCreatureName(target)].vitality, pokes[getCreatureName(target)].agility
	local playerBalance = getPlayerBalance(cid)
	if isPlayer(cid) and isWild(target) then
		doPlayerSetBalance(cid, playerBalance + (pokeAtk + pokeDef + pokeSpAtk + pokeVit + pokeAgi))
		-- doPlayerAddMoney(cid, (pokeAtk + pokeDef + pokeSpAtk + pokeVit + pokeAgi))
		doPlayerSendTextMessage(cid, 27, "Parabéns você derrotou um " .. getCreatureName(target) .. " e ganhou " .. (pokeAtk + pokeDef + pokeSpAtk + pokeVit + pokeAgi) .. " em gold, use o comando !saque e retire.")
		return true
	end	
		
return true
end


function doCorpseAddLoot(name, item, cid, target, charm) -- essa func jà¸£à¸ vai ajudar em um held, luck.
if cid == target then 
doItemSetAttribute(item, "corpseowner", "asÃ§dlkasÃ§ldkaÃ§slkdÃ§askdÃ§aslkdÃ§lsakdÃ§kaslÃ§")
return true 
end -- selfdestruct
local lootList = getMonsterLootList(name)
local rareItems = {
12581, -- old amber
15644, -- mighty token
12338, -- bag box
}
local megaStones = {15131, 15134, 15135, 15133, 15136, 15780, 15781, 15782, 15783, 15784, 15785, 15786, 15787, 15788, 15789, 15790, 15791, 15792, 15793, 15794, 15178,
15174, 15177, 15140, 15139, 15141, 15179, 15137}

local logItems = {12581,15131, 15134, 15135, 15133, 15136, 15780, 15781, 15782, 15783, 15784, 15785, 15786, 15787, 15788, 15789, 15790, 15791, 15792, 15793, 15794, 
					15178,15174,15177,15140,15139,15141,15179,15137} -- old amber + mega stones
local logToDo = {}

local isStoneDroped = false
local isRareDroped = false
local isMegaStone = false
name = doCorrectString(name)
local pokeName = name
local pokeNamee = name
local str, vir = "Loot from " .. name .. ": ", 0
local megaID, megaName = "", ""
local lootListNow = {}
local lootListLucky = {}
local lootListCharm = {}
local chanceLucky = 0



	if not isInArea(getThingPos(target), {x=1285, y=472, z=6}, {x=1318, y=489, z=6}) then
		local countVirg = 0
		for i, _ in pairs(lootList) do
			countVirg = countVirg + 1
			local id, count, chance = lootList[i].id, lootList[i].count, lootList[i].chance
			local chanceLucky = 0
			-- if getGlobalStorageValue(73737) > os.time() then
				-- chance = chance * 2
			-- elseif getGlobalStorageValue(73737) < os.time() and getGlobalStorageValue(73737) ~= -1 then
				-- setGlobalStorageValue(73737, -1)
			-- end
			if isPlayer(cid) then
			---- X-Lucky
			local heldx = getItemAttribute(getPlayerSlotItem(cid, 8).uid, "xHeldItem")
			local heldName, heldTier = "",""
				if heldx then
					  heldName, heldTier = string.explode(heldx, "|")[1], string.explode(heldx, "|")[2]
					  if heldName == "X-Lucky" then -- dar mais loot
						chanceLucky = chance * heldLucky[tonumber(heldTier)]
						local percentL, lootCountL = math.random(1, 100000), math.random(1, count)
						if (percentL <= chanceLucky) then
							if isStone(id) then
							   isStoneDroped = true
							   local posCorpse = getThingPos(item)
									 posCorpse.x = posCorpse.x +1
							   doSendMagicEffect(posCorpse, stoneEffect[getItemNameById(id):lower()])
							   posCorpse.y = posCorpse.y +1
							   addEvent(doSendMagicEffect, 2000, posCorpse, 792)
							end
							   local posCorpse = getThingPos(item)
									 posCorpse.x = posCorpse.x +1
									 posCorpse.y = posCorpse.y +1
							if isInArray(rareItems, id) then
							   isRareDroped = true
							   doSendMagicEffect(posCorpse, 791)
							end
							if isInArray(megaStones, id) then
							   isMegaStone = true
							   doSendMagicEffect(posCorpse, 698)
							end
							if isInArray(logItems, id) then
								table.insert(logToDo, "(LUCKY T"..heldTier..") "..getItemNameById(id))
								doSendMagicEffect(posCorpse, 1227)
							end
							 if isContainer(item) then
								doAddContainerItem(item, id, lootCountL)
								table.insert(lootListLucky, getItemNameById(id) .. " (" .. lootCountL .. ")")
							 else
								print(name .." corpse not container!")
							 end
						end
					  end
				end
				
				if getPlayerStorageValue(cid, 17227) and getPlayerStorageValue(cid, 17227) > os.time() and charm ~= true then
					local percent, lootCount = math.random(1, 100000), math.random(1, count)
					if (percent <= chance) then
						if isStone(id) then
						   isStoneDroped = true
						   local posCorpse = getThingPos(item)
								 posCorpse.x = posCorpse.x +1
						   doSendMagicEffect(posCorpse, stoneEffect[getItemNameById(id):lower()])
						   posCorpse.y = posCorpse.y +1
						   addEvent(doSendMagicEffect, 2000, posCorpse, 792)
						end
						   local posCorpse = getThingPos(item)
								 posCorpse.x = posCorpse.x +1
								 posCorpse.y = posCorpse.y +1
						if isInArray(rareItems, id) then
						   isRareDroped = true
						   doSendMagicEffect(posCorpse, 791)
						end
							if isInArray(megaStones, id) then
							   isMegaStone = true
							   doSendMagicEffect(posCorpse, 698)
							end
						if isInArray(logItems, id) then
							table.insert(logToDo, "(RINDO CHARM) "..getItemNameById(id))
							doSendMagicEffect(posCorpse, 698)
						end
						 if isContainer(item) then
							doAddContainerItem(item, id, lootCount)
							table.insert(lootListCharm, getItemNameById(id) .. " (" .. lootCount .. ")")
						 else
							print(name .." corpse not container!")
						 end
					 end
				end
	
			-- device
			local heldz = getItemAttribute(getPlayerSlotItem(cid, 8).uid, "zHeldItem")
				if heldz and heldz ~= -1 then
					local heldNameZ, heldTierZ = string.explode(heldz, "|")[1], string.explode(heldz, "|")[2]
					if heldName ~= heldNameZ then
					  if heldNameZ == "X-Lucky" then -- dar mais loot
						chanceLucky = chance * heldLucky[tonumber(heldTierZ)]
						local percentL, lootCountL =  math.random(1, 100000), math.random(1, count)
						if (percentL <= chanceLucky) then
							if isStone(id) then
							   isStoneDroped = true
							   local posCorpse = getThingPos(item)
									 posCorpse.x = posCorpse.x +1
							   doSendMagicEffect(posCorpse, stoneEffect[getItemNameById(id):lower()])
							   posCorpse.y = posCorpse.y +1
							   addEvent(doSendMagicEffect, 2000, posCorpse, 792)
							end
							local posCorpse = getThingPos(item)
								 posCorpse.x = posCorpse.x +1
								 posCorpse.y = posCorpse.y +1
							if isInArray(rareItems, id) then
							   isRareDroped = true
								doSendMagicEffect(posCorpse, 4791)
							end
							if isInArray(megaStones, id) then
							   isRareDroped = true
							   doSendMagicEffect(posCorpse, 698)
							end
							if isInArray(logItems, id) then
								table.insert(logToDo, "(LUCKY T"..heldTierZ..") "..getItemNameById(id))
								doSendMagicEffect(posCorpse, 698)
							end
							 if isContainer(item) then
								 doAddContainerItem(item, id, lootCountL)
								 table.insert(lootListLucky, getItemNameById(id) .. " (" .. lootCountL .. ")")
							else
								print(name .." corpse not container.")
							end
						end
					  end
					end
				end
			---- X-Lucky
			end
			
			local percent, lootCount = math.random(1, 100000), math.random(1, count)
			if (percent <= chance) then
				if isStone(id) then
				   isStoneDroped = true
				   local posCorpse = getThingPos(item)
						 posCorpse.x = posCorpse.x +1
				   doSendMagicEffect(posCorpse, stoneEffect[getItemNameById(id):lower()])
				   posCorpse.y = posCorpse.y +1
				   addEvent(doSendMagicEffect, 2000, posCorpse, 792)
				end
				if isInArray(rareItems, id) then
				   isRareDroped = true
				   local posCorpse = getThingPos(item)
						 posCorpse.x = posCorpse.x +1
						 posCorpse.y = posCorpse.y +1
				   doSendMagicEffect(posCorpse, 791)
				end
				if isInArray(megaStones, id) then
					isMegaStone = true
					local posCorpse = getThingPos(item)
					posCorpse.x = posCorpse.x +1
					posCorpse.y = posCorpse.y +1
					doSendMagicEffect(posCorpse, 698)
				end
				if isInArray(logItems, id) then table.insert(logToDo, getItemNameById(id)) end
				 if isContainer(item) then
					 doAddContainerItem(item, id, lootCount)
					 table.insert(lootListNow, getItemNameById(id) .. " (" .. lootCount .. ")")
				 else
					print(name .." corpse not container!")
				end
			end
		end
		if #logToDo > 0 then
			for i,n in pairs(logToDo) do
				local dir = "data/logs/rare drop.log"
				local arq = io.open(dir, "a+")
				local txt = arq:read("*all")
				arq:close()
				local arq = io.open(dir, "w")
				arq:write(""..txt.."\n[DROP ".. os.date("%x %X] ") .. getCreatureName(cid) .." -> ".. n)
				arq:close()
			end
		end
			  
		for i = 1, #lootListNow do
			str = str .. lootListNow[i] .. (tonumber(i) == tonumber(#lootListNow) and "." or ", ")
		end
		if #lootListLucky > 0 then
			str = str .. " LUCKY: "
			for iL = 1, #lootListLucky do
				str = str .. lootListLucky[iL] .. (tonumber(iL) == tonumber(#lootListLucky) and "." or ", ")
			end
		end
		if #lootListCharm > 0 then
			str = str .. " CHARM: "
			for iC = 1, #lootListCharm do
				str = str .. lootListCharm[iC] .. (tonumber(iC) == tonumber(#lootListCharm) and "." or ", ")
			end
		end
	end
	
	
	if getExpByMoreDano(target) == true then
		return true
	end
	local players = string.explode(getExpByMoreDano(target), "|")
	local xp, newXP = getPokemonExperienceD(name), xp
	if pokes[name].exp then if pokes[name].exp > xp then xp = pokes[name].exp end end
	local maiorPercent = 0
	local playerWinner = ""
		if xp > 0 then
			if players ~= nil then
				for i = 1, #players do
				local name = string.explode(players[i], "/")[1]
				local percent = tonumber(string.explode(players[i], "/")[2])
					  if percent > maiorPercent and name ~= "Self" then
					     playerWinner = name
						 maiorPercent = percent
					  end
					  if #players == 1 then -- caso so um player matou o bixo
					     percent = 100
					  end
					  local heldExp = 1
					if name ~= "Self" then
						local player = getPlayerByName(name)
						if isPlayer(player) then
							local heldx = getItemAttribute(getPlayerSlotItem(player, 8).uid, "xHeldItem")
							local heldName, heldTier = "",""
							if heldx then
								  heldName, heldTier = string.explode(heldx, "|")[1], string.explode(heldx, "|")[2]
								  if heldName == "X-Experience" then -- dar mais experiencia
									 heldExp = heldExperience[tonumber(heldTier)]
								  end
							end
							
							local heldz = getItemAttribute(getPlayerSlotItem(player, 10).uid, "zHeldItem")
							if heldz and heldz ~= -1 then
								  local heldNameZ, heldTierZ = string.explode(heldz, "|")[1], string.explode(heldz, "|")[2]
								  if heldName ~= heldNameZ then
									  if heldNameZ == "X-Experience" then -- dar mais experiencia
										heldExp = heldExperience[tonumber(heldTierZ)]
									  end
								  end
							end
							
							addExpByStages(player,  math.ceil(percent * xp / 100) * heldExp)
							doCheckTask(player, pokeNamee)
							if not isInArea(getThingPos(player), {x=1285, y=472, z=6}, {x=1318, y=489, z=6}) then
								doBossReward(player, string.lower(pokeNamee))
							end
						end
					end
				end
			end
		end -- xp > 0
		  local pWinnerLoot = getPlayerByName(playerWinner)	
		  if isCreature(pWinnerLoot) then
			 if not isInArea(getThingPos(pWinnerLoot), {x=1285, y=472, z=6}, {x=1318, y=489, z=6}) then
				 doBossReward(pWinnerLoot, pokeNamee, playerWinner)
			 end
			 doSpawnCharm(cid, target)
			 -- doSpawnBoss(cid, target)
			 -- doSpawnMega(cid, target)
			 doPlayerAutoLoot(cid, target)
			 checkDungeon(cid, target)
			 doCheckTaskKill(cid, target)
			 checkDailyTaskKill(cid, target)
			 doPlayerAddMoneyOnKillPoke(cid, target)
		     doItemSetAttribute(item, "corpseowner", playerWinner)
			 local loot =  str .. (str == "Loot from ".. pokeName .. ": " and "Nothing." or "")
		     doPlayerSendTextMessage(pWinnerLoot, MESSAGE_INFO_DESCR, loot)
			 if isInParty(pWinnerLoot) then
				doSendMsgInParty(pWinnerLoot, loot)
			end
			 if isStoneDroped then
			    doSendMagicEffect(getThingPos(pWinnerLoot), 173, pWinnerLoot)
				doSendMsg(pWinnerLoot, pokeName .. " dropped a stone.")
			 end
			 if isMegaStone then
			    doSendMagicEffect(getThingPos(pWinnerLoot), 173, pWinnerLoot)
				-- doSendMsg(pWinnerLoot, pokeName .. " dropped a mega stone.")		
				doBroadcastMessage("green | [DROP MEGA STONE] O Jogador " .. pWinnerLoot .. " acabou de dropar uma mega stone matando o pokÃ©mon " .. pokeName)
			 end
			 if isRareDroped then
			    doSendMagicEffect(getThingPos(pWinnerLoot), 173, pWinnerLoot)
				doSendAnimatedText(getThingPos(pWinnerLoot), '!', COLOR_BURN)
				doSendMsg(pWinnerLoot, pokeName .. " dropped something rare.")
			 end
		  end
end

function doCheckTask(cid, pname)
	local pokename = pname
	if string.lower(getPlayerStorageValue(cid, 30019)) == string.lower(pname) then -- tÃ¡ fazendo task com esse poke
		--print(getPlayerName(cid).." killed task ".. pokename)
		local qt = getPlayerStorageValue(cid, 30020)
		if qt == 1 then
		     doSendMsg(cid, "You've hunted all pokemons. Go back to Viktor to receive your rewards.")
		elseif qt > 1 then
			--doSendMsg(cid, "You still have to defeat ".. qt .." ".. pokename (qt > 1 and "s" or "") ..".")
			doSendMsg(cid, "You still have to defeat ".. qt .." ".. pokename .."".. (qt > 1 and "s" or "")..".")
		else
			return true
		end
		setPlayerStorageValue(cid, 30020, qt-1)
	end
end

function playerAddExp(cid, exp)
if not isCreature(cid) then return true end
	if isInPartyAndSharedExperience(cid) then
		local partyPlayers = getPartyMembers(getPlayerParty(cid))
		local partyExp = math.ceil(exp / #partyPlayers)
			  for i = 1, #partyPlayers do
				 if isPlayer(partyPlayers[i]) then
				    doPlayerAddExp(partyPlayers[i], partyExp * 30)
				    doSendAnimatedText(getThingPos(partyPlayers[i]), partyExp * 30, 215)
				 end
			  end
		return true
	end
	doPlayerAddExp(cid, exp * 30)
	doSendAnimatedText(getThingPos(cid), exp * 30, 215)
end

function doSendMsgInParty(cid, loot)
	doSendMsgToPartyChannel(cid, loot)
	if isInPartyAndSharedExperience(cid) then
		local partyPlayers = getPartyMembers(getPlayerParty(cid))
			  for i = 1, #partyPlayers do
				 if isPlayer(partyPlayers[i]) then
					doPlayerSendChannelMessage(partyPlayers[i], getCreatureName(cid), loot, TALKTYPE_CHANNEL_RN, 9006-45)
				 end
			  end
		return true
	end
end

function checkDirias(cid, nameDeath)
	    local master = getCreatureMaster(cid)
		local getNpcTaskName = getPlayerStorageValue(master, storages.miniQuests.storNpcTaskName)
		local pokeTask1 = getPlayerStorageValue(master, storages.miniQuests.storPokeNameTask1)
		local pokeCountTask1 = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask1))
		
	   if pokeTask1 ~= -1 and pokeTask1 == nameDeath then
		  setPlayerStorageValue(master, storages.miniQuests.storPokeCountTask1, pokeCountTask1 -1) 
		  local getCountNow = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask1))
		  if getCountNow >= 1 then
		     doSendMsg(master, getNpcTaskName .. ": Faltam " .. getCountNow .. " " .. nameDeath .. (getCountNow > 1 and "s" or "") .. ".")
		  else
		     doSendMsg(master, getNpcTaskName .. ": Você concluiu minha task venha pegar sua recompensa.")
		  end
	   end
	   
	    local getNpcTaskName2 = getPlayerStorageValue(master, storages.miniQuests.storNpcTaskName2)
		local pokeTask2 = getPlayerStorageValue(master, storages.miniQuests.storPokeNameTask2)
		local pokeCountTask2 = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask2))
		
	   if pokeTask2 ~= -1 and pokeTask2 == nameDeath then
		  setPlayerStorageValue(master, storages.miniQuests.storPokeCountTask2, pokeCountTask2 -1) 
		  local getCountNow2 = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask2))
		  if getCountNow2 >= 1 then
		     doSendMsg(master, getNpcTaskName2 .. ": Faltam " .. getCountNow2 .. " " .. nameDeath .. (getCountNow2 > 1 and "s" or "") .. ".")
		  else
		     doSendMsg(master, getNpcTaskName2 .. ": Você concluiu minha task venha pegar sua recompensa.")
		  end
	   end
	   
	   local getNpcTaskName3 = getPlayerStorageValue(master, storages.miniQuests.storNpcTaskName3)
	   local pokeTask3 = getPlayerStorageValue(master, storages.miniQuests.storPokeNameTask3)
	   local pokeCountTask3 = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask3))
		
	   if pokeTask3 ~= -1 and pokeTask3 == nameDeath then
		  setPlayerStorageValue(master, storages.miniQuests.storPokeCountTask3, pokeCountTask3 -1) 
		  local getCountNow3 = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask3))
		  if getCountNow3 >= 1 then
		     doSendMsg(master, getNpcTaskName3 .. ": Faltam " .. getCountNow3 .. " " .. nameDeath .. (getCountNow3 > 1 and "s" or "") .. ".")
		  else
		     doSendMsg(master, getNpcTaskName3 .. ": Você concluiu minha task venha pegar sua recompensa.")
		  end
	   end
	   
	   local getNpcTaskName4 = getPlayerStorageValue(master, storages.miniQuests.storNpcTaskName4)
	   local pokeTask4 = getPlayerStorageValue(master, storages.miniQuests.storPokeNameTask4)
	   local pokeCountTask4 = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask4))
		
	   if pokeTask4 ~= -1 and pokeTask4 == nameDeath then
		  setPlayerStorageValue(master, storages.miniQuests.storPokeCountTask4, pokeCountTask4 -1) 
		  local getCountNow4 = tonumber(getPlayerStorageValue(master, storages.miniQuests.storPokeCountTask4))
		  if getCountNow4 >= 1 then
		     doSendMsg(master, getNpcTaskName4 .. ": Faltam " .. getCountNow4 .. " " .. nameDeath .. (getCountNow4 > 1 and "s" or "") .. ".")
		  else
		     doSendMsg(master, getNpcTaskName4 .. ": Você concluiu minha task venha pegar sua recompensa.")
		  end
	   end
end
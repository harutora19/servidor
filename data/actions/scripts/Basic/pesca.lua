local fishing = {
[-1] = { exp = 1, segs = 2, pokes = {{"Magikarp", 5}} },

[3976] = { exp = 4, segs = 3, pokes = {{"Horsea", 3}, {"Goldeen", 3}, {"Poliwag", 3}, {"Krabby", 3}} },

[12855] = { exp = 8, segs = 3, pokes = {{"Tentacool", 3}, {"Remoraid", 3}, {"Staryu", 3}, {"Shellder", 3}, {"Seel", 2}, {"Chinchou", 2} } },

[12854] = { exp = 16, segs = 3, pokes = {{"Seaking", 2}, {"Seadra", 2}, {"Poliwhirl", 2}, {"Spheal", 2, true} } },

[12858] = { exp = 64, segs = 4, pokes = {{"Starmie", 2}, {"Kingler", 2}, {"Corsola", 2}, {"Qwilfish", 2}, {"Sealeo", 2, true}, {"Corphish", 2, true}} },

[12857] = { exp = 512, segs = 5, pokes = {{"Cloyster", 2}, {"Poliwrath", 2}, {"Politoed", 2}, {"Dewgong", 2}} },

[12860] = { exp = 2048, segs = 5, pokes = {{"Lanturn", 2}, {"Giant Magikarp", 1}}},

[12859] = { exp = 8192, segs = 5, pokes = {{"Mantine", 2}, {"Tentacruel", 2}, {"Kingdra", 2}, {"Octillery", 2}} },

[12856] = { exp = 8192, segs = 8, pokes = {{"Dratini", 4}, {"Dragonair", 2} , {"Dragonite", 1}}},

[12853] = { exp = 16384, segs = 8, pokes = {{"Giant Magikarp", 2}, {"Gyarados", 2}, {"Blastoise", 2}, {"Walrein", 2, true}, {"Swampert", 2, true}, {"Crawdaunt", 2, true}} },
}

local storageP = 154586
local sto_iscas = 5648454 --muda aki pra sto q ta no script da isca
local bonus = getConfigValue('rateSkill')
local limite = 100

local fightcondition = createConditionObject(CONDITION_INFIGHT)
setConditionParam(fightcondition, CONDITION_PARAM_TICKS, 5 * 1000)

function fightCondic(cid)
	if not isCreature(cid) then return true end
	if not isCreature(getCreatureTarget(cid)) then return true end
	doAddCondition(cid, fightcondition)
	addEvent(fightCondic, 1000, cid)
end

function getWalkableAround(cid, range)
	local mypos = getThingPos(cid)
	local rets = {}
	for x=-2,2 do
		for y=-2,2 do
			local cpos = getThingPos(cid)
			cpos.x = cpos.x + x
			cpos.y = cpos.y + y
			cpos.stackpos = 0
			if isWalkable(cpos, true, true) and not (cpos.x == mypos.x and cpos.y == mypos.y) and not getTileInfo(cpos).protection then
				if getTileThingByPos({x = cpos.x, y = cpos.y, z = cpos.z, stackpos = 0}).itemid ~= 11756 then
						table.insert(rets, cpos)
				end
			end
		end
	end
	if #rets > 0 then
		return rets[math.random(1,#rets)]
	end
	return false
end

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

local function doFish(cid, pos, ppos, interval)
      if not isCreature(cid) then return false end
      if getThingPos(cid).x ~= ppos.x or getThingPos(cid).y ~= ppos.y then
         return false 
      end
      
      doSendMagicEffect(pos, CONST_ME_LOSEENERGY)
      
      if interval > 0 then
         addEvent(doFish, 1000, cid, pos, ppos, interval-1)
         return true
      end   

      local peixe = 0
      local fishes = fishing[getPlayerStorageValue(cid, sto_iscas)]
      local random = {}   

	  if getPlayerSkillLevel(cid, 6) < 10 then
		 while getPlayerSkillLevel(cid, 6) < 10 do
			doPlayerAddSkillTry(cid, 6, 25)
		 end
	  elseif getPlayerSkillLevel(cid, 6) < limite then
		 -- local vipexp = PVIPgetLevel(cid) and PVIPgetLevel(cid) > 0 and (1 + viptable[PVIPgetLevel(cid)].bexpr) or 1
		 if isPremium(cid) then
			texp = bonus * fishes.exp * (getPlayerSkillLevel(cid, 6)-9) * 1.20
		 else
			texp = bonus * fishes.exp * (getPlayerSkillLevel(cid, 6)-9) * 1.20
		end
		 doSendMsg(cid, "You've received ".. texp .." fishing experience. [".. getPlayerSkillTries(cid, 6) .."/".. getPlayerRequiredSkillTries(cid, 6, getPlayerSkillLevel(cid, 6)+1) .."] (".. round(texp * 100 / getPlayerRequiredSkillTries(cid, 6, getPlayerSkillLevel(cid, 6)+1), 2) .."%)")
		 doPlayerAddSkillTry(cid, 6, texp)
	  end
	  
	     --[[if math.random(1, 100) <= chance then
		if getPlayerSkillLevel(cid, 6) < limite then
		doPlayerAddSkillTry(cid, 6, bonus * 5)
		end]]
	  
	  
		
	  local t = {}
	  for i,v in pairs(fishes.pokes) do
		if v[3] then
			if isInArea(getThingPos(cid),{x=1951,y=314,z=0},{x=2687,y=924,z=15}) then
				table.insert(t, v)
			end
		else
			table.insert(t, v)
		end
	  end
	  if isInArea(getThingPos(cid),{x=1951,y=314,z=0},{x=2687,y=924,z=15}) and getPlayerLevel(cid) > 300 then -- cordova
			if math.random(1,10) == 10 then
				table.insert(t, {"Feebas", 1})
			end
			if math.random(1,1000) == 1 and getPlayerSkillLevel(cid, 6) > 80 then
				table.insert(t, {"Milotic", 1})
			end
	  end
	  
      random = t[math.random(#t)]
	  
	  local function removeSpam(who)
	  if not isCreature(who) then return true end
	  doSendMagicEffect(getThingPos(who), 1)
	  doRemoveCreature(who)
	  end
	  
      for i = 1, math.random(random[2] + math.ceil(getPlayerSkillLevel(cid, 6) / 20)) do
          peixe = doSummonCreature(random[1], getWalkableAround(cid, 2))
		  addEvent(removeSpam, 2 * 60 * 1000, peixe)
          if not isCreature(peixe) then
             doRemoveCondition(cid, CONDITION_OUTFIT)
             return true
          end
          setPokemonPassive(peixe, true)
		  doSetPokemonAgressiveToPlayer(peixe, cid)
		  fightCondic(cid)
	      if #getCreatureSummons(cid) >= 1 then
             doSendMagicEffect(getThingPos(getCreatureSummons(cid)[1]), 0)
		     doChallengeCreature(getCreatureSummons(cid)[1], peixe)
          else	
             doSendMagicEffect(getThingPos(cid), 0)
		     doChallengeCreature(cid, peixe)
          end
       end
       doRemoveCondition(cid, CONDITION_OUTFIT)
return true
end

local waters = {11756, 4820, 4821, 4822, 4823, 4824, 4825}

function onUse(cid, item, fromPos, itemEx, toPos)


local checkPos = toPos
checkPos.stackpos = 0

if getTileThingByPos(checkPos).itemid <= 0 then
   return true
end

if not isInArray(waters, getTileInfo(toPos).itemid) then
   return true
end

if type(getPlayerStorageValue(cid, storageP)) ~= "number" then setPlayerStorageValue(cid, storageP, 1) end
if getPlayerStorageValue(cid, storageP) > os.time() then 
	doPlayerSendCancel(cid, "Wait ".. getPlayerStorageValue(cid, storageP) - os.time() .." seconds.")
	return true
end

if isRiderOrFlyOrSurf(cid) and not canFishWhileSurfingOrFlying then
   doPlayerSendCancel(cid, "You can't fish while surfing/flying.")
   return true
end

if getTileInfo(getThingPos(getCreatureSummons(cid)[1] or cid)).protection then
	doPlayerSendCancel(cid, "You can't fish pokémons if you or your pokémon is in protection zone.")
return true
end

local delay = fishing[getPlayerStorageValue(cid, sto_iscas)].segs

if getPlayerStorageValue(cid, sto_iscas) ~= -1 then
   if getPlayerItemCount(cid, getPlayerStorageValue(cid, sto_iscas)) >= 1 then
      doPlayerRemoveItem(cid, getPlayerStorageValue(cid, sto_iscas), 1)
   else
      setPlayerStorageValue(cid, sto_iscas, -1)
   end
end

local outfit = getCreatureOutfit(cid)
local out = getPlayerSex(cid) == 0 and 139 or 141

doSetCreatureOutfit(cid, {lookType = out, lookHead = outfit.lookHead, lookBody = outfit.lookBody, lookLegs = outfit.lookLegs, lookFeet = outfit.lookFeet}, -1)
local timer = math.random(2,delay)
setPlayerStorageValue(cid, storageP, os.time() + timer + 1)     --alterei looktype
doCreatureSetNoMove(cid, false)
stopNow(cid, timer*1000)
local pos2 = getThingPos(itemEx.uid)
doCreatureSetLookDir(cid, getLookToFish(getThingPos(cid), pos2))  --alterado ver depois
doFish(cid, toPos, getThingPos(cid), timer)

return true
end

function getLookToFish(pos, pos2)
local x1, y1 = pos.x, pos.y
local x2, y2 = pos2.x, pos2.y

if x1-x2 <= 0 and  y1-y2 > 0 then
	return NORTH
elseif x1-x2 < 0 and  y1-y2 == 0 then
	return EAST
elseif x1-x2 < 0 and  y1-y2 < 0 then
	return EAST
elseif x1-x2 > 0 and  y1-y2 < 0 then
	return SOUTH
elseif x1-x2 > 0 and  y1-y2 <= 0 then
	return WEST
elseif x1-x2 > 0 and  y1-y2 >= 0 then
	return WEST
elseif x1-x2 < 0 and  y1-y2 < 0 then
	return EAST
elseif x1-x2 == 0 and  y1-y2 < 0 then
	return SOUTH
end
return WEST
end

--[[-- resulatados em linha reta(exatos)
if x1 == x2 then -- virar para norte
	if (y1 - y2) > 0 then -- virar para cima
	    return NORTH
	elseif (y1 - y2) < 0 then -- virar para baixo
		return SOUTH
	end
elseif y1 == y2 then
	if (x1 - x2) > 0 then -- virar para OESTE <<
	    return WEST
	elseif (x1 - x2) < 0 then -- virar para LESTE >>
		return EAST
	end
end
-- resulatados em linha reta(exatos)

if (x1 ~= x2) or (y1 ~= y2) then
	if (x1 - x2) < 0 then
	   return EAST -- virar para LESTE >>
	elseif (x1 - x2) > 0 then
	   return WEST
	end
end]]
local fightcondition = createConditionObject(CONDITION_INFIGHT)
setConditionParam(fightcondition, CONDITION_PARAM_TICKS, 12 * 1000)

function fightCondic(cid)
	if not isCreature(cid) then return true end
	if not isCreature(getCreatureTarget(cid)) then return true end
	doAddCondition(cid, fightcondition)
	addEvent(fightCondic, 1000, cid)
end

local posa1, posa2 = {x=2558,y=2478,z=9}, {x=3368,y=3491,z=1}

function onTarget(cid, target)

if not (isCreature(cid) and isCreature(target)) then return false end

if (not getPlayerStorageValue(target, 505) or not isPlayer(getPlayerStorageValue(target, 505))) and isPlayer(cid) then
   doSetPokemonAgressiveToPlayer(target, cid)
end

-- alignment
-- if isNPCSummon(cid) or isNPCA(cid) then
	-- print('agora foi')
-- end
-- if (isNPCSummon(target) or isNPCA(target)) and isPlayer(cid) then
	-- if getCreatureAlignment(cid) == 'none' or (getCreatureAlignment(cid) == getCreatureAlignment(target)) then
		--addEvent(rePass, 10, target)
		-- doPlayerSendCancel(cid, "Sorry, not possible.")
		-- return false
	-- end
-- end

-- if isPlayer(cid) and isInArray({"Armadilha Fogo Grande", "Armadilha Raio Grande", "Armadilha Gelo Grande", "Armadilha Fogo Pequena"}, isWild(target)) then
	-- doPlayerSendCancel(cid, "Sorry, not possible.")
	-- return false
-- end


if isInArea(getThingPos(cid), posa1, posa2) then
	if isSummon(target) or (isPlayer(target) and #getCreatureSummons(target) < 1) then
		return true
	end
end

if isPlayer(target) then
	if #getCreatureSummons(target) >= 1 then
		target = getCreatureSummons(target)[1]
		return true
	end
   if canAttackOther(cid, target) == "Cant" then            
      return false 
   elseif isPlayer(target) and #getCreatureSummons(target) >= 1 and canAttackOther(cid, target) == "Can" then
      return false
   end
end

if getPlayerStorageValue(target, 201) ~= -1 then
for a, b in pairs(ginasios) do
if getPlayerStorageValue(target, ginasios[getPlayerStorageValue(target, 201)].storage) == 1 then
	if getPlayerStorageValue(cid, ginasios[getPlayerStorageValue(target, 201)].storage) ~= 1 then
	doPlayerSendCancel(cid, "You can't attack this pokemon.")
	return false
	end
end
end
end

if isSummon(target) then                             
	if not CanAttackerInDuel(cid, getCreatureMaster(target)) then
	   return false
	end
end 

return true
end
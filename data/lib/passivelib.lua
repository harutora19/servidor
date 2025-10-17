function isPokePassive(cid)
if not isCreature(cid) then return false end
	if isWild(cid) and isInArray(passivepokemons, doCorrectString(getCreatureName(cid)))  then
	   return true 
	end
	return false
end

function doSetPokemonAgressiveToPlayer(cid, target)
	if not isCreature(cid) or not isCreature(target) then return false end
	if getCreatureTarget(cid) >= 1 and isCreature(getCreatureTarget(cid)) then return true end
	
	setPokemonPassive(cid, false)
	setPlayerStorageValue(cid, 505, getCreatureName(target))
	if #getCreatureSummons(target) > 0 then
	   doMonsterSetTarget(cid, getCreatureSummons(target)[1])
	else
	   doMonsterSetTarget(cid, target)
	end
end

function getPokemonAttackedPassive(cid)
if not isCreature(cid) then return false end
local stor = getPlayerStorageValue(cid, 505)
    if stor ~= 0 then
       return stor
	else
	   return ""
	end
end

function setPokemonPassive(cid, passive)
if not isCreature(cid) then return false end
	if passive then 
		setPlayerStorageValue(cid, 504, 0)
		setPlayerStorageValue(cid, 505, 0)		
	else 
		setPlayerStorageValue(cid, 504, 1) 
	end
end

storage_isReloading = 217312
function doReloadPokemon(cid)
	if getPlayerStorageValue(cid, storage_isReloading) > os.time() then return false end
	local lifeNow = getCreatureHealth(cid)
	local lifeMax = getCreatureMaxHealth(cid)
	local pos = getThingPos(cid)
	local name = getCreatureName(cid)
	local dir = getCreatureLookDirection(cid)
	local tmpsd = getPlayerStorageValue(cid, storages.damageKillExp)
	local nid = doCreateMonsterNick(cid, name, name, pos, false)
	--local nid = doCreateMonster(name, pos, false)
	doCreatureSetLookDir(nid, dir)
	setPlayerStorageValue(nid, storages.damageKillExp, tmpsd)
	setPlayerStorageValue(nid, storages.markedPosPoke, "x = "..pos.x..", y = "..pos.y..", z = "..pos.z..";")
	setPlayerStorageValue(nid, storage_isReloading, os.time()+60)
	addEvent(doCreatureAddHealth,10,nid, -(lifeMax - lifeNow))
	doCreatureSay(nid, "RELOAD!", TALKTYPE_ORANGE_1)
	doRemoveCreature(cid)
	return nid
end

function getClosestTarget(cid)
local rangeX, rangeY = 7, 7
local spectators = getSpectators(getCreaturePosition(cid), rangeX, rangeY, false)
local specPk = {}
local specPl = {}

	
	if spectators ~= nil then
		for i,pid in pairs(spectators) do
			if isSummon(pid) then
				table.insert(specPk, {uid=pid, dist=getDistanceBetween(getCreaturePosition(cid), getCreaturePosition(pid))})
			elseif isPlayer(pid) and getPlayerGroupId(pid) < 4 then
				table.insert(specPl, {uid=pid, dist=getDistanceBetween(getCreaturePosition(cid), getCreaturePosition(pid))})
			end
		end
		local target = 0
		local lowestdist = 1000
		if #specPl > 0 then
			for i,v in pairs(specPk) do
				if v.dist < lowestdist then
					target = v.uid
					lowestdist = v.dist
				end
			end
		end
		if #specPk > 0 then	
			for i,v in pairs(specPk) do
				if v.dist < lowestdist then
					target = v.uid
					lowestdist = v.dist
				end
			end
		end
	end
	return target ~= 0 and target or false
end

function onWalkSetTargetPassive(cid)
if not isCreature(cid) then return false end
if getCreatureTarget(cid) >= 1 then return false end
local rangeX, rangeY = 7, 7
local spectators = getSpectators(getCreaturePosition(cid), rangeX, rangeY, false)
local attackerName = getPokemonAttackedPassive(cid)
local playerID = getPlayerByName(attackerName)

if not isCreature(playerID) then
	return false
end
if getCreatureTarget(cid) ~= playerID and attackerName ~= "" then
	return false
end

if spectators then
        for _, spectator in ipairs(spectators) do
            if isPlayer(spectator) and spectator ~= cid and (attackerName ~= "" and attackerName == getCreatureName(spectator)) and isWalkable(getThingPos(spectator), false, true, true, true) then
				setPlayerStorageValue(cid, 504, 1)
				if #getCreatureSummons(spectator) > 0 then
				   doMonsterSetTarget(cid, getCreatureSummons(spectator)[1])
				else
				   doMonsterSetTarget(cid, spectator)
				end
				break
			else
				setPlayerStorageValue(cid, 504, 0)
				--doPokemonSetNoTarget(cid)
            end
        end
    end
end


function doPokemonSetNoTargets(cid)
if not isCreature(cid) then return false end
	local name = getCreatureName(cid)
	local monsterT = doCreateMonsterNick(cid, name, name, getThingPos(cid), false)
	doRemoveCreature(cid)
end
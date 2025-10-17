function doHealOverTime(cid, hp, turn, effect, div)                     --alterado v1.6 peguem o script todo!!
if not isCreature(cid) then return true end
if turn <= 0 or (getCreatureHealth(cid) == getCreatureMaxHealth(cid)) or getPlayerStorageValue(cid, 173) <= 0 then 
   setPlayerStorageValue(cid, 173, -1)
   return true 
end
local amount = math.ceil(hp/div)
doCreatureAddHealth(cid, amount)
doSendMagicEffect(getThingPos(cid), effect)
addEvent(doHealOverTime, 1000, cid, hp, turn - 1, effect, div)
end

local potions = {
[12347] = {effect = 13, div = 30, hp = 2500, turns = 5}, --super potion
[12348] = {effect = 13, div = 60, hp = 6000, turns = 6}, --great potion              
[12346] = {effect = 12, div = 80, hp = 16000, turns = 8}, --ultra potion
[12345] = {effect = 14, div = 90, hp = 30000, turns = 10}, --hyper potion
[12343] = {effect = 14, div = 110, hp = 60000, turns = 15}, --full restore
}

function onUse(cid, item, frompos, item2, topos)
local pid = getThingFromPosWithProtect(topos)

if isPlayer(pid) and not pid then
return doPlayerSendCancel(cid, "You can't use potions on other players!")
end

if isPlayer(pid) then
	return doPlayerSendCancel(cid, "You can't use potions on other players!")
end

-- if isPlayer(pid) then
	-- return doPlayerSendCancel(cid, "You cannot potion yourself!")
-- end
   if not isPlayer(getCreatureMaster(item2.uid)) or getCreatureMaster(item2.uid) ~= cid then
      doPlayerSendCancel(cid, "Você só pode usar potion no seu pokémon.")
      return true
   end

if isInArea(getThingPos(cid), {x=2449,y=2611,z=8}, {x=2491,y=2654,z=8}) then
return doPlayerSendCancel(cid, "You can't use potions here!")
end

if getCreatureHealth(pid) == getCreatureMaxHealth(pid) then
return doPlayerSendCancel(cid, "This pokemon is already at full health.")
end

if getPlayerStorageValue(pid, 173) >= 1 then
return doPlayerSendCancel(cid, "This pokemon is already under effects of potions.")
end

-- if (isInArea(getThingPos(cid), towerTopCorner, towerBottomCorner) or isInArea(getThingPos(cid), towerTopBossCorner, towerBottomBossCorner)) and (not getPlayerStorageValue(cid, towerPotionStorage) or getPlayerStorageValue(cid, towerPotionStorage) <= 0) then
   -- doPlayerSendCancel(cid, "You've already have used the limit of potions.")
   -- return true
-- end
   
if isWild(pid) then
	doPlayerSendCancel(cid, "You can't use potions on wild pokemon!")
	return true
end

if getPlayerStorageValue(cid, 52481) >= 1 then
return doPlayerSendCancel(cid, "You can't do that while a duel.")
end

if getPlayerStorageValue(cid, 990) >= 1 then
   doPlayerSendCancel(cid, "You can't use potions during gym battles.")
   return true
end

local colors = {
[12348] = COLOR_GREEN,
[12345] = COLOR_RED-5,
[12346] = COLOR_GREEN+5,
[12347] = COLOR_YELLOW+1,
[12343] = COLOR_PURPLE-1,
}

if not (isPlayer(pid) and pid == cid) then
	doCreatureSay(cid, "".. getCreatureName(pid)..", take this potion!", TALKTYPE_MONSTER)
end

doSendAnimatedText(getThingPos(pid), string.upper(getItemNameById(item.itemid)).."!", colors[item.itemid])
doSendMagicEffect(getThingPos(pid), 0)
setPlayerStorageValue(pid, 173, 1)
doRemoveItem(item.uid, 1)
if getPlayerStorageValue(cid, towerPotionStorage) > 0 and (isInArea(getThingPos(cid), towerTopCorner, towerBottomCorner) or isInArea(getThingPos(cid), towerTopBossCorner, towerBottomBossCorner)) then
	setPlayerStorageValue(cid, towerPotionStorage, getPlayerStorageValue(cid, towerPotionStorage)-1)
	if getPlayerStorageValue(cid, towerPotionStorage) == 0 then
		doSendMsg(cid, "You've used your limit of potions.")
	else
		doSendMsg(cid, "You still have ".. getPlayerStorageValue(cid, towerPotionStorage) .." potions to use.")
	end
end
		   
local a = potions[item.itemid]
doHealOverTime(pid, isPlayer(pid) and a.hp/10 or a.hp, isPlayer(pid) and a.turns*3 or a.turns, a.effect, a.turns)
if not Dz.onUseMedicament(cid, {potion = true}) then return false end
return true
end
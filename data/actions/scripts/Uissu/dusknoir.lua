local posf = {{x=1919,y=2000,z=9},{x=1920,y=2000,z=9},{x=1921,y=2000,z=9}}
local toposi = {{x=1909,y=2003,z=10},{x=1931,y=1995,z=10},{x=1930,y=2008,z=10}}
local postop = {x=1907,y=1990,z=10}
local posbot = {x=1937,y=2013,z=10}
local effect = {27, 28, 79, 84, 85}
local bosspos = {x=1922,y=2001,z=10}


function outPosDusk()
return {x=math.random(1919,1921),y=math.random(2001,2003),z=9}
end

local sto = 42406
local stoT = 42407

local prize = 12227
local rwdexp = 500000
local cd = 60 * 10 -- 10 minutos
local cdWin = 60 * 60 * 6 -- 6 horas

local timeBetweenMinionWaves = 60 * 1 -- 1~1.5 minutos

function doTeleportThingWithPk(cid, topos)
	if not isCreature(cid) then return false end
	if #getCreatureSummons(cid) > 0 then
		doTeleportThing(getCreatureSummons(cid)[1], topos)
	end
	return doTeleportThing(cid, topos)
end

local players = {}
-- uid, frompos, name

function dusknoirClean(dead)
	local namedead = ''
	namedead = dead
	for x=postop.x,posbot.x do
		for y=postop.y,posbot.y do
			for stack=250,255 do
				local checkpos = {x=x,y=y,z=postop.z,stackpos=stack}
				local c = getThingFromPos(checkpos).uid
				if isCreature(c) and not isSummon(c) and not isPlayer(c) then
					doRemoveCreature(c)
				end
				if isPlayer(c) then
				local byepos = outPosDusk()
					local namsg = namedead ~= '' and namedead or "Someone"
					doPlayerSendTextMessage(c, MESSAGE_STATUS_CONSOLE_RED, namsg .." died, your team failed the tomb.")
					doTeleportThingWithPk(c, byepos)
				end
			end
		end
	end
	for k,v in pairs(players) do players[k]=nil end
end

function dusknoirImunityControl()
	if not isCreature(dusk) then return true end
	if dusknoirIsMinionAlive() then
		setPlayerStorageValue(dusk, 9658783, 1)
	else
		setPlayerStorageValue(dusk, 9658783, -1)
	end		
	return addEvent(dusknoirImunityControl, 100)
end

function dusknoirIsMinionAlive()
	for x=postop.x,posbot.x do
		for y=postop.y,posbot.y do
			for stack=250,255 do
				local checkpos = {x=x,y=y,z=postop.z,stackpos=stack}
				local c = getThingFromPos(checkpos).uid
				if isCreature(c) and not isSummon(c) and getCreatureName(c) == "Shadow" then
					return true
				end
			end
		end
	end
	return false
end

function dusknoirSummonMinion()
	local minionCountMax = 5
	if getGlobalStorageValue(stoT) <= os.time() then 
		local timenext = math.random(timeBetweenMinionWaves, timeBetweenMinionWaves * 1.5)
		setGlobalStorageValue(stoT, os.time() + timenext)
		for i,v in ipairs(players) do
			doSendMsg(v.uid, "Dusknoir: Let's see how you do against my minions!")
			doPlayerSendTextMessage(v.uid, MESSAGE_STATUS_CONSOLE_RED, "Shadow Minions have been summoned near your altar. Next wave in ".. timenext .." seconds.")
			doSendMagicEffect(toposi[i], 412)
			for x=1,math.random(2, minionCountMax) do
				doSummonCreature("Shadow", toposi[i])
			end
		end
	end
	return addEvent(dusknoirSummonMinion,1000)
end

function dusknoirCheckPlayers()
	local nameDead = ""
	for i,v in ipairs(players) do
		if not isPlayer(v.uid) or not isInArea(getThingPos(v.uid), postop, posbot) then
			nameDead = v.name
			break
		end
	end
	if nameDead ~= "" then
		doBroadcastMessage(nameDead .." died and his team failed the Evil Dusknoir Tomb.")
		for i,v in ipairs(players) do
			doSendMsg(v.uid, "Dusknoir: MUAHAHAHA! ".. nameDead .."'s soul is mine now.")
		end
		dusknoirClean(nameDead)
		return true
	end
	return addEvent(dusknoirCheckPlayers, 100)
end

function dusknoirCheckStage(stage)
	local s = stage
	if isCreature(dusk) then
		return addEvent(dusknoirCheckStage, 5000)
	end
	
	for i,v in pairs(players) do
		if isPlayer(v.uid) then
			doSendMsg(v.uid, "Dusknoir: How is this possible?? NOOOOOOOO!")
			if getPlayerStorageValue(v.uid, sto) ~= 1 then
				local bag = doCreateItemEx(12684)
				addItemInFreeBag(bag, 17243, 1) -- stamina 1h
				addItemInFreeBag(bag, 17205, 1) -- tm box c
				addItemInFreeBag(bag, 6569, 25) -- rare candy
				addItemInFreeBag(bag, 15644, 25) -- mighty token
				doPlayerAddItemEx(v.uid, bag)
				
				setPlayerStorageValue(v.uid, sto, 1)
				addEvent(doSendMsg, 5000, v.uid, "You've received a reward.")
				addEvent(addExpByStages, 5000, v.uid, rwdexp * 4, true)
			end
			doPlayerAddItem(v.uid, 6569, 50)
			setPlayerStorageValue(v.uid, stoT, os.time() + cdWin)
			addEvent(addExpByStages, 5000, v.uid, rwdexp, true)
			local byepos = outPosDusk()
			addEvent(doTeleportThingWithPk, 5000, v.uid, byepos)
			addEvent(doSendMagicEffect, 5000, byepos, effect[math.random(1,#effect)])
		end
	end
	for x=postop.x,posbot.x do
		for y=postop.y,posbot.y do
			local effpos = {x=x,y=y,z=postop.z}
			if math.random(1,5) == 1 then
				addEvent(doSendMagicEffect, math.random(0,4000), effpos, effect[math.random(1,#effect)])
			end
		end
	end
	addEvent(dusknoirClean, 5001)
end

god = getPlayerByName("Nautilus")

function getPlayerFromPos2(pos)
	for i,p in pairs(getPlayersOnline()) do
		local ppos = getThingPos(p)
		if ppos.x == pos.x and ppos.y == pos.y and ppos.z == pos.z then
			return p
		end
	end
	return 0
end

function dusknoirValidate(cid)
	dusknoirClean()
	players = nil
	players = {}
	local tmpP = {}
	local tmpC = {}
	for i=1,#posf do
			local cpos = posf[i]
			cpos.z = 9 -- AMÉM
			local pid = getPlayerFromPos2(cpos)
			if isPlayer(pid) and getPlayerGroupId(pid) < 5 then
				if isGod(cid) then doSendMsg(cid, i .. ": ".. getCreatureName(pid)) end
				local uid, frompos, name = pid, cpos, getCreatureName(pid)
				if getPlayerStorageValue(pid, stoT) > os.time() then doSendMsg(cid, name.." is on cooldown. Wait ".. math.ceil((getPlayerStorageValue(pid, stoT) - os.time())/60) .." minutes to go again!") return false end
				if getPlayerLevel(pid) < 250 then doSendMsg(cid, name.."'s level is not high enough.") return false end
				table.insert(tmpP, {uid=uid,frompos=frompos,name=name})
			end
	end
	if #tmpP < minPlayers then
		doSendMsg(cid, "You need at least ".. minPlayers .." players. (".. #tmpP .."/".. minPlayers ..")")
		return false
	else
		for i,v in pairs(tmpP) do
			players[i] = v
		end
		doBroadcastMessage(getCreatureName(cid).."'s team is going to challenge the Evil Dusknoir!")
		dusknoirStart()
	end
	return true
end

function dusknoirStart()
	setGlobalStorageValue(sto, os.time() + cd)
	for i,v in pairs(players) do
		doTeleportThingWithPk(v.uid, toposi[i])
		doSendMsg(v.uid, "Dusknoir: How dare you? I OWN THIS WORLD!! And now, I'll own YOUR SOULS!")
	end
	dusk = doSummonCreature("Evil Dusknoir", bosspos)
	addEvent(dusknoirCheckStage, 5000, 1)
	setGlobalStorageValue(stoT, 0) -- reseta contador de tempo dos minions
	dusknoirSummonMinion()
	dusknoirImunityControl()
	return dusknoirCheckPlayers()
end

function onUse(cid, item, frompos, item2, topos)
	minPlayers = 3

	if isGod(cid) then
		if getGlobalStorageValue(sto) > 0 then
			doSendMsg(cid, sto.." reset.")
			setGlobalStorageValue(sto, 0)
			return true
		end
		minPlayers = 1
	end
	if getGlobalStorageValue(sto) > os.time() then
		doSendMsg(cid, "Wait ".. math.ceil((getGlobalStorageValue(item.actionid)-os.time())/60) .." minutes.")
		return true
	end
	dusknoirValidate(cid)
return true
end
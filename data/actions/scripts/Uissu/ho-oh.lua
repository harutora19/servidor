local posf = {{x=1917,y=2049,z=9},{x=1918,y=2049,z=9},{x=1919,y=2049,z=9}}
local toposi = {{x=2005,y=2041,z=10},{x=2005,y=2047,z=10},{x=2005,y=2053,z=10}}
local postop = {x=1897,y=2031,z=10}
local posbot = {x=2018,y=2071,z=10}
local posbosstop = {x=1904,y=2053,z=10}
local posbossbot = {x=1918,y=2069,z=10}
local effect = {27, 28, 79, 84, 85}
local bosspos = {x=1910,y=2053,z=10}
local posf2 = {{x=1908,y=2041,z=10,stackpos=253},{x=1909,y=2041,z=10,stackpos=253},{x=1910,y=2041,z=10,stackpos=253}}
local tobosspos = {x=1910,y=2062,z=10}

local function outPosHooh()
return {x=math.random(1917,1919),y=math.random(2050,2052),z=9}
end

local sto = 42410
local stoT = 42411

local prize = 12227
local rwdexp = 750000
local cd = 60 * 10 -- 10 minutos
local cdWin = 60 * 60 * 12 -- 12 hora
local minPlayers = 3
local timeBetweenWaves = 1000 * 4 -- 4 segundos
function doTeleportThingWithPk(cid, topos)
	if not isCreature(cid) then return false end
	if #getCreatureSummons(cid) > 0 then
		doTeleportThing(getCreatureSummons(cid)[1], topos)
	end
	return doTeleportThing(cid, topos)
end

local players = {}
-- uid, frompos, name

function hoohClean(dead)
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
				local byepos = outPosHooh()
					local namsg = namedead ~= '' and namedead or "Someone"
					doPlayerSendTextMessage(c, MESSAGE_STATUS_CONSOLE_RED, namsg .." died, your team failed the tomb.")
					doTeleportThingWithPk(c, byepos)
				end
			end
		end
	end
	for k,v in pairs(players) do players[k]=nil end
end

local posbarricades = {
{{x=1989,y=2041,z=10},{x=1989,y=2047,z=10},{x=1989,y=2053,z=10},},
{{x=1964,y=2041,z=10},{x=1964,y=2047,z=10},{x=1964,y=2053,z=10},},
{{x=1951,y=2041,z=10},{x=1951,y=2047,z=10},{x=1951,y=2053,z=10},},
}

function hoohSummons()
	for i,v in ipairs(players) do
		for o,p in pairs(posbarricades[i]) do
			doSummonCreature("Fire Barricade", {x=p.x,y=p.y,z=p.z})
			doSummonCreature("Fire Barricade", {x=p.x,y=p.y+1,z=p.z})
			doSummonCreature("Fire Barricade", {x=p.x,y=p.y-1,z=p.z})
			for n=1,i*2 do
				doSummonCreature("Elder Charizard", {x=p.x-2,y=p.y,z=p.z})
			end
		end
		doSendMsg(v.uid, "Ho-Oh: GRRRR!")
		doPlayerSendTextMessage(v.uid, MESSAGE_STATUS_CONSOLE_RED, "[DANGER] Run! Ho-Oh's sacred fire wave is coming at your way. Destroy the Fire Barricades to get though this hallway.")
		local arrowpos = toposi[i]
		arrowpos.x = arrowpos.x-1
		doSendMagicEffect(arrowpos, 410)
		addEvent(doSendMagicEffect,5000,arrowpos, 410)
	end
end

function hoohWave(n)
	if not isCreature(bosshooh) then return true end
	for i,pos in pairs(toposi) do 
		local posstart = {x=pos.x+3,y=pos.y,z=pos.z,stackpos=253}
		for r=0,math.min(80,n) do
			for m=1,3 do
				local posf = {x=math.max(1928,posstart.x-r), y=posstart.y-2+m, z=posstart.z, stackpos=posstart.stackpos}
				doSendMagicEffect(posf, 143)
				local pid = getThingFromPos(posf).uid
				local sacredfiredamage = math.random(5000,7500)
				if isCreature(pid) and not isWild(pid) then
					if getCreatureHealth(pid) < sacredfiredamage then
						doKillPlayer(pid, bosshooh, -sacredfiredamage)
					end
					doCreatureAddHealth(pid, -sacredfiredamage)
					if isSummon(pid) or (isPlayer(pid) and #getCreatureSummons(pid) < 1) then
						doSendAnimatedText(posf, "-".. sacredfiredamage, COLOR_YELLOW)
					end
				end
			end
		end
	end
	addEvent(hoohWave,math.max(1000, timeBetweenWaves - (n * 50)),n+1)
end

function hoohCheckPlayers()
	local nameDead = ""
	for i,v in ipairs(players) do
		if not isPlayer(v.uid) or not isInArea(getThingPos(v.uid), postop, posbot) then
			nameDead = v.name
			break
		end
	end
	if nameDead ~= "" then
		doBroadcastMessage(nameDead .." died and his team failed the Ho-Oh Tomb.")
		for i,v in ipairs(players) do
			doSendMsg(v.uid, "Ho-Oh: GRRRRR!")
			doSendMsg(v.uid, nameDead .." burned to death.")
		end
		hoohClean(nameDead)
		return true
	end
	return addEvent(hoohCheckPlayers, 100)
end

function hoohCheckStage(stage)
	local s = stage
	if isCreature(bosshooh) then
		return addEvent(hoohCheckStage, 5000)
	end
	
	for i,v in pairs(players) do
		if isPlayer(v.uid) then
			doSendMsg(v.uid, "Ho-Oh: KIIIIEEEEAAAAaaAa!")
			if getPlayerStorageValue(v.uid, sto) ~= 1 then
				setPlayerStorageValue(v.uid, sto, 1)
				local bag = doCreateItemEx(12684)
				addItemInFreeBag(bag, 17244, 1) -- stamina 2h
				addItemInFreeBag(bag, 17204, 1) -- tm box b
				addItemInFreeBag(bag, 6569, 25) -- rare candy
				addItemInFreeBag(bag, 15644, 25) -- mighty token
				addItemInFreeBag(bag, 15646, 5) -- honored token
				doPlayerAddItemEx(v.uid, bag)
				
				addEvent(doSendMsg, 5000, v.uid, "You've received a reward.")
				addEvent(addExpByStages, 5000, v.uid, rwdexp * 4, true)
			end
			doPlayerAddItem(v.uid, 17206, 1) -- tm box d
			doPlayerAddItem(v.uid, 6569, 50)
			setPlayerStorageValue(v.uid, stoT, os.time() + cdWin)
			addEvent(addExpByStages, 5000, v.uid, rwdexp, true)
			local byepos = outPosHooh()
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
	addEvent(hoohClean, 5001)
end

god = getPlayerByName("[*] Uissu")

function getPlayerFromPos2(pos)
	for i,p in pairs(getPlayersOnline()) do
		local ppos = getThingPos(p)
		if ppos.x == pos.x and ppos.y == pos.y and ppos.z == pos.z then
			return p
		end
	end
	return 0
end

function hoohValidate(cid)
	hoohClean()
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
		doBroadcastMessage(getCreatureName(cid).."'s team is going to challenge the Legendary Ho-Oh!")
		hoohStart()
	end
	return true
end

function hoohStart()
	setGlobalStorageValue(sto, os.time() + cd)
	for i,v in pairs(players) do
		doTeleportThingWithPk(v.uid, toposi[i])
		doSendMsg(v.uid, "Ho-Oh: ?!")
	end
	bosshooh = doSummonCreature("Ho-Oh", bosspos)
	addEvent(hoohCheckStage, 5000, 1)
	hoohSummons()
	addEvent(hoohWave,timeBetweenWaves * 2, 1)
	return hoohCheckPlayers()
end

function onUse(cid, item, frompos, item2, topos)

	if item.actionid == 42410 then
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
		hoohValidate(cid)
	elseif item.actionid == 42411 then
		doTeleportThingWithPk(cid, {x=1914,y=2040,z=10})
	elseif item.actionid == 42412 then
		local teleme = {}
		for _,pp in pairs(posf2) do
			local chid = getThingFromPos(pp).uid
			if not isPlayer(chid) then
				doSendMsg(cid, "You can't go alone. Wait for your friends!")
				return true
			end
			table.insert(teleme, chid)
		end
		for vi,vuid in pairs(teleme) do doTeleportThingWithPk(vuid, tobosspos) end
	end
return true
end
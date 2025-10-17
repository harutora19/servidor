local posf = {{x=1988,y=1996,z=9},{x=1991,y=1996,z=9},{x=1986,y=1998,z=9},{x=1993,y=1998,z=9},{x=1986,y=2001,z=9},{x=1993,y=2001,z=9},{x=1988,y=2003,z=9},{x=1991,y=2003,z=9}}
local postop = {x=1963,y=1982,z=10}
local posbot = {x=2017,y=2019,z=10}
local arenatop = {x=1984,y=1995,z=10}
local arenabot = {x=1995,y=2004,z=10}
local effect = {27, 28, 79, 84, 85}

function outPos()
return {x=math.random(1989,1991),y=math.random(1998,2000),z=9}
end

local sto = 42405
local stoT = 42408

function mewtwoPrize(cid)
	local bag = doCreateItemEx(12682)
	for itemid=11441,11454 do
		addItemInFreeBag(bag, itemid, 32)
	end
	addItemInFreeBag(bag, 12417, 32)
	addItemInFreeBag(bag, 12232, 16)
	addItemInFreeBag(bag, 12244, 16)
	addItemInFreeBag(bag, 12618, 8)
	addItemInFreeBag(bag, 15644, 50)
	addItemInFreeBag(bag, 12227, 1)
	doPlayerAddItemEx(cid, bag)
	setPlayerStorageValue(cid, 100118, 1)
end

local rwdexp = 500000
local cd = 60 * 10 -- 10 minutos
local cdWin = 60 * 60 * 3 -- 3 horas

function doTeleportThingWithPk(cid, topos)
	if not isCreature(cid) then return false end
	if #getCreatureSummons(cid) > 0 then
		doTeleportThing(getCreatureSummons(cid)[1], topos)
	end
	return doTeleportThing(cid, topos)
end

local varT = {
['seavell'] = {pos={x=1995,y=1987,z=10},pk={"Elder Tangela", "Elder Electabuzz"}},
['gardestrike'] = {pos={x=2002,y=1994,z=10},pk={"Elder Pidgeot", "Elder Gengar"}},
['wingeon'] = {pos={x=2002,y=2005,z=10},pk={"Elder Tyranitar", "Elder Dragonite"}},
['raibolt'] = {pos={x=1995,y=2012,z=10},pk={"Elder Marowak", "Elder Venusaur"}},
['orebound'] = {pos={x=1984,y=2012,z=10},pk={"Elder Blastoise", "Elder Pidgeot"}},
['malefic'] = {pos={x=1977,y=2005,z=10},pk={"Master Alakazam", "Elder Pinsir"}},
['psycraft'] = {pos={x=1968,y=1999,z=10},pk={"Elder Pinsir", "Elder Gengar"}},
['volcanic'] = {pos={x=1977,y=1994,z=10},pk={"Elder Blastoise", "Elder Tentacruel"}},
['naturia'] = {pos={x=1984,y=1987,z=10},pk={"Elder Dragonite", "Elder Charizard"}},

['ironhard'] = {pos={x=2011,y=1999,z=10},pk={"Elder Charizard", "Elder Marowak"}},
}

local players = {}
-- uid, frompos, clan, name

function mewtwoClean(dead)
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
				local byepos = outPos()
					local namsg = namedead ~= '' and namedead or "Someone"
					doPlayerSendTextMessage(c, MESSAGE_STATUS_CONSOLE_RED, namsg .." died, your team failed the raid.")
					doTeleportThingWithPk(c, byepos)
				end
			end
		end
	end
	for k,v in pairs(players) do players[k]=nil end
end

function mewtwoCheckPlayers()
	local nameDead = ""
	for i,v in ipairs(players) do
		if not isPlayer(v.uid) or not isInArea(getThingPos(v.uid), postop, posbot) then
			nameDead = v.name
			break
		end
	end
	if nameDead ~= "" then
		doBroadcastMessage(nameDead .." died and his team failed the Legendary Mewtwo Raid.")
		for i,v in ipairs(players) do
			doSendMsg(v.uid, "Mewtwo: MUAHAHAHA! ".. nameDead .."'s soul is mine now. Good bye, fools!")
		end
		mewtwoClean(nameDead)
		return true
	end
	return addEvent(mewtwoCheckPlayers, 100)
end

function mewtwoCheckStage(stage)
	local s = stage
	for x=postop.x,posbot.x do
		for y=postop.y,posbot.y do
			for stack=250,255 do
				local checkpos = {x=x,y=y,z=postop.z,stackpos=stack}
				local c = getThingFromPos(checkpos).uid
				if isCreature(c) and not isSummon(c) and not isPlayer(c) then
					return addEvent(mewtwoCheckStage, 5000, s)
				end
			end
		end
	end
	s = s+1
	if s == 2 then
		for i,v in pairs(players) do
			local t = varT[v.clan]
			local newpos = v.frompos
			newpos.z = newpos.z+1
			doTeleportThingWithPk(v.uid, newpos)
			doSendMsg(v.uid, "Mewtwo: Getting harder? HAHA! This time you'll be deafeted.")
			doSummonCreature(t.pk[1], newpos)
			doSummonCreature(t.pk[2], newpos)
			doSummonCreature(t.pk[1], newpos)
			doSummonCreature(t.pk[2], newpos)
		end
		addEvent(mewtwoCheckStage, 5000, s)
	elseif s == 3 then
		for i,v in pairs(players) do
			doSendMsg(v.uid, "Mewtwo: It's time for the REAL CHALLENGE...")
			doPlayerSendTextMessage(v.uid, MESSAGE_STATUS_CONSOLE_RED, "Mewtwo is spawning in 5 seconds.")
		end
		addEvent(doSummonCreature,5000,"Mewtwo", {x=1989,y=1999,z=10})
		addEvent(mewtwoCheckStage, 5000, s)
	elseif s == 4 then
		for i,v in pairs(players) do
			local t = varT[v.clan]
			if isPlayer(v.uid) then
				doSendMsg(v.uid, "Mewtwo: NOOOOOOOO!")
				if getPlayerStorageValue(v.uid, sto) ~= 1 then
					setPlayerStorageValue(v.uid, sto, 1)
					mewtwoPrize(v.uid)
					addEvent(doSendMsg, 5000, v.uid, "Congratulations for winning Mewtwo's Challenge. You've received a prize backpack.")
					addEvent(addExpByStages, 5000, v.uid, rwdexp * 4, true)
				end
				doPlayerAddItem(v.uid, 6569, 50)
				setPlayerStorageValue(v.uid, stoT, os.time() + cdWin)
				addEvent(addExpByStages, 5000, v.uid, rwdexp, true)
				local byepos = outPos()
				addEvent(doTeleportThingWithPk, 5000, v.uid, byepos)
				addEvent(doSendMagicEffect, 5000, byepos, effect[math.random(1,#effect)])
			end
		end
		for x=arenatop.x,arenabot.x do
			for y=arenatop.y,arenabot.y do
				local effpos = {x=x,y=y,z=arenatop.z}
				if math.random(1,5) == 1 then
					addEvent(doSendMagicEffect, math.random(0,4000), effpos, effect[math.random(1,#effect)])
				end
			end
		end
		addEvent(mewtwoClean, 5001)
	end
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

function mewtwoValidate(cid)
	mewtwoClean()
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
			
				local uid, frompos, clan, name = pid, cpos, getPlayerClanName(pid):lower(), getCreatureName(pid)
				if clan == "Pokemon Trainer" then doSendMsg(cid, name.." is a ".. clan ..".") return false end
				if getPlayerStorageValue(pid, stoT) > os.time() then doSendMsg(cid, name.." is on cooldown. Wait ".. math.ceil((getPlayerStorageValue(pid, stoT) - os.time())/60) .." minutes to go again!") return false end
				if getPlayerLevel(pid) < 200 then doSendMsg(cid, name.."'s level is not high enough.") return false end
				if getPlayerClanRank(pid) ~= 5 then doSendMsg(cid, name.." is not ranked enough.") return false end
				if not isGod(cid) and tmpC[clan] and tmpC[clan] ~= pid then doSendMsg(cid, "You can only have one player of each clan. (".. getCreatureName(tmpC[clan]) .." and ".. getCreatureName(pid) .." are both ".. clan .."s)") return false end
				table.insert(tmpP, {uid=uid,frompos=frompos,clan=clan,name=name})
				tmpC[clan] = pid
			end
	end
	if #tmpP < minPlayers then
		doSendMsg(cid, "You need at least ".. minPlayers .." players. (".. #tmpP .."/".. minPlayers ..")")
		return false
	else
		for i,v in pairs(tmpP) do
			players[i] = v
		end
		doBroadcastMessage(getCreatureName(cid).."'s team is going to challenge the Legendary Mewtwo!")
		mewtwoStart()
	end
	return true
end

function mewtwoStart()
	setGlobalStorageValue(sto, os.time() + cd)
	for i,v in pairs(players) do
		local t = varT[v.clan]
		doTeleportThingWithPk(v.uid, t.pos)
		doSendMsg(v.uid, "Mewtwo: You'll never get past my creatures, you fools!")
		doSummonCreature(t.pk[1], t.pos)
		doSummonCreature(t.pk[2], t.pos)
	end
	addEvent(mewtwoCheckStage, 5000, 1)
	return mewtwoCheckPlayers()
end

function onUse(cid, item, frompos, item2, topos)
	minPlayers = 4

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
	mewtwoValidate(cid)
			
return true
end
local statues = {
[11680] = {name = "Articuno", pos1 = {x=2275,y=3221,z=8}, pos2={x=2310,y=3253,z=8}},
[11678] = {name = "Zapdos", pos1 = {x=2325,y=3221,z=8}, pos2={x=2362,y=3253,z=8}},
[11679] = {name = "Moltres", pos1 = {x=2372,y=3221,z=8}, pos2={x=2408,y=3253,z=8}},
}

local aidgo = 42403
local aidback = 42404
local exprwd = 250000

function getGlobalStorage2(str)
	local q = db.getResult("SELECT * FROM `global_storage` WHERE `key` = ".. str .."")
	if q:getID() ~= -1 then
		return q:getDataInt("value")
	end
	return -1
end

function setGlobalStorage2(str, value)
	if getGlobalStorage2(str) ~= -1 then
		db.executeQuery("UPDATE `global_storage` SET `value` = ".. value .." WHERE `key` = ".. str ..";")
	else
		db.executeQuery("INSERT INTO `global_storage` (`key`, `world_id`, `value`) VALUES (".. str ..", 0, ".. value ..");")
	end
end

function doTeleportThingWithPk(cid, topos)
	if not isCreature(cid) then return false end
	if #getCreatureSummons(cid) > 0 then
		doTeleportThing(getCreatureSummons(cid)[1], topos)
	end
	return doTeleportThing(cid, topos)
end

function isBirdAlive(itemid)
	local t = statues[itemid]
	if not t then return false end
	for x=t.pos1.x,t.pos2.x do
		for y=t.pos1.y,t.pos2.y do
			for stack=250,255 do
				local checkpos = {x=x,y=y,z=t.pos1.z,stackpos=stack}
				local c = getThingFromPos(checkpos).uid
				if isCreature(c) and getCreatureName(c) == t.name then
					return true
				end
			end
		end
	end
	return false
end

function onUse(cid, item, frompos, item2, topos)
	local cooldown = 60 * math.random(120,300) -- 1 ~ 5 horas

	if getPlayerLevel(cid) < 150 then
		doSendMsg(cid, "Your level is too low.")
		return true
	end
		
	if item.actionid == aidgo then
		if isGod(cid) and getGlobalStorage2(item.itemid) > 0 then
			setGlobalStorage2(item.itemid, 0)
			doSendMsg(cid, "Global Storage Value ".. item.itemid .." reset.")
			return true
		end
		if getGlobalStorage2(item.itemid) > os.time() then
			doSendMsg(cid, "".. statues[item.itemid].name .." has flew away. Come back in ".. math.ceil((getGlobalStorage2(item.itemid)-os.time())/60) .." minutes to see it again.")
			return false
		end
		local toposgo = {x=frompos.x,y=frompos.y-6,z=frompos.z}
		local toposs = {x=frompos.x,y=frompos.y-18,z=frompos.z}
		if not isBirdAlive(item.itemid) then
			doBroadcastMessage("Legendary Bird ".. statues[item.itemid].name .." has been awaken by ".. getCreatureName(cid) .."!")
			doSummonCreature(statues[item.itemid].name, toposs)
		end
		doTeleportThingWithPk(cid, toposgo)
		return true
	elseif item.actionid == aidback then
		if isBirdAlive(item.itemid) then
			doSendMsg(cid, "You can't leave until the boss is defeated!")
			return false
		end
		doSendMsg(cid, "Congratulations for defeating ".. statues[item.itemid].name .."! Come back in ".. math.ceil(cooldown/3600) .." hour(s) if you dare.")
		addExpByStages(cid, exprwd, true)
		doTeleportThingWithPk(cid, getTownTemplePosition(getPlayerTown(cid)))
		setGlobalStorage2(item.itemid, os.time() + cooldown)
	end
			
return true
end
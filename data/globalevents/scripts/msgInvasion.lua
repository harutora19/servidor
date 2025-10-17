function removeTpInvasion(pos)
	local t = getTileItemById(pos, 1387)
	if t then
		doRemoveItem(t.uid, 1)
		doSendMagicEffect(pos, 3)
	end
end

function onTimer(cid, interval, lastExecution)
	doBroadcastMessage("Um portal Dimensional foi aberto em frente ao CP, e um BOSS foi spawnado, corram para proteger nossa dimensão.")
	doCreateTeleport(1387,{x=125,y=880,z=6},{x=1017,y=1020,z=7})
	addEvent(removeTpInvasion, 20 * 60 * 1000, {x=1017,y=1020,z=7})
return true
end


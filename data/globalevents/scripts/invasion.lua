function onTimer(cid, interval, lastExecution)
	doCreateMonster("Darkrai", {x = 127, y = 866, z = 6})
	doBroadcastMessage("Um BOSS acabou de aparecer na BOSS ARENA, vão matá-lo, e ganhem recompensas.")
	-- doCreateTeleport(1387,{x=1020,y=1020,z=7},{x=125,y=880,z=6})
	-- doCreateTeleport(1387,{x=125,y=880,z=6},{x=1020,y=1020,z=7})
return true
end
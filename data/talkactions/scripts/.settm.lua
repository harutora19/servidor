function onSay(cid, words, param, channel)
	local ball = getPlayerSlotItem(cid, 8)
	local p = param:explode(",")
	
	if not p[5] then
		doSendMsg(cid, "/settm TMName (ex: Absorb), Slot (1-12), Cooldown (seconds), Target (1/0), Dist (0-14), Strenght (ex: 120)")
	else
		doSendMsg(cid, "TM-"..p[1].." set on m"..p[2]..". Cooldown: "..p[3].." seconds, Strenght: "..p[6]..".")
		doSetBallTM(ball.uid, p[1], tonumber(p[2]), tonumber(p[3]), tonumber(p[4]), tonumber(p[5]), tonumber(p[6]))
	end
	--doPlayerAddRandomTM(cid, "A")
	return true
end
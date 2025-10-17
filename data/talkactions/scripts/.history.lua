function onSay(cid, words, param, channel)

	local tid = getPlayerByName(param)
	
	local tpk = {}
	if isPlayer(tid) then
		local q = db.getResult("SELECT * FROM `player_balls` WHERE `playername` = '".. param .."';")
		if q:getID() ~= -1 then
			repeat
				table.insert(tpk, {bim = q:getDataInt('bim'), pokename = q:getDataString('pokename'), boost = q:getDataInt('boost'), heldx = q:getDataString('heldx'), heldy = q:getDataString('heldy'), lastowner = q:getDataString('lastowner')})
			until q:next() == false
		end
		if #tpk > 0 then
			doSendMsg(cid, "** History for ".. doCorrectString(param))
			for i,v in pairs(tpk) do
				doSendMsg(cid, "> Bim: ".. v.bim .." | Pokemon: ".. v.pokename .." (+"..v.boost..")("..v.heldx.."|"..v.heldy..") | Previous owner: ".. v.lastowner)
			end
		end
	else
		doSendMsg(cid, "Player ".. param .." is not online.")
	end

	return true
end

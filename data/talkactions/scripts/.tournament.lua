function onSay(cid, words, param, channel)
 
	local param = string.explode(param, ",")
	
	if words == "!tour" or words == "/tour" then
		if param and param[1] == "join" then
			tourJoin(cid)
		elseif param and param[1] == "start" and isGod(cid) and param[2] then
			tourStart1(tonumber(param[2]), tonumber(param[3]) or 200, tonumber(param[4]) or 500)
		elseif param and param[1] == "check" then
			tourCheck(cid)
		elseif param and param[1] == "next" and isGod(cid) then
			setGlobalStorageValue(838383, 2)
			doSendMsg(cid, "Proceed tournament...")
			tourNext()
		elseif param and param[1] == "reset" and isGod(cid) then
			setGlobalStorageValue(838383, -1)
			doSendMsg(cid, "Global Storage reset.")
		elseif param and param[1] == "setlv" and isGod(cid) and param[2] and param[3] then
			setGlobalStorageValue(838385, param[2])
			setGlobalStorageValue(838387, param[3])
			doSendMsg(cid, "Lmin set to ".. param[2] .." lmax set to ".. param[3] ..".")
		end
	end
	
	
    return true
end
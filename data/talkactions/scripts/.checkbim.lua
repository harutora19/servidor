function onSay(cid, words, param, channel)
 
	local t = {}
	
	for _,pid in pairs(getPlayersOnline()) do
		for i,item in pairs(getPlayerPokeballs(pid)) do
			local bim = getItemAttribute(item.uid, "bim")
			if bim then
				--doSendMsg(cid, bim)
				if not t[bim] then t[bim] = {poke=getItemAttribute(item.uid, "poke")} end
				--table.insert(t[bim], {['name']=getCreatureName(pid),['poke']=getItemAttribute(item.uid, "poke")})
				table.insert(t[bim], getCreatureName(pid))
				--doSendMsg(cid, t[bim])
			end
		end
	end
	
	if param ~= "dupe" then
		doSendMsg(cid, "List of registered balls:")
		for i,v in pairs(t) do
			local str = "["..i.."]: "
			for x,name in pairs(v) do
				str = str .. name
			end
			doSendMsg(cid, str)
		end
	else
		doSendMsg(cid, "List of clones found:")
		for i,v in pairs(t) do
			if #v > 1 then
				local str = "["..i.." / "..v.poke.."]: "
				for x,name in pairs(v) do
					if name ~= v.poke then
						str = str .. name .. (x == #v and "." or ", ")
					end
				end
				doSendMsg(cid, str)
			end
		end
	end
	
    return true
end
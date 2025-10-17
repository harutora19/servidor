function onSay(cid, words, param, channel)

	local file = io.open("data/moves/"..doCorrectString(param)..".txt", "r")
	if file then
		local pokes = {}
		table.insert(pokes, "List of pokemon that can learn technical machine ".. doCorrectString(param) ..":\n")
		for line in file:lines() do
			if not line:find("Alola Form") then
				table.insert(pokes, line.."\n")
			end
		end
		doShowTextDialog(cid, tmSprites[getMoveTypeByName(doCorrectString(param))], table.concat(pokes))
	else
		doPlayerSendCancel(cid, doCorrectString(param).." is not a known technical machine.")	
	end	
	return true
end

function onSay(cid, words)
	if getCreatureOutfit(cid).lookType == 3343 then
		doSetCreatureOutfit(cid, 3347, -1)
	end
return true
end
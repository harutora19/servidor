function onSay(cid, words, param)
	-- if param == "outfit rainbow" then
		for _,oid in pairs(getPlayersOnline()) do
			doSendPlayerExtendedOpcode(cid, 124, "Party")
		end
	-- end
return true
end
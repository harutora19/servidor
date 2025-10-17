function onSay(cid, words, param)
	for s=30019,30025 do
		setPlayerStorageValue(cid, s, -1)
		doSendMsg(cid, "Storage: "..s.." set to -1.")
	end
return TRUE
end
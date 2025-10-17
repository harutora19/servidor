function onUse(cid, item, frompos, item2, topos)
	-- if item.itemid == 12330 then
		if isInChannelsArray(cid) then 
			doSendMsg(cid, "Você já tem um canal aberto.") 
			return true 
		end
		doCreateChannelTVs(cid)
	-- end
end
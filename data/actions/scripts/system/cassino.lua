function onUse(cid)
	if getPlayerItemCount(cid, 2161) >= 5 then
		if doPlayerRemoveItem(cid, 2161, 5) then
			doPlayerRollMachine(cid)
			return true
		end
	else
		doPlayerSendTextMessage(cid, 27, "Você precisa de 5kk para poder apostar no cassino.")
	return true
	end
return true
end 
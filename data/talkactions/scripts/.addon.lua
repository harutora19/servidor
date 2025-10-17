function onSay(cid, words, param)
     
	local pb = getPlayerSlotItem(cid, 8).uid
	local pos = tonumber(param)
	
    if #getCreatureSummons(cid) >= 1 then
	   doPlayerSendCancel(cid, "Volte seu pokemon para a pokebola antes de trocar o addon.")
       return true                                                                                                                        
    end
	
	if not pos then
		doPlayerSendCancel(cid, "O numero do Addon deve ser um valor entre 0 e " ..ADDON_LIMIT.. ".")
		return true
	end

	if pos >= 0 and pos <= ADDON_LIMIT then
		doSetItemAttribute(pb, "current_addon", pos)
	end
	return true
end
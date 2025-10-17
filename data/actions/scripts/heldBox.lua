local heldRandom = {15561,13971,13964,13943,15638,15631,15617,15610,15603}

function onUse(cid, item)
	if doRemoveItem(item.uid, 1) then
		doPlayerAddItem(cid, heldRandom[math.random(1, #heldRandom)], 1) 
	return true
	end	
return true
end
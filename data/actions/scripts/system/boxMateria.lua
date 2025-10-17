function onUse(cid, item, item2)
	if doRemoveItem(item.uid, 1) then
		doPlayerAddItem(cid, math.random(17266, 17275), 1)
	end
return true
end
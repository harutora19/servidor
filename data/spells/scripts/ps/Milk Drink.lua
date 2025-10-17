function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Milk Drink")
return true
end
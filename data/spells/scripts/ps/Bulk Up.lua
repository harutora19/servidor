function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Bulk Up")
return true
end
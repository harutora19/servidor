function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Gastro Acid")
return true
end
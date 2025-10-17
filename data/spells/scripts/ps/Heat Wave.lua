function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Heat Wave")
return true
end
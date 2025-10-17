function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Acrobatics")
return true
end
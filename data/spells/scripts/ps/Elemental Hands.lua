function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Elemental Hands")
return true
end
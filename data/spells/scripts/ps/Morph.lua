function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Morph")
return true
end
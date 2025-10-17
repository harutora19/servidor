function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Poison Tail")
return true
end
function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Blast Burn")
return true
end
function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Vacuum Wave")
return true
end
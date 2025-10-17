function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Brine")
return true
end
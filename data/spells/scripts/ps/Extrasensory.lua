function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Extrasensory")
return true
end
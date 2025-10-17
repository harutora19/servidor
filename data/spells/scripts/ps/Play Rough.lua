function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Play Rough")
return true
end
function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Ominous Wind")
return true
end
function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Psycho Cut")
return true
end
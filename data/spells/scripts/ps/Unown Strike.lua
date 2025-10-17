function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Unown Strike")
return true
end
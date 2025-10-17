function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Heavy Metal")
return true
end
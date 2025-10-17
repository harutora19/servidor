function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "High Jump Kick")
return true
end
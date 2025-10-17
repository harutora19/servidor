function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Flare Blitz")
return true
end
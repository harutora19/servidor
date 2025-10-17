function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Signal Beam")
return true
end
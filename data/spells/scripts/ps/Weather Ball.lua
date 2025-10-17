function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Weather Ball")
return true
end
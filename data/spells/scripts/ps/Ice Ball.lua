function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Ice Ball")
return true
end
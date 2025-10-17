function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Magnitude")
return true
end
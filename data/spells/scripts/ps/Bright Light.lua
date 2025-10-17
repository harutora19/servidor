function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Bright Light")
return true
end
function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Hail")
return true
end
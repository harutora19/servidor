function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Nasty Plot")
return true
end
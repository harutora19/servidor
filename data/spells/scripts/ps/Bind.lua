function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Bind")
return true
end
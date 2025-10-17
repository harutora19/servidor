function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Stampage")
return true
end
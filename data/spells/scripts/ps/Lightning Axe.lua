function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Lightning Axe")
return true
end
function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Cannon Ball")
return true
end
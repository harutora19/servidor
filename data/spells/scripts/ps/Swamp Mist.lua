function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Swamp Mist")
return true
end
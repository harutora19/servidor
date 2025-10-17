function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Dragon Mist")
return true
end
function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Magma Fist")
return true
end
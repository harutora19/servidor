function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Eerie Impulse")
return true
end
function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Croak Hook")
return true
end
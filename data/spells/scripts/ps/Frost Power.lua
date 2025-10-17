function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Frost Power")
return true
end
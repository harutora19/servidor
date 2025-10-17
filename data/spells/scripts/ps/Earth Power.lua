function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Earth Power")
return true
end
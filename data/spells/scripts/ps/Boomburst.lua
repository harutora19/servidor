function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Boomburst")
return true
end
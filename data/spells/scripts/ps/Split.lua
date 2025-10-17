function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Split")
return true
end
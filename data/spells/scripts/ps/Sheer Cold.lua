function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Sheer Cold")
return true
end
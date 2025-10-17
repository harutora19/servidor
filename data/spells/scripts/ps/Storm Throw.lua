function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Storm Throw")
return true
end
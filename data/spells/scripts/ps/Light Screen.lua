function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Light Screen")
return true
end
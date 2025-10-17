function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Super vine whip")
return true
end
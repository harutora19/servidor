function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Heavy Slam")
return true
end
function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Flying Kick")
return true
end
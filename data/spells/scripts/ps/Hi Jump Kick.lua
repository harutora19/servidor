function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Hi Jump Kick")
return true
end
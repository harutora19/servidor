function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Sky Uppercut")

return true
end
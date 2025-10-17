function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Dragon Tail")

return true
end
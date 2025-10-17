function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Gelo Grande")

return true
end
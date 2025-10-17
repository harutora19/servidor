function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Fogo Pequeno")

return true
end
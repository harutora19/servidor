function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Raio Pequeno")

return true
end
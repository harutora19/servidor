function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Raio Grande")

return true
end
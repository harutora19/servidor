function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Fogo Grande")

return true
end
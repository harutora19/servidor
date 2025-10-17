function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Powder Snow")

return true
end
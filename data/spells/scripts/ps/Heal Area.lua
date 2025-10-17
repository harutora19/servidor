function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Heal Area")

return true
end
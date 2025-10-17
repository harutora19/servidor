function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Grass Knot")

return true
end
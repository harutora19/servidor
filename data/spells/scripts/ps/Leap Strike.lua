function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Leap Strike")

return true
end
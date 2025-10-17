function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Reversal")

return true
end
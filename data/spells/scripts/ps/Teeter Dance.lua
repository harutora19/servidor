function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Teeter Dance")

return true
end
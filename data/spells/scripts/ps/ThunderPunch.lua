function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "ThunderPunch")

return true
end
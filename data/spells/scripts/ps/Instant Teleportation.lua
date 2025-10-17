function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Instant Teleportation")
return true
end
function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Flash Cannon")
return true
end
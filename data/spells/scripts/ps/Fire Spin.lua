function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Fire Spin")
return true
end
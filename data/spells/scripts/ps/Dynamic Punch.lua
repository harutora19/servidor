function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Dynamic Punch")
return true
end
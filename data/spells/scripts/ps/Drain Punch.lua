function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Drain Punch")
return true
end
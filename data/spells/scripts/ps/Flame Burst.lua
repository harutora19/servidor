function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Flame Burst")
return true
end
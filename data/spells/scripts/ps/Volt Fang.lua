function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Volt Fang")
return true
end
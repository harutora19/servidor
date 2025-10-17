function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Nastly Plot")
return true
end
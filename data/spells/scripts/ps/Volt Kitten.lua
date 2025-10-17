function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Volt Kitten")
return true
end
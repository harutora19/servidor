function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Massive Vines")
return true
end
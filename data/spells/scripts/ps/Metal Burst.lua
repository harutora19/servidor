function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Metal Burst")
return true
end
function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Discharge")
return true
end
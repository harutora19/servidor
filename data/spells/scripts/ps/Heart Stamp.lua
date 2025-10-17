function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Heart Stamp")
return true
end
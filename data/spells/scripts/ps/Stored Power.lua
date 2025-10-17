function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Stored Power")
return true
end
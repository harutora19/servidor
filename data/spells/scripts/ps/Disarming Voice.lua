function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Disarming Voice")
return true
end
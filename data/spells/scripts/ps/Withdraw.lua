function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Withdraw")
return true
end
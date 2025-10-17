function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Gunk Shot")
return true
end
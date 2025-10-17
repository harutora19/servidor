function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Ground Collapse")
return true
end
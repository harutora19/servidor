function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Web Rain")
return true
end
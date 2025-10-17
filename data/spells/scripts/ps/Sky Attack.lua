function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Sky Attack")
return true
end
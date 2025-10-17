function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Volcano Shot")
return true
end
function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Moonlight")
return true
end
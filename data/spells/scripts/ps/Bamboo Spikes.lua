function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Bamboo Spikes")
return true
end
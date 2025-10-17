function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Crow Swarm")
return true
end
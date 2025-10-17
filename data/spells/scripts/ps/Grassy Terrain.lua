function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Grassy Terrain")
return true
end
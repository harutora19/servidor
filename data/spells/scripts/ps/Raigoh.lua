function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Raigoh")
return true
end
function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Stampade")
return true
end
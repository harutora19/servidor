function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Vine Grap")
return true
end
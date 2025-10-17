function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Wood Hammer")
return true
end
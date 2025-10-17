function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Healing Wish")
return true
end
function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Brick Break")
return true
end
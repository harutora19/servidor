function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Spider Web")
return true
end
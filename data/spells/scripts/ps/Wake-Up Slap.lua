function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Wake-Up Slap")
return true
end
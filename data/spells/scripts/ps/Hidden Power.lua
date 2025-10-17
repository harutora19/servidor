function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Hidden Power")
return true
end
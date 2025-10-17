function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Shadow Claw")
return true
end
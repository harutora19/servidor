function onCastSpell(cid, var)
	if isSummon(cid) then return true end

	docastspell(cid, "Bullet Punch")
return true
end
function onCastSpell(cid, var)

	if isSummon(cid) then return true end

	docastspell(cid, "Bubbleblast")

return true
end
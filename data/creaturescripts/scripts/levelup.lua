local configuracao = {
efeito = {28, 29}, 		-- Efeito que vai mandar ao avançar de level.
texto = "Level up!", 	-- Texto que vai aparecer ao avançar de level.
cortexto = 215		-- Cor do texto, sendo o número entre 1 e 254.
}

function onAdvance(cid, skill, oldLevel, newLevel)
	if skill ~= 8 then return true end
	if newLevel >= 11 and newLevel <= 400 then doPlayerSetLossPercent(cid, PLAYERLOSS_EXPERIENCE, math.floor(newLevel/4)) end   --alterado v1.8
	
	doRegainSpeed(cid)
	doSendMagicEffect({x=getThingPos(cid).x+1, y=getThingPos(cid).y, z=getThingPos(cid).z}, 415)
	-- local color = 0
	-- if configuracao.texto then
    -- if configuracao.cortexto ~= 0 then
		-- color = configuracao.cortexto
    -- else
		-- color = math.random(1, 254)
    -- end
		-- doSendAnimatedText(getThingPos(cid), configuracao.texto, color)
	-- end
	local s = getCreatureSummons(cid)
	local item = getPlayerSlotItem(cid, 8)
    doCreatureAddHealth(cid, getCreatureMaxHealth(cid))
	if #getCreatureSummons(cid) > 0 then
		doCreatureAddHealth(getCreatureSummons(cid)[1], getCreatureMaxHealth(getCreatureSummons(cid)[1]))
	end
    doSendMagicEffect(getThingPos(cid), 132)
	if newLevel == 351 then
		doPlayerAddExp(cid, 6107601)
	end	
return true
end
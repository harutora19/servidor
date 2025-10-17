function onSay(cid, words, param)
	number = tonumber(param)
	if getItemAttribute(getPlayerSlotItem(cid, 8).uid, "premier") == 1 then
		if number == 0 then
			local pk = getCreatureSummons(cid)[1]
			doSetAura(pk, colorAuras.AuraDefault)
		elseif number == 1 then
			local pk = getCreatureSummons(cid)[1]
			doSetAura(pk, colorAuras.AuraVermelha)
		elseif number == 2 then
			local pk = getCreatureSummons(cid)[1]
			doSetAura(pk, colorAuras.AuraVerde)
		elseif number == 3 then
			local pk = getCreatureSummons(cid)[1]
			doSetAura(pk, colorAuras.AuraAzul)
		elseif number == 4 then
			local pk = getCreatureSummons(cid)[1]
			doSetAura(pk, colorAuras.AuraAmarela)
		elseif number == 5 then
			local pk = getCreatureSummons(cid)[1]
			doSetAura(pk, colorAuras.AuraCiano)
		elseif number == 6 then
			local pk = getCreatureSummons(cid)[1]
			doSetAura(pk, colorAuras.AuraBlack)
		elseif number == 7 then
			local pk = getCreatureSummons(cid)[1]
			doSetAura(pk, colorAuras.AuraBranca)
		elseif number == 8 then
			local pk = getCreatureSummons(cid)[1]
			doSetAura(pk, colorAuras.AuraColorful)
		elseif number == 9 then
			local pk = getCreatureSummons(cid)[1]
			doSetAura(pk, colorAuras.AuraLaranja)
		elseif number == 10 then
			local pk = getCreatureSummons(cid)[1]
			doSetAura(pk, colorAuras.AuraRosa)
		elseif number == 11 then
			local pk = getCreatureSummons(cid)[1]
			doSetAura(pk, colorAuras.AuraRoxa)			
		end
	end
return true
end

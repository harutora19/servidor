function onUse(cid, item, frompos, item2, topos)
	-- doSendAnimatedText(getThingPosWithDebug(cid), "CUREI MEUS POKE DESGRAÃ‡A", 65)

if getPlayerStorageValue(cid, 9211) > os.time() then
	-- selfSay("We can't heal your pokemons so fast. Please wait a second!")
		doPlayerSendTextMessage(cid, 27, "Espere um um pouco, você está clicando muito rápido.")
	return true
   	end

	if not getTileInfo(getThingPos(cid)).protection then
		doPlayerSendTextMessage(cid, 27, "Você só pode curar seus pokémons se estiver em PZ.")
	return true
	end
	
	if isInDuel(cid) then
	   -- selfSay("We can't heal your pokemons while you're in a duel.")   --alterado v1.6.1
	   doPlayerSendTextMessage(cid, 27, "Você não pode curar seus pokémons enquanto está em Duelo.")
    return true 
    end
    

	setPlayerStorageValue(cid, 9211, os.time()+5)
	doCreatureAddHealth(cid, getCreatureMaxHealth(cid)-getCreatureHealth(cid))
	-- doCureStatus(cid, "all", true)
	doClearPokemonStatus(cid)
	doSendMagicEffect(getThingPos(cid), 264)
	local mypb = getPlayerSlotItem(cid, 8)
	doSetItemAttribute(mypb.uid, "hpToDraw", 0)
	if isRiderOrFlyOrSurf(cid) then 
		demountPokemon(cid, true)
		doRemoveCondition(cid, CONDITION_OUTFIT)
		doRegainSpeed(cid)
	end
	local s = getCreatureSummons(cid)
	local healthMax = 0
	if #s >= 1 then
		healthMax = getCreatureMaxHealth(s[1])
		doReturnPokemon(cid, s[1], mypb, pokeballs[getPokeballType(mypb.itemid)].effect)
		doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_POKEMON_HEALTH, healthMax.."|"..healthMax)
	end
	if mypb.itemid ~= 0 and isPokeball(mypb.itemid) then  --alterado v1.3
		doSetItemAttribute(mypb.uid, "hpToDraw", 0)
		doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_POKEMON_HEALTH, getBallMaxHealth(cid, mypb).."|"..getBallMaxHealth(cid, mypb))
		for c = 1, 15 do
			local str = "move"..c
			setCD(mypb.uid, str, 0)
		end
		if getPlayerStorageValue(cid, 17000) <= 0 and getPlayerStorageValue(cid, 17001) <= 0 and getPlayerStorageValue(cid, 63215) <= 0 then
			for a, b in pairs (pokeballs) do
				if isInArray(b.all, mypb.itemid) then
					if b.on > 0 then
						doTransformItem(mypb.uid, b.on)
					end
				end
			end
		end
	end
	
	local bp = getPlayerSlotItem(cid, CONST_SLOT_BACKPACK)
    local balls = getPokeballsInContainer(bp.uid)
    if #balls >= 1 then
       for _, uid in ipairs(balls) do
           doItemSetAttribute(uid, "hp", 1)
		   doSetItemAttribute(uid, "hpToDraw", 0)
           for c = 1, 15 do
               local str = "move"..c
               setCD(uid, str, 0)   
           end
           local this = getThing(uid)
           for a, b in pairs (pokeballs) do
		       if isInArray(b.all, this.itemid) then
					if b.on > 0 then
						doTransformItem(uid, b.on)
					end
               end
           end
        end
    end
end

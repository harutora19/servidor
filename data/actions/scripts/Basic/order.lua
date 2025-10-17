function isWalkAround(cid)
    local cpos = getThingPos(cid)
    cpos.stackpos = 255
    for x=-1,1 do
        for y=-1,1 do
            cpos.x = cpos.x + x
            cpos.y = cpos.y + y
            if isWalkable(cpos) and not isCreature(getThingFromPos(cpos).uid) then
                return true
            end
        end
    end
    return false
end

function onUse(cid, item, frompos, item2, topos)

-- if getCreatureName(cid) ~= "Nautilus" then
-- doPlayerSay(cid, "move ali porra")
-- local a = topos
-- while getCreaturePosition(cid) ~= a do
-- doCreatureWalkToPosition(getCreatureSummons(cid)[1], topos)

-- end
-- return true
-- end


    if getCreatureCondition(cid, CONDITION_EXHAUST) then return true end
    doAddCondition(cid, ordercondition)

    local pPos = getThingPos(cid)
    pPos.stackpos = 0
    local pos = getThingFromPos(pPos)

    if isSurf(cid) or isInArray(11756, item2.itemid) or item2.itemid == 11756 or isInArray(11756, pos.itemid) or pos.itemid == 11756 or isInArray({11756, 11675, 11676, 460}, pos.itemid) then
        return doPlayerSendCancel(cid, MSG_NAO_E_POSSIVEL)
    end

    if item2.uid == cid then -- demound poke
        if isPlayer(item2.uid) and isInDuel(item2.uid) then
            return doPlayerSendCancel(cid, MSG_NAO_E_POSSIVEL)
        end
        if isRiderOrFlyOrSurf(cid) then
            local ball = getPlayerSlotItem(cid, 8)
            if getTileInfo(getThingPos(cid)).house then
                doPlayerSendCancel(cid, "You can't fly on a house!")
                return true
            end
            if isWalkAround(cid) then
                doGoPokemonInOrder(cid, ball, false)
				local look = getAddonValue(ball.uid, "addon")
				local pk = getCreatureSummons(cid)[1]
				if look > 0 then
					doSetCreatureOutfit(pk, {lookType = look}, -1)
				end
                doRemoveCondition(cid, CONDITION_OUTFIT)
				-- ADDON SYSTEM
                doPlayerSay(cid, getCreatureNick(getCreatureSummons(cid)[1]) .. orderTalks["downability"].talks[math.random(#orderTalks["downability"].talks)])
				if getPlayerStorageValue(cid, 87001) == 1 then
					doRemoveCondition(cid, CONDITION_OUTFIT)
					setPlayerStorageValue(cid, 87001, 0)
					doRegainSpeed(cid)
				end
				
                doRegainSpeed(cid)
				-- local aura = getItemAttribute(getPlayerSlotItem(cid, 8).uid, "particle")
				-- if aura then
					-- addEvent(doSendCreatureEffect, 50, pk, 13)
				-- end
                setPlayerStorageValue(cid, orderTalks["ride"].storage, -1)
                setPlayerStorageValue(cid, orderTalks["fly"].storage, -1)
                doPlayerSendCancel(cid, '12//,show')
            else
                doPlayerSendCancel(cid, "Not enough space!")
            end
            return true
        end
    end
    --- ride/fly retirada


    if isRiderOrFlyOrSurf(cid) then
        return doPlayerSendCancel(cid, MSG_NAO_E_POSSIVEL)
    end

    if #getCreatureSummons(cid) == 0 then
        return doPlayerSendCancel(cid, "Você precisa de um pokemon para usar o order.")
    end

    local poke = getCreatureSummons(cid)[1]
    local pokeName = getCreatureNick(poke)
    local habilidades = getPokemonSkills(getCreatureName(poke))

    if item2.uid == cid then
		
        -- if isFight(cid) then  -- EdiÃ§Ã£o pra ficar igual pxg.. nao dar fly ou ride com fight
            -- setMoveSummon(cid, false)
            -- addEvent(doMovePokeToPos, 5, poke, getThingPos(cid))
            -- return true
        -- end

        if isPlayer(item2.uid) and (isInDuel(item2.uid) or getCreatureSkullType(item2.uid) == SKULL_WHITE or getCreatureSkullType(item2.uid) == 1 or getCreatureSkullType(item2.uid) == 2) then
            return doPlayerSendCancel(cid, MSG_NAO_E_POSSIVEL)
        end

        if not (getThingPos(poke) or getThingPos(item2.uid)) then
            return true
        end
        local dist = getDistanceBetween(getThingPos(poke), getThingPos(item2.uid))
        --- ride


        if string.find(habilidades, "ride") then
			if getPlayerStorageValue(cid, 87000) == 1 then
				return doPlayerSendTextMessage(cid, 27, "Você não pode subir no ride enquanto estiver usando bike.")
			end
            doPlayerSay(cid, pokeName..orderTalks["ride"].talks[math.random(#orderTalks["ride"].talks)])

            if dist <= 4 then
                doUp(cid, poke, "ride")
                return true
            end

            --setMoveSummon(cid, false)
            --addEvent(doMovePokeToPos, 200, poke, topos)
            --addEvent(doMovePokeToPos, 200, poke, topos)
            setPlayerStorageValue(poke, orderTalks["ride"].storage, 1)

        elseif string.find(habilidades, "fly") or string.find(habilidades, "levitate") then
			if getPlayerStorageValue(cid, 87000) == 1 then
				return doPlayerSendTextMessage(cid, 27, "Você não pode subir no fly enquanto estiver usando bike.")
			end
		
            local nofly = {
                {{x=2526,y=2495,z=1},{x=3305,y=3334,z=14}}, -- outland
            }

            local vipfly = {
                {{x=3780,y=3870,z=0},{x=4306,y=4326,z=14}}, -- cordova
            }

            for i,v in pairs(nofly) do
                if isInArea(getThingPos(cid), v[1], v[2]) then
                    doPlayerSendCancel(cid, "You can't fly here.")
                    return true
                end
            end

            for i,v in pairs(vipfly) do
                if isInArea(getThingPos(cid), v[1], v[2]) then
					if not isPremium(cid) then
						doPlayerSendCancel(cid, "Only VIP can fly here.")
						return true
					end
                    return true
                end
            end

            if string.find(habilidades, "levitate") then
                doPlayerSay(cid, pokeName..orderTalks["levitate"].talks[math.random(#orderTalks["levitate"].talks)])
            else
                doPlayerSay(cid, pokeName..orderTalks["fly"].talks[math.random(#orderTalks["fly"].talks)])
            end

            if dist <= 4 then
                doUp(cid, poke, "fly")
                return true
            end

            setMoveSummon(cid, false)
            addEvent(doMovePokeToPos, 200, poke, topos)
            setPlayerStorageValue(poke, orderTalks["fly"].storage, 1)
        end
        ----------------- Ditto -----------------
    elseif isMonster(item2.uid) and isInArray({"Shiny Ditto", "Ditto"}, getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke"))  then

        if isPlayer(item2.uid) and isInDuel(item2.uid) then
            return doPlayerSendCancel(cid, MSG_NAO_E_POSSIVEL)
        end

        --if isPlayerSummon(cid, item2.uid) and isInArray({"Shiny Ditto", "Ditto"}, getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke")) and not isInArray({"Shiny Ditto", "Ditto"}, getItemAttribute(getPlayerSlotItem(cid, 8).uid, "copyName")) then
        --
        --   doCopyPokemon(poke, getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke"), true)
        --   doPlayerSay(cid, getCreatureNick(getCreatureSummons(cid)[1])..", reverta-se.")
        --   return true
        --
        --else
        if not isPlayerSummon(cid, item2.uid) and getPokeName(item2.uid) ~= getPokeName(poke) then

            if isSummon(item2.uid) then
                if getPlayerSlotItem(getCreatureMaster(item2.uid), 8).uid ~= 0 and isInArray({"Shiny Ditto", "Ditto"}, getItemAttribute(getPlayerSlotItem(getCreatureMaster(item2.uid), 8).uid, "poke")) then
                    doSendMsg(cid, "Você não pode fazer uma copia de um outro ditto.")
                    return true
                end
            end

            local thingName = doCorrectString(getCreatureName(item2.uid))

            if pokes[thingName].level > getPlayerLevel(cid) then
                doSendMsg(cid, "Você não tem level para copiar este pokémon.")
                return true
            end
            doCopyPokemon(poke, thingName, true)
            return true

        end


        ----------------- Mover -----------------
    elseif not isCreature(item2.uid) then
		setMoveSummon(cid, false)
		doCreatureWalkToPosition(getCreatureSummons(cid)[1], topos)

        ----- EdiÃ§Ãµes dig/cut/rock smash/headbutt/blink
        local buracos = {468, 481, 483}
        local arvores = {2767}
        local pedras = {1285}
        local headbutt = {2707}

        if item2.uid == 0 then return true end
        local pos = getThingPos(item2.uid)
        local dist = getDistanceBetween(getThingPos(poke), getThingPos(item2.uid))


        if not isFight(cid) then
            if isInArray(buracos, item2.itemid) then   ----------------------- DIG

                if not string.find(habilidades, "dig") then
                    return doPlayerSendCancel(cid, "Esse pokemon não tem a habilidade de cavar.")
                end

                doMarkedPos(poke, getThingPos(item2.uid))
                doEreaseUsingOrder(cid)
                setPlayerStorageValue(poke, orderTalks["dig"].storage, 1)
                setMoveSummon(cid, false)
                if dist <= 4 then
                    recheck(poke, "dig", getThingPos(item2.uid))
                else
                    addEvent(doMovePokeToPos, 200, poke, topos)
                end
                doPlayerSay(cid, getCreatureNick(poke)..orderTalks["dig"].talks[math.random(#orderTalks["dig"].talks)])

                return true
            elseif isInArray(arvores, item2.itemid) then   ----------------------- CUT

                if not string.find(habilidades, "cut") then
                    return doPlayerSendCancel(cid, "Esse pokemon não tem a habilidade de cortar.")
                end

                doMarkedPos(poke, getThingPos(item2.uid))
                doEreaseUsingOrder(cid)
                setPlayerStorageValue(poke, orderTalks["cut"].storage, 1)
                setMoveSummon(cid, false)
                if dist <= 4 then
                    addEvent(recheck, (1000 - (2.3*getCreatureSpeed(poke))) * dist, poke, "cut", getThingPos(item2.uid))
                else
                    addEvent(doMovePokeToPos, 200, poke, topos)
                end
                doPlayerSay(cid, getCreatureNick(poke)..orderTalks["cut"].talks[math.random(#orderTalks["cut"].talks)])
                return true
            elseif isInArray(pedras, item2.itemid) then   ----------------------- ROCK

                if not string.find(habilidades, "rock smash") then
                    return doPlayerSendCancel(cid, "Esse pokemon não tem a habilidade de quebrar.")
                end

                local pos = getThingPos(item2.uid)
                doMarkedPos(poke, getThingPos(item2.uid))
                doEreaseUsingOrder(cid)
                setPlayerStorageValue(poke, orderTalks["rock"].storage, 1)
                setMoveSummon(cid, false)
                if dist <= 4 then
                    addEvent(recheck, (1000 - (2.3*getCreatureSpeed(poke))) * dist, poke, "rock", getThingPos(item2.uid))
                else
                    addEvent(doMovePokeToPos, 200, poke, topos)
                end
                doPlayerSay(cid, getCreatureNick(poke)..orderTalks["rock"].talks[math.random(#orderTalks["rock"].talks)])
                return true

            elseif isInArray(headbutt, item2.itemid) then   ----------------------- HEAD

                if not string.find(habilidades, "headbutt") then
                    return doPlayerSendCancel(cid, "Esse pokemon nao tem a habilidade de balancar Arvores.")
                end

                local pos = getThingPos(item2.uid)
                doMarkedPos(poke, getThingPos(item2.uid))
                doEreaseUsingOrder(cid)
                setPlayerStorageValue(poke, orderTalks["headbutt"].storage, 1)
                setMoveSummon(cid, false)
                if dist <= 1 then
                    addEvent(recheck, (1000 - (2.3*getCreatureSpeed(poke))) * dist, poke, "headbutt", getThingPos(item2.uid))
                else
                    addEvent(doMovePokeToPos, 200, poke, topos)
                end
                doPlayerSay(cid, getCreatureNick(poke)..orderTalks["headbutt"].talks[math.random(#orderTalks["headbutt"].talks)])

                return true
            end
        end
        if string.find(habilidades, "blink") or isInArray(specialabilities["blink"], getCreatureName(poke)) then
            local noblinkarea = {{{x=1963,y=1982,z=10},{x=2017,y=2019,z=10}},{{x=126,y=767,z=6},{x=148,y=789,z=6}},{{x=2271,y=3218,z=8},{x=2412,y=3266,z=8}}}
            local tournarea = {{x=127, y=820, z=6}, {x=135, y=828, z=6}}
            if isInArea(topos, tournarea[1], tournarea[2]) and not isInArea(getThingPos(cid), tournarea[1], tournarea[2]) then
                doPlayerSendCancel(cid, "You shouldn't do that!")
                return true
            end

            if not isInArea(topos, tournarea[1], tournarea[2]) and isInArea(getThingPos(cid), tournarea[1], tournarea[2]) then
                doPlayerSendCancel(cid, "You can't blink outside the arena!")
                return true
            end

            if not isInArea(topos, {x=125, y=767, z=6}, {x=148, y=789, z=6}) and isInArea(getThingPos(cid), {x=125, y=767, z=6}, {x=148, y=789, z=6}) then
                doPlayerSendCancel(cid, "You can't blink outside the arena!")
                return true
            end

            if not isWalkable(topos) then
                doPlayerSay(cid, getCreatureNick(poke)..orderTalks["move"].talks[math.random(#orderTalks["move"].talks)])
                doPlayerSendCancel(cid, "Sorry, not possible.")
                return true
            end
            for i,v in pairs(noblinkarea) do
                if isInArea(getThingPos(cid), v[1], v[2]) then
                    doPlayerSay(cid, getCreatureNick(poke)..orderTalks["move"].talks[math.random(#orderTalks["move"].talks)])
                    doPlayerSendCancel(cid, "You can't use blink here.")
                    return true
                end
            end

            if os.time() < getPlayerStorageValue(poke, storages.blink) and not isGod(cid) then
                doPlayerSay(cid, getCreatureNick(poke)..orderTalks["move"].talks[math.random(#orderTalks["move"].talks)])
                return true
            elseif (getCreatureSkullType(cid) == SKULL_WHITE or isInDuel(cid)) and getTileInfo(getThingPos(item2.uid)).protection then
                doSendMsg(cid, "Você não pode usar blink em protection zone quando está em duelo.")
                return true
            end
			local aura = getItemAttribute(getPlayerSlotItem(cid, 8).uid, "particle")
			local pk = getCreatureSummons(cid)[1]
			if aura then
				addEvent(doSendCreatureEffect, 100, pk, 1)
			end
            setPlayerStorageValue(poke, storages.blink, os.time()+12)
            doSendMagicEffect(getThingPos(poke), 134)
            doTeleportThing(poke, getThingPos(item2.uid), false)
            doSendMagicEffect(getThingPos(poke), 134)
            doPlayerSay(cid, getCreatureNick(poke)..orderTalks["blink"].talks[math.random(#orderTalks["blink"].talks)])

            return true
        end
		
		if string.find(habilidades, "dark portal") or isInArray(specialabilities["dark portal"], getCreatureName(poke)) then
            local noblinkarea = {{{x=1963,y=1982,z=10},{x=2017,y=2019,z=10}},{{x=126,y=767,z=6},{x=148,y=789,z=6}},{{x=2271,y=3218,z=8},{x=2412,y=3266,z=8}}}
            local tournarea = {{x=127, y=820, z=6}, {x=135, y=828, z=6}}
            if isInArea(topos, tournarea[1], tournarea[2]) and not isInArea(getThingPos(cid), tournarea[1], tournarea[2]) then
                doPlayerSendCancel(cid, "You shouldn't do that!")
                return true
            end

            if not isInArea(topos, tournarea[1], tournarea[2]) and isInArea(getThingPos(cid), tournarea[1], tournarea[2]) then
                doPlayerSendCancel(cid, "You can't dark portal outside the arena!")
                return true
            end

            if not isInArea(topos, {x=125, y=767, z=6}, {x=148, y=789, z=6}) and isInArea(getThingPos(cid), {x=125, y=767, z=6}, {x=148, y=789, z=6}) then
                doPlayerSendCancel(cid, "You can't dark portal outside the arena!")
                return true
            end

            if not isWalkable(topos) then
                doPlayerSay(cid, getCreatureNick(poke)..orderTalks["move"].talks[math.random(#orderTalks["move"].talks)])
                doPlayerSendCancel(cid, "Sorry, not possible.")
                return true
            end
            for i,v in pairs(noblinkarea) do
                if isInArea(getThingPos(cid), v[1], v[2]) then
                    doPlayerSay(cid, getCreatureNick(poke)..orderTalks["move"].talks[math.random(#orderTalks["move"].talks)])
                    doPlayerSendCancel(cid, "You can't use dark portal here.")
                    return true
                end
            end

            if os.time() < getPlayerStorageValue(poke, storages.darkportal) and not isGod(cid) then
                doPlayerSay(cid, getCreatureNick(poke)..orderTalks["move"].talks[math.random(#orderTalks["move"].talks)])
                return true
            elseif (getCreatureSkullType(cid) == SKULL_WHITE or isInDuel(cid)) and getTileInfo(getThingPos(item2.uid)).protection then
                doSendMsg(cid, "Você não pode usar dark portal em protection zone quando está em duelo.")
                return true
            end
			local aura = getItemAttribute(getPlayerSlotItem(cid, 8).uid, "particle")
			local pk = getCreatureSummons(cid)[1]
			if aura then
				addEvent(doSendCreatureEffect, 100, pk, 1)
			end
            setPlayerStorageValue(poke, storages.darkportal, os.time()+12)
            doSendMagicEffect(getThingPos(poke), 1097)
            doTeleportThing(poke, getThingPos(item2.uid), false)
            doSendMagicEffect(getThingPos(poke), 1097)
            doPlayerSay(cid, getCreatureNick(poke)..orderTalks["dark portal"].talks[math.random(#orderTalks["dark portal"].talks)])

            return true
        end

        doPlayerSay(cid, getCreatureNick(poke)..orderTalks["move"].talks[math.random(#orderTalks["move"].talks)])

    end
    return true
end

function isGhost(cid)
    local hab = getPokemonSkills(string.lower(getPokeName(cid)))
    if string.find(hab, "ghost")  then
        return true
    end
    return false
end

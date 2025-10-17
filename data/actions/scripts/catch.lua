local ballcatch = {                    --id normal, id da ball shiy
    [2394] = {cr = 5, on = 24, off = 23, ball = {11826, 11737}, send = 60, typeee = "poke", boost = "0", exp = 1},  --alterado v1.9  \/
    [2391] = {cr = 10, on = 198, off = 197, ball = {11832, 11740}, send = 62, typeee = "great", boost = "0", exp = 2},
    [2393] = {cr = 15, on = 202, off = 201, ball = {11835, 11743}, send = 61, typeee = "super", boost = "0", exp = 3},
    [2392] = {cr = 20, on = 200, off = 199, ball = {11829, 11746}, send = 63, typeee = "ultra", boost = "0", exp = 4},
    [12617] = {cr = 15, on = 204, off = 203, ball = {10975, 12621}, send = 64, typeee = "saffari", boost = "0", exp = 3},
    [12832] = {cr = 100000, on = 747, off = 747, ball = {12826, 12829}, send = 72, typeee = "master", boost = "50", exp = 50},

    [15677] = {cr = 25, on = 699, off = 700, ball = {16181, 16204}, send = 96, typeee = "magu", boost = "0", type = {"fire", "ground"}, exp = 8},
    [15676] = {cr = 25, on = 702, off = 703, ball = {16182, 16205}, send = 97, typeee = "sora", boost = "0", type = {"ice", "flying"}, exp = 8},
    [15678] = {cr = 25, on = 705, off = 706, ball = {16183, 16206}, send = 98, typeee = "yume", boost = "0", type = {"normal", "psychic"}, exp = 8},
    [15680] = {cr = 25, on = 708, off = 709, ball = {16184, 16207}, send = 99, typeee = "dusk", boost = "0", type = {"poison", "grass"}, exp = 8},
    [15673] = {cr = 25, on = 717, off = 718, ball = {16187, 16210}, send = 102, typeee = "tale", boost = "0", type = {"dragon", "fairy"}, exp = 8},
    [15674] = {cr = 25, on = 720, off = 721, ball = {16188, 16211}, send = 103, typeee = "moon", boost = "0", type = {"dark", "ghost"}, exp = 8},
    [15675] = {cr = 25, on = 723, off = 721, ball = {16189, 16212}, send = 104, typeee = "net", boost = "0", type = {"bug", "water"}, exp = 8},
    [15679] = {cr = 25, on = 729, off = 730, ball = {16191, 16214}, send = 106, typeee = "premier", boost = "0", type = {"rock", "fighting", "crystal"}, exp = 8},
    [15681] = {cr = 25, on = 732, off = 733, ball = {16192, 16215}, send = 107, typeee = "tinker", boost = "0", type = {"electric", "steel"}, exp = 8},


    [15682] = {cr = 25, on = 711, off = 712, ball = {16185, 16208}, send = 100, typeee = "fast", boost = "0", pokes = {"Pikachu", "Raichu"}, exp = 8},
    [15672] = {cr = 25, on = 714, off = 715, ball = {16186, 16209}, send = 101, typeee = "heavy", boost = "0", pokes = {"Snorlax", "Venusaur"}, exp = 8},
}

function addBallExp(cid, pokename, ball)
    if jaCapturou(cid, pokename) then return true end
    local xp = 0
    local ballexp = ballcatch[ball].exp
    if ball >= 15677 then
        if not (ballcatch[ball].type and (isInArray(ballcatch[ball].type, pokes[pokename].type) or isInArray(ballcatch[ball].type, pokes[pokename].type2))) then
            ballexp = ballcatch[2392].exp
        end
    end
    xp = (pokes[pokename].exp * ballexp / 4) or 1
    if xp == 1 then print(pokename.." not on catch list.") end
    if xp > 0 then addExpByStages(cid, xp, true) end
    return true
end

function onUse(cid, item, frompos, item3, topos)

    local item2 = getTopCorpse(topos)
    if item2 == null then
        return true
    end
	

    if getItemAttribute(item2.uid, "catching") == 1 then
        return true
    end

    doItemSetAttribute(item2.uid, "catching", 1)

    if getItemAttribute(item2.uid, "golden") and getItemAttribute(item2.uid, "golden") == 1 then
        return doPlayerSendCancel(cid, "You can't try to catch a pokemon in the Golden Arena!")
    end

    if isInArea(getThingPos(cid), {x=1285, y=472, z=6}, {x=1318, y=489, z=6}) then
        return doPlayerSendCancel(cid, "You can't try to catch a pokemon in the Survival Arena!")
    end

    if not getItemAttribute(item2.uid, "pokeName") then
        return true
    end

    local name = string.lower(getItemAttribute(item2.uid, "pokeName"))
    name = string.gsub(name, "fainted ", "")
    name = string.gsub(name, "defeated ", "")
    name = doCorrectPokemonName(name)
	
    local smeargleID = 5
    if name:find("Smeargle") then
        smeargleID = string.sub(name, 9, 10)
        name = "Smeargle"
    end
    local x = pokecatches[name]

    if not x then return true end

    if not newpokedex[name] then print("> ERROR: actions\scripts\catch.lua -> index nil value on newpokedex[name].stoCatch for ".. name) end
    local storage = getPokemonStorageCatch(name)

    if type(getPlayerStorageValue(cid, storage)) ~= "string" or not string.find(getPlayerStorageValue(cid, storage), "magu") then  --alterado v1.9
        setPlayerStorageValue(cid, storage, "normal = 0, great = 0, super = 0, ultra = 0, saffari = 0, dark = 0, magu = 0, sora = 0, yume = 0, dusk = 0, tale = 0, moon = 0, net = 0, premier = 0, tinker = 0, fast = 0, heavy = 0;")             --alterado v1.9
    end

    local owner = getItemAttribute(item2.uid, "corpseowner")
    local pOwner = getPlayerByName(owner)
    local isInPartyWithPlayer = false
    if isInParty(cid) and isInParty(pOwner) then
        isInPartyWithPlayer = (getPartyLevelDif(cid) <= 25)
    end
    if owner and isCreature(pOwner) and isPlayer(pOwner) and cid ~= pOwner and not isInPartyWithPlayer then
        doPlayerSendCancel(cid, "Sorry, it's not possible.")
        return true
    end

    local newidd = isShinyName(name) and ballcatch[item.itemid].ball[2] or ballcatch[item.itemid].ball[1] --alterado v1.9
    local typeee = ballcatch[item.itemid].typeee
    local boost = ballcatch[item.itemid].boost
    -- VERIFICAÇÃO PARA OS POKÉMONS DE CYBER
    -- if getPlayerStorageValue(cid, ) then
    -- local pokesCyber = {"Shiny Ninetales", "Shiny Rhydon", "Shiny Stantler", "Shiny Politoed", "Shiny Magneton", "Shiny Umbreon", "Shiny Espeon", "Shiny Ariados", "Shiny Dodrio", "Crystal Onix"}
    -- if isInArray(pokesCyber, name) then
    -- doSendMsg(cid, "You can't catch this pokémon.")
    -- return true
    -- end
    -- end

    local catchBlocks = {"Aerodactyl", "Shiny Magmortar", "Shiny Electivire","Dusknoir", "Salamence", "Slaking", "Metagross", "Rhyperior", "Milotic", "Electivire", "Magmortar", "Tangrowth"}
    if isInArray(catchBlocks, name) then
        doSendMsg(cid, "Voce nao pode capturar este pokemon.")
        return true
    end
    -- local phBoss = {'Rhyperior','Magmortar','Electivire','Dusknoir','Milotic','Metagross','Tangrowth','Magnezone','Slaking','Salamence'}
    -- if typeee == "master" and phBoss(cid) then
        -- doSendMsg(cid, "You can't catch shinys with master ball.")
        -- return true
    -- end


    if name:find("Shiny") then
        local dir = "data/logs/shiny attempt.log"
        local arq = io.open(dir, "a+")
        local txt = arq:read("*all")
        arq:close()
        local arq = io.open(dir, "w")
        arq:write(""..txt.."\n[ATTEMPT ".. os.date("%x %X] ") .. getCreatureName(cid) .." -> ".. name)
        arq:close()
    end

    local catchchance = x.chance
    if string.find(doCorrectPokemonName(name), "Shiny") then
        catchchance = catchchance * 2
    end

    local catchinfo = {}
    catchinfo.rate = ballcatch[item.itemid].cr
    catchinfo.catch = ballcatch[item.itemid].on
    catchinfo.fail = ballcatch[item.itemid].off
    catchinfo.newid = newidd
    catchinfo.name = doCorrectPokemonName(name)
    catchinfo.topos = topos
    catchinfo.chance = catchchance

    -- if getItemAttribute(item2.uid, "xpball") ~= 1 then
        -- doItemSetAttribute(item2.uid, "xpball", 1)
        -- addBallExp(cid, doCorrectPokemonName(name), item.itemid)
    -- end

    doBrokesCount(cid, getPokemonStorageCatch(name), typeee)

    doSendDistanceShoot(getThingPos(cid), topos, ballcatch[item.itemid].send)
    doRemoveItem(item.uid, 1)

    ---- newsBalls
    -- if (ballcatch[item.itemid].type ~= nil or ballcatch[item.itemid].pokes ~= nil)  then
        -- catchinfo.rate = getBallsRate(catchinfo.name, item.itemid)
    -- end

    if getGlobalStorageValue(73737) > os.time() then -- happy hour
        catchinfo.rate = catchinfo.rate * 2
    end

    -- if isGod(cid) or getPlayerStorageValue(cid, 383233) == 1 then
        -- catchinfo.rate = 100000
        -- setPlayerStorageValue(cid, 383233, 0)
    -- end

	-- if not (ballcatch[item.itemid].type and pokes[name].type) or (ballcatch[item.itemid].type and pokes[name].type2) then
		-- return doPlayerSendTextMessage(cid, 27, "Você não pode jogar essa ball em pokémon desse tipo.")
	-- end

    local d = getDistanceBetween(getThingPos(cid), topos)

    if getPlayerStorageValue(cid, 98796) >= 1 and getPlayerItemCount(cid, 12617) <= 0 then
        setPlayerStorageValue(cid, 98796, -1)
        setPlayerStorageValue(cid, 98797, -1)
        doTeleportThing(cid, {x = 1018, y = 1017, z = 7})
        doSendMagicEffect(getThingPos(cid), 21)
        doPlayerSendTextMessage(cid, 27, "You've spent all your saffari balls, good luck in the next time...")
    end
	
    addEvent(doSendPokeBall, d * 70 + 100 - (d * 14) , cid, catchinfo, false, false, typeee, smeargleID)
    addEvent(doSendMagicEffect, (d * 70 + 100 - (d * 14)) - 100, topos, 3)
    return true
end

function getBallsRate(name, id)
    if pokes[name] then
        if isInArray(ballcatch[id].type, pokes[name].type) or isInArray(ballcatch[id].type, pokes[name].type2) or isInArray(ballcatch[id].pokes, name) then
            return 32
        end
    end
    return 18
end

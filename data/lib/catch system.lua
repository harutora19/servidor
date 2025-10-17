failmsgs = {
    "Sorry, you didn't catch that pokemon.",
    "Sorry, your pokeball broke.",
    "Sorry, the pokemon escaped.",
}

function doBrokesCount(cid, str, ball)   --alterado v1.9 \/
    if not isCreature(cid) then return false end
    local tb = {
        {b = "poke", v = 0},
        {b = "great", v = 0},
        {b = "super", v = 0},
        {b = "ultra", v = 0},
        {b = "saffari", v = 0},
        {b = "dark", v = 0},
        {b = "magu", v = 0},
        {b = "sora", v = 0},
        {b = "yume", v = 0},
        {b = "dusk", v = 0},
        {b = "tale", v = 0},
        {b = "moon", v = 0},
        {b = "net", v = 0},
        {b = "premier", v = 0},
        {b = "tinker", v = 0},
        {b = "fast", v = 0},
        {b = "heavy", v = 0},
    }
    for _, e in ipairs(tb) do
        if e.b == ball then
            e.v = 1
            break
        end
    end
    local strings = getPlayerStorageValue(cid, str)

    local t = "normal = (.-), great = (.-), super = (.-), ultra = (.-), saffari = (.-), dark = (.-), magu = (.-), sora = (.-), yume = (.-), dusk = (.-), tale = (.-), moon = (.-), net = (.-), premier = (.-), tinker = (.-), fast = (.-), heavy = (.-);"
    local t2 = ""
    for n, g, s, u, s2, d, magu, sora, yume, dusk, tale, moon, net, premier, tinker, fast, heavy in strings:gmatch(t) do
        t2 = "normal = "..(n+tb[1].v)..", great = "..(g+tb[2].v)..", super = "..(s+tb[3].v)..", ultra = "..(u+tb[4].v)..", saffari = "..(s2+tb[5].v)..", dark = "..(d+tb[6].v)..", magu = "..(magu+tb[7].v)..", sora = "..(sora+tb[8].v)..", yume = "..(yume+tb[9].v)..", dusk = "..(dusk+tb[10].v)..", tale = "..(tale+tb[11].v)..", moon = "..(moon+tb[12].v)..", net = "..(net+tb[13].v)..", premier = "..(premier+tb[14].v)..", tinker = "..(tinker+tb[15].v)..", fast = "..(fast+tb[16].v)..", heavy = "..(heavy+tb[17].v)..";"
    end

    setPlayerStorageValue(cid, str, strings:gsub(t, t2))
end

function sendBrokesMsg(cid, str, ball, poke, catched)
    if not isCreature(cid) then return true end
    local strings = getPlayerStorageValue(cid, str)
    if type(strings) == "number" or type(strings) ~= "string" or not string.find(strings, "magu") then  --alterado v1.9
        setPlayerStorageValue(cid, str, "normal = 0, great = 0, super = 0, ultra = 0, saffari = 0, dark = 0, magu = 0, sora = 0, yume = 0, dusk = 0, tale = 0, moon = 0, net = 0, premier = 0, tinker = 0, fast = 0, heavy = 0;")
        strings = getPlayerStorageValue(cid, str)   --alterado v1.9
    end
    --doBrokesCount(cid, str, ball) -- será?
    local t = "normal = (.-), great = (.-), super = (.-), ultra = (.-), saffari = (.-), dark = (.-), magu = (.-), sora = (.-), yume = (.-), dusk = (.-), tale = (.-), moon = (.-), net = (.-), premier = (.-), tinker = (.-), fast = (.-), heavy = (.-);"
    local msg = {}
    local countN, countG, countS, countU, countS2 = 0, 0, 0, 0, 0
    local maguCount, soraCount, yumeCount, duskCount, taleCount, moonCount, netCount, premierCount, tinkerCount, fastCount, heavyCount = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    table.insert(msg, "Você"..(catched == false and " já" or "").." gastou: ")

    for n, g, s, u, s2, d, magu, sora, yume, dusk, tale, moon, net, premier, tinker, fast, heavy in strings:gmatch(t) do
        if tonumber(n) and tonumber(n) > 0 then
            table.insert(msg, tostring(n).." Poke ball".. (tonumber(n) > 1 and "s" or ""))
            countN = tonumber(n)
        end
        if tonumber(g) and tonumber(g) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(g).." Great ball".. (tonumber(g) > 1 and "s" or ""))
            countG = tonumber(g)
        end
        if tonumber(s) and tonumber(s) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(s).." Ultra ball".. (tonumber(s) > 1 and "s" or ""))
            countS = tonumber(s)
        end
        if tonumber(u) and tonumber(u) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(u).." Ultra ball".. (tonumber(u) > 1 and "s" or ""))
            countU = tonumber(u)
        end
        if tonumber(s2) and tonumber(s2) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(s2).." Saffari ball".. (tonumber(s2) > 1 and "s" or ""))
            countS2 = tonumber(s2)
        end

        if tonumber(magu) and tonumber(magu) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(magu).." Magu ball".. (tonumber(magu) > 1 and "s" or ""))
            maguCount = tonumber(magu)
        end

        if tonumber(sora) and tonumber(sora) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(sora).." Sora ball".. (tonumber(sora) > 1 and "s" or ""))
            soraCount = tonumber(sora)
        end

        if tonumber(yume) and tonumber(yume) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(yume).." Yume ball".. (tonumber(yume) > 1 and "s" or ""))
            yumeCount = tonumber(yume)
        end

        if tonumber(dusk) and tonumber(dusk) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(dusk).." Dusk ball".. (tonumber(dusk) > 1 and "s" or ""))
            duskCount = tonumber(dusk)
        end

        if tonumber(tale) and tonumber(tale) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(tale).." Tale ball".. (tonumber(tale) > 1 and "s" or ""))
            taleCount = tonumber(tale)
        end

        if tonumber(moon) and tonumber(moon) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(moon).." Moon ball".. (tonumber(moon) > 1 and "s" or ""))
            moonCount = tonumber(moon)
        end

        if tonumber(net) and tonumber(net) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(net).." Net ball".. (tonumber(net) > 1 and "s" or ""))
            netCount = tonumber(net)
        end

        if tonumber(premier) and tonumber(premier) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(premier).." Premier ball".. (tonumber(premier) > 1 and "s" or ""))
            premierCount = tonumber(premier)
        end

        if tonumber(tinker) and tonumber(tinker) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(tinker).." Tinker ball".. (tonumber(tinker) > 1 and "s" or ""))
            tinkerCount = tonumber(tinker)
        end

        if tonumber(fast) and tonumber(fast) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(fast).." Fast ball".. (tonumber(fast) > 1 and "s" or ""))
            fastCount = tonumber(fast)
        end

        if tonumber(heavy) and tonumber(heavy) > 0 then
            table.insert(msg, (#msg > 1 and ", " or "").. tostring(heavy).." Heavy ball".. (tonumber(heavy) > 1 and "s" or ""))
            heavyCount = tonumber(heavy)
        end
    end
    if #msg == 1 then
        return true
    end
    if string.sub(msg[#msg], 1, 1) == "," then
        msg[#msg] = " e".. string.sub(msg[#msg], 2, #msg[#msg])
    end
    table.insert(msg, " para"..(catched == false and " tentar" or "").." captura-lo.")
    if catched then
        doPlayerSendTextMessage(cid, 27, table.concat(msg))

        local ballsCatchedString = countN .. "-" .. countG .. "-" .. countS .. "-" .. countU .. "-" .. countS2 .. "-" .. maguCount .. "-" .. soraCount .. "-" .. yumeCount .. "-" .. duskCount .. "-" .. taleCount .. "-" .. moonCount .. "-" .. netCount .. "-" .. premierCount .. "-" .. tinkerCount .. "-" ..fastCount .. "-" .. heavyCount

        local list = getCatchList(cid)
        if not jaCapturou(cid, poke) then
            local expssss = 100
            for i = 1, #oldpokedexToCatch do
                if oldpokedexToCatch[i][1] == doCorrectString(poke) then
                    expssss = oldpokedexToCatch[i][4]
                    break
                end
            end
            doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_CATCH, getPortraitClientID(poke) .. "-" .. expssss .. "-" .. poke .. "-" .. ballsCatchedString)
            doPlayerAddExp(cid, expssss)
            doSendAnimatedText(getThingPos(cid), expssss , 215)
            doPlayerAddInKantoCatchs(cid, 1)
            colocarNaListaDeCapturados(cid, poke)
        end
    end
end                                                                 --alterado v1.9 /\
--------------------------------------------------------------------------------
function colocarNaListaDeCapturados(cid, poke)
    setPlayerStorageValue(cid, fotos[poke], 1)
end

function jaCapturou(cid, poke)
    local storage = getPlayerStorageValue(cid, fotos[poke])
    if storage ~= -1 then
        return true
    end
    return false
end

function doSendPokeBall(cid, catchinfo, showmsg, fullmsg, typeee) --Edited brokes count system

    local name = catchinfo.name
    local pos = catchinfo.topos
    local topos = {}
    topos.x = pos.x
    topos.y = pos.y
    topos.z = pos.z
    local newid = catchinfo.newid
    local catch = catchinfo.catch
    local fail = catchinfo.fail
    local rate = catchinfo.rate
    local basechance = catchinfo.chance

    if pokes[getPlayerStorageValue(cid, 854788)] and name == getPlayerStorageValue(cid, 854788) then
        rate = 85
    end

    local corpse = getTopCorpse(topos).uid

    if not isCreature(cid) then
        doSendMagicEffect(topos, CONST_ME_POFF)
        return true
    end

    doItemSetAttribute(corpse, "catching", 1)

    local level = getItemAttribute(corpse, "level") or 0
    local levelChance = level * 0.02

    local totalChance = math.ceil(basechance * (1.2 + levelChance))
    local thisChance = math.random(0, totalChance)
    local myChance = math.random(0, totalChance)
    local chance = (1 * rate + 1) / totalChance
    chance = doMathDecimal(chance * 100)

    if rate >= totalChance then
        local status = {}
        doRemoveItem(corpse, 1)
        doSendMagicEffect(topos, catch)
        addEvent(doCapturePokemon, 3000, cid, name, newid, status, typeee)
        return true
    end


    if totalChance <= 1 then totalChance = 1 end

    local myChances = {}
    local catchChances = {}


    for cC = 0, totalChance do
        table.insert(catchChances, cC)
    end

    for mM = 1, rate do
        local element = catchChances[math.random(1, #catchChances)]
        table.insert(myChances, element)
        catchChances = doRemoveElementFromTable(catchChances, element)
    end


    local status = {}
    doRemoveItem(corpse, 1)

    local doCatch = false

    for check = 1, #myChances do
        if thisChance == myChances[check] then
            doCatch = true
        end
    end

    if doCatch then
        doSendMagicEffect(topos, catch)
        addEvent(doCapturePokemon, 3000, cid, name, newid, status, typeee)
    else
        addEvent(doNotCapturePokemon, 3000, cid, name, typeee)
        doSendMagicEffect(topos, fail)
    end
end

function doCapturePokemon(cid, poke, ballid, status, typeee)

    if not isCreature(cid) then
        return true
    end

    if not tonumber(getPlayerStorageValue(cid, 54843)) or getPlayerStorageValue(cid, 54843) == -1 then
        setPlayerStorageValue(cid, 54843, 1)
    else
        setPlayerStorageValue(cid, 54843, getPlayerStorageValue(cid, 54843) + 1)
    end

    -- if pokeballs[poke] then
    -- ballid = pokeballs[poke].on
    -- end
    if pokeballs[poke:lower()] then
        ballid = pokeballs[poke:lower()].on
    end
    local description = "Contains a "..poke.."."
    local cap = getPlayerFreeCap(cid)
    local bugballs = {"shiny magcargo"}

    if (cap <= 1 and not isInArray({5, 6}, getPlayerGroupId(cid))) or not hasSpaceInContainer(getPlayerSlotItem(cid, 3).uid) then
        --print(poke .. " : ".. ballid)
        item = doCreateItemEx(ballid) -- CUIDADO COM ISSO! Tentando fazer ele não ir morto pro debot
    else
        item = addItemInFreeBag(getPlayerSlotItem(cid, 3).uid, ballid, 1)
    end
	
-- if poke == "Smeargle" then
		-- local randoms = math.random(1, 100)
		-- if randoms >= 99 then
			-- poke = "Smeargle 10"
		-- elseif randoms >= 98 then
			-- poke = "Smeargle 9"
		-- elseif randoms >= 97 then
			-- poke = "Smeargle 8"
		-- elseif randoms >= 85 then
			-- poke = "Smeargle 7"
		-- elseif randoms >= 80 then
			-- poke = "Smeargle 6"
		-- elseif randoms >= 75 then
			-- poke = "Smeargle 5"
		-- elseif randoms >= 65 then
			-- poke = "Smeargle 4"
		-- elseif randoms >= 45 then
			-- poke = "Smeargle 3"
		-- elseif randoms >= 30 then
			-- poke = "Smeargle 2"
		-- elseif randoms >= 1 then
			-- poke = "Smeargle 1"
		-- end
	-- end	
	
	-- if poke == "Smeargle" or poke == "Smeargle 1" then
		-- doItemSetAttribute(item, "SmeargleID", 1)		
	-- elseif poke == "Smeargle 2" then
		-- doItemSetAttribute(item, "SmeargleID", 2)
	-- elseif poke == "Smeargle 3" then
		-- doItemSetAttribute(item, "SmeargleID", 3)
	-- elseif poke == "Smeargle 4" then
		-- doItemSetAttribute(item, "SmeargleID", 4)
	-- elseif poke == "Smeargle 5" then
		-- doItemSetAttribute(item, "SmeargleID", 5)
	-- elseif poke == "Smeargle 6" then
		-- doItemSetAttribute(item, "SmeargleID", 6)
	-- elseif poke == "Smeargle 7" then
		-- doItemSetAttribute(item, "SmeargleID", 7)
	-- elseif poke == "Smeargle 8" then
		-- doItemSetAttribute(item, "SmeargleID", 8)
	-- elseif poke == "Smeargle 9" then
		-- doItemSetAttribute(item, "SmeargleID", 9)
	-- elseif poke == "Smeargle 10" then
		-- doItemSetAttribute(item, "SmeargleID", 10)
	-- end		

    doItemSetAttribute(item, "poke", poke)
    doItemSetAttribute(item, "hpToDraw", 0)
    doItemSetAttribute(item, "ball", typeee)
    doSetAttributesBallsByPokeName(cid, item, poke)
    if poke == "Hitmonchan" or poke == "Shiny Hitmonchan" then
        doItemSetAttribute(item, "hands", 0)
    end

    if isInArray({'Rhyperior','Magmortar','Electivire','Dusknoir','Milotic','Metagross','Tangrowth','Magnezone','Slaking','Salamence'}, poke) then
        doBroadcastMessage("The Player " .. doCorrectString(getCreatureName(cid)) .. " caught a Pokémon " .. poke .. " using " .. typeee .. " ball.")
    end
    ----------- task clan ---------------------
    -- if pokes[getPlayerStorageValue(cid, 854788)] and poke == getPlayerStorageValue(cid, 854788) then
        -- sendMsgToPlayer(cid, 27, "Quest Done!")
        -- doItemSetAttribute(item, "unique", getCreatureName(cid))
        -- doItemSetAttribute(item, "task", 1)
        -- setPlayerStorageValue(cid, 854788, 'done')
    -- end
    --if pokeballs[poke:lower()] then
    --   doTransformItem(item, pokeballs[poke:lower()].on)
    --end
    doItemSetAttribute(item, "ehDoChao", false)

    if poke:find("Shiny") then
		for _,oid in pairs(getPlayersOnline()) do
			doPlayerSendChannelMessage(oid, "", "The Player " .. getCreatureName(cid) .." caught a "..poke.." using " .. typeee .. " ball.", TALKTYPE_CHANNEL_RN, 42)
		end
        local dir = "data/logs/shiny catch.log"
        local arq = io.open(dir, "a+")
        local txt = arq:read("*all")
        arq:close()
        local arq = io.open(dir, "w")
        arq:write(""..txt.."\n[CATCH ".. os.date("%x %X] ") .. getCreatureName(cid) .." -> ".. poke)
        arq:close()
    end

    doPlayerSendTextMessage(cid, 27, "Congratulations, you caught a pokemon ("..poke..")!")
    if cap <= 1 then
        doPlayerSendMailByName(getCreatureName(cid), item, 1)
        doPlayerSendTextMessage(cid, 27, "Since you are already holding six pokemons, this pokeball has been sent to your depot.")
    end

    if #getCreatureSummons(cid) >= 1 then
        doSendMagicEffect(getThingPos(getCreatureSummons(cid)[1]), 173)
    else
        doSendMagicEffect(getThingPos(cid), 173)
    end

    -- if typeee == "master" then
        -- doItemSetAttribute(item, "unique", true)
    -- end

    local storage = getPokemonStorageCatch(poke)
    sendBrokesMsg(cid, storage, typeee, poke, true)
    setPlayerStorageValue(cid, storage, "normal = 0, great = 0, super = 0, ultra = 0, saffari = 0, dark = 0, magu = 0, sora = 0, yume = 0, dusk = 0, tale = 0, moon = 0, net = 0, premier = 0, tinker = 0, fast = 0, heavy = 0;") --alterado v1.9 /\
    doAddPokemonInCatchList(cid, poke)
    doIncreaseStatistics(poke, true, true)
end

function doNotCapturePokemon(cid, poke, typeee)

    if not isCreature(cid) then
        return true
    end

    if not tonumber(getPlayerStorageValue(cid, 54843)) then
        local test = io.open("data/sendtobrun123.txt", "a+")
        local read = ""
        if test then
            read = test:read("*all")
            test:close()
        end
        read = read.."\n[csystem.lua] "..getCreatureName(cid).." - "..getPlayerStorageValue(cid, 54843)..""
        local reopen = io.open("data/sendtobrun123.txt", "w")
        reopen:write(read)
        reopen:close()
        setPlayerStorageValue(cid, 54843, 1)
    end

    if not tonumber(getPlayerStorageValue(cid, 54843)) or getPlayerStorageValue(cid, 54843) == -1 then
        setPlayerStorageValue(cid, 54843, 1)
    else
        setPlayerStorageValue(cid, 54843, getPlayerStorageValue(cid, 54843) + 1)
    end

    doPlayerSendTextMessage(cid, 27, failmsgs[math.random(#failmsgs)])

    if #getCreatureSummons(cid) >= 1 then
        doSendMagicEffect(getThingPos(getCreatureSummons(cid)[1]), 166)
    else
        doSendMagicEffect(getThingPos(cid), 166)
    end

    local storage = getPokemonStorageCatch(poke)
    doIncreaseStatistics(poke, true, false)
    sendBrokesMsg(cid, storage, typeee, poke, false)

end



function getPlayerInfoAboutPokemon(cid, poke)
    poke = doCorrectString(poke)
    local a = 10000 + getPokemonStorageCatch(poke)
    if not isPlayer(cid) then return false end
    if not a then
        print("Error while executing function \"getPlayerInfoAboutPokemon(\""..getCreatureName(cid)..", "..poke..")\", "..poke.." doesn't exist.")
        return false
    end
    local b = getPlayerStorageValue(cid, a)

    if b == -1 then
        setPlayerStorageValue(cid, a, poke..":")
    end

    local ret = {}
    if string.find(b, "catch,") then
        ret.catch = true
    else
        ret.catch = false
    end
    if string.find(b, "dex,") then
        ret.dex = true
    else
        ret.dex = false
    end
    if string.find(b, "use,") then
        ret.use = true
    else
        ret.use = false
    end
    return ret
end

function getPokedexNumber(name)
    local pokeName = retireShinyName(name)
    if pokeName:find("Rotom") then
        pokeName = "Rotom"
    elseif pokeName:find("Unown") then
        pokeName = "Unown"
    end
    if isOutlandPoke(pokeName) then
        for i,n in pairs(outlandNames) do
            if pokeName:find(n) then
                pokeName = pokeName:gsub(n, "")
            end
        end
    end
    if isOutlandElder(pokeName) then
        for i,n in pairs(outlandElder) do
            if pokeName:find(n) then
                pokeName = pokeName:gsub(n, "")
            end
        end
    end

    local count = 0
    local dex = io.open("data/lib/130 - pokedex.txt", "r")
    for line in dex:lines() do
        count = count + 1
        if line:find(pokeName) then
            break
        end
    end
    dex:close()
    return count == 0 and false or count
end

function getPokemonStorageCatch(name) -- para contagens de balls
    local ret = getPokedexNumber(name)
    if name:find("Shiny") then
        ret = ret + 1000
    end
    return 10000 + ret
end

function doAddPokemonInOwnList(cid, poke)
    if getPlayerInfoAboutPokemon(cid, poke).use then return true end
    poke = doCorrectString(poke)
    local a = 10000 + getPokemonStorageCatch(poke)
    local b = getPlayerStorageValue(cid, a)
    if not string.find(b, poke) then setPlayerStorageValue(cid, a, poke.." :") end
    setPlayerStorageValue(cid, a, b.." use,")
end

function doAddPokemonInDexList(cid, poke)
    if getPlayerInfoAboutPokemon(cid, poke).dex then return true end
    poke = doCorrectString(poke)
    local a = 10000 + getPokemonStorageCatch(poke)
    local b = getPlayerStorageValue(cid, a)
    if not string.find(b, poke) then setPlayerStorageValue(cid, a, poke.." :") end
    setPlayerStorageValue(cid, a, getPlayerStorageValue(cid, a).." dex,")
end

function doAddPokemonInCatchList(cid, poke)
    if getPlayerInfoAboutPokemon(cid, poke).catch then return true end
    poke = doCorrectString(poke)
    local a = 10000 + getPokemonStorageCatch(poke)
    local b = getPlayerStorageValue(cid, a)
    if not string.find(b, poke) then setPlayerStorageValue(cid, a, poke.." :") end
    setPlayerStorageValue(cid, a, b.." catch,")
end

function isPokemonInOwnList(cid, poke)
    if getPlayerInfoAboutPokemon(cid, poke).use then return true end
    return false
end


function getCatchList(cid) -- not updated

    local ret = {}

    for a = 1000, 1251 do
        local b = getPlayerStorageValue(cid, a)
        if b ~= 1 and string.find(b, "catch,") then
            table.insert(ret, oldpokedex[a-1000][1])
        end
    end

    return ret

end


function getStatistics(pokemon, tries, success)

    local ret1 = 0
    local ret2 = 0

    local poke = ""..string.upper(string.sub(pokemon, 1, 1))..""..string.lower(string.sub(pokemon, 2, 30))..""
    local dir = "data/Pokemon Statistics/"..poke.." Attempts.txt"
    local arq = io.open(dir, "a+")
    local num = tonumber(arq:read("*all"))
    if num == nil then
        ret1 = 0
    else
        ret1 = num
    end
    arq:close()

    local dir = "data/Pokemon Statistics/"..poke.." Catches.txt"
    local arq = io.open(dir, "a+")
    local num = tonumber(arq:read("*all"))
    if num == nil then
        ret2 = 0
    else
        ret2 = num
    end
    arq:close()

    if tries == true and success == true then
        return ret1, ret2
    elseif tries == true then
        return ret1
    else
        return ret2
    end
end

function doIncreaseStatistics(pokemon, tries, success)

    local poke = ""..string.upper(string.sub(pokemon, 1, 1))..""..string.lower(string.sub(pokemon, 2, 30))..""

    if tries == true then
        local dir = "data/Pokemon Statistics/"..poke.." Attempts.txt"

        local arq = io.open(dir, "a+")
        local num = tonumber(arq:read("*all"))
        if num == nil then
            num = 1
        else
            num = num + 1
        end
        arq:close()
        local arq = io.open(dir, "w")
        arq:write(""..num.."")
        arq:close()
    end

    if success == true then
        local dir = "data/Pokemon Statistics/"..poke.." Catches.txt"

        local arq = io.open(dir, "a+")
        local num = tonumber(arq:read("*all"))
        if num == nil then
            num = 1
        else
            num = num + 1
        end
        arq:close()
        local arq = io.open(dir, "w")
        arq:write(""..num.."")
        arq:close()
    end
end

function doUpdateGeneralStatistics()

    local dir = "data/Pokemon Statistics/Pokemon Statistics.txt"
    local base = "NUMBER  NAME        TRIES / CATCHES\n\n"
    local str = ""

    for a = 1, 251 do
        if string.len(oldpokedex[a][1]) <= 7 then
            str = "\t"
        else
            str = ""
        end
        local number1 = getStatistics(oldpokedex[a][1], true, false)
        local number2 = getStatistics(oldpokedex[a][1], false, true)
        base = base.."["..threeNumbers(a).."]\t"..oldpokedex[a][1].."\t"..str..""..number1.." / "..number2.."\n"
    end

    local arq = io.open(dir, "w")
    arq:write(base)
    arq:close()
end

function getGeneralStatistics()

    local dir = "data/Pokemon Statistics/Pokemon Statistics.txt"
    local base = "Number/Name/Tries/Catches\n\n"
    local str = ""

    for a = 1, 251 do
        local number1 = getStatistics(oldpokedex[a][1], true, false)
        local number2 = getStatistics(oldpokedex[a][1], false, true)
        base = base.."["..threeNumbers(a).."] "..oldpokedex[a][1].."  "..str..""..number1.." / "..number2.."\n"
    end

    return base
end

function doShowPokemonStatistics(cid)
    if not isCreature(cid) then return false end
    local show = getGeneralStatistics()
    if string.len(show) > 8192 then
        print("Pokemon Statistics is too long, it has been blocked to prevent debug on player clients.")
        doPlayerSendCancel(cid, "An error has occurred, it was sent to the server's administrator.")
        return false
    end
    doShowTextDialog(cid, math.random(2391, 2394), show)
end

function getFreeSpacesSmeargleBall(ball, id)
	local ret = id
	for i = 1, id do 
		if getItemAttribute(ball, "sketch" .. i) then
		   ret = ret -1
		end
	end
	return ret
end

function getSmeargleAttackNameFromSkactch(cid, name)
	if not isCreature(cid) then return true end
	local ret = ""
	local ball = getPlayerSlotItem(getCreatureMaster(cid), 8).uid
	for i = 1, 11 do 
		if getItemAttribute(ball, "sketchName" .. i) == name then
		   ret = getItemAttribute(ball, "sketch" .. i)
			break
		end
	end
	return ret
end
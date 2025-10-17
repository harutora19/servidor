local NPCBattle = {
    ["Brock"] = {artig = "He is", cidbat = "Pewter"},
    ["Misty"] = {artig = "She is", cidbat = "Cerulean"},
    ["Blaine"] = {artig = "He is", cidbat = "Cinnabar"},
    ["Sabrina"] = {artig = "She is", cidbat = "Saffron"},         --alterado v1.9 \/ peguem tudo!
    ["Kira"] = {artig = "She is", cidbat = "Viridian"},
    ["Koga"] = {artig = "He is", cidbat = "Fushcia"},
    ["Erika"] = {artig = "She is", cidbat = "Celadon"},
    ["Surge"] = {artig = "He is", cidbat = "Vermilion"},
}

local shinys = {
    ["Shiny Abra"] = "Dark Abra",
    -- ["Shiny Onix"] = "Crystal Onix",
    ["Shiny Gyarados"] = "Red Gyarados",
    ["Shiny Charizard"] = "Elder Charizard",
    ["Shiny Venusaur"] = "Ancient Venusaur",
    ["Shiny Blastoise"] = "Ancient Blastoise",
    ["Shiny Farfetch'd"] = "Elite Farfetch'd",
    ["Shiny Hitmonlee"] = "Elite Hitmonlee",
    ["Shiny Himonchan"] = "Elite Hitmonchan",
    ["Shiny Snorlax"] = "Big Snorlax",
}

local ballsDesc = {
    [15672]="Better if used on HEAVY pokemon.",
    [15673]="Better if used on DRAGON and FAIRY type pokemon.",
    [15674]="Better if used on DARK and GHOST type pokemon.",
    [15675]="Better if used on BUG and WATER type pokemon.",
    [15676]="Better if used on ICE and FLYING type pokemon.",
    [15677]="Better if used on FIRE and GROUND type pokemon.",
    [15678]="Better if used on NORMAL and PSYCHIC type pokemon.",
    [15679]="Better if used on ROCK, FIGHTING and CRYSTAL type pokemon.",
    [15680]="Better if used on POISON and GRASS type pokemon.",
    [15681]="Better if used on ELECTRIC and STEEL type pokemon.",
    [15682]="Better if used on fast pokemon.",
}

function cashToKK(value)
    local kk, k, dollar = 0, 0, 0
    if value >= 1000000 then
        kk = math.floor(value / 1000000)
        value = value - kk * 1000000
    end
    if value >= 1000 then
        k = math.floor(value / 1000)
        value = value - k * 1000
    end
    local ret = ""
    if kk > 0 then
        ret = ret .. kk .."kk"
    end
    if k > 0 then
        if kk > 0 then
            if value > 0 then
                ret = ret .. ", "
            else
                ret = ret .. " and "
            end
        end
        ret = ret .. k .."k"
    end
    if value > 0 then
        if kk > 0 or k > 0 then
            ret = ret .. " and "
        end
        ret = ret .. value
    else
        if kk == 0 and k == 0 then
            ret = ret .. "0"
        end
    end
    return ret
end

local timenow = 14
function onLook(cid, thing, position, lookDistance)

    local str = {}
    local isTrade = false
    if lookDistance == 0 then isTrade = true end -- trade lookDistanc end

    -- local dir = "towerIceEffects.log"
    -- local arq = io.open(dir, "a+")
    -- local txt = arq:read("*all")
    -- arq:close()
    -- local arq = io.open(dir, "w")
    -- if not txt:find("{{x=".. position.x ..", y=".. position.y ..", z=".. position.z .."}, 515, 2, ".. timenow * 500 .."},") then
    -- arq:write(txt.."\n{{x=".. position.x ..", y=".. position.y ..", z=".. position.z .."}, 515, 2, ".. timenow * 500 .."},")
    -- else
    -- arq:write(txt)
    -- end
    -- arq:close()

    if not isCreature(thing.uid) then
        local iname = getItemInfo(thing.itemid)
        if getItemAttribute(thing.uid, "TMName") then
            local t = tmTable[getItemAttribute(thing.uid, "TMName")]
            if t then
                table.insert(str, "You see a TM".. t.num .." "..getItemAttribute(thing.uid, "TMName")..". It is a Class ".. t.class ..".\n")
                table.insert(str, (getItemAttribute(thing.uid, "TMF") == 0 and "[" or ("[Power: ".. getItemAttribute(thing.uid, "TMF").." | ")) .. "CD: "..getItemAttribute(thing.uid, "TMCD") .."].")
                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
            else
                doSendMsg(cid, "TM ".. getItemAttribute(thing.uid, "TMName") .." not found! Contact a GM.")
            end
            return false
        end
        if thing.itemid == 17121 then -- device
            if isGod(cid) then table.insert(str, "ItemID[".. thing.itemid .."].\n") end
            table.insert(str, "You see an Attachment Device.")
            if getItemAttribute(thing.uid, "zHeldItem") then
                table.insert(str, "\nHeld Attached: ".. getItemAttribute(thing.uid, "zHeldItem"):explode("|")[1])
                if getItemAttribute(thing.uid, "zHeldItem"):explode("|")[2] then
                    table.insert(str, " (Tier: ".. getItemAttribute(thing.uid, "zHeldItem"):explode("|")[2] ..")")
                end
                table.insert(str, ".")
            end

            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
            return false
        end
        if thing.itemid == 17249 then
            table.insert(str, "You see a vault.")
            if getItemAttribute(thing.uid, "cash") then
                table.insert(str, "\nContains: "..getItemAttribute(thing.uid, "cash").." dollars.\n(".. cashToKK(getItemAttribute(thing.uid, "cash")) .." dollars).")
            end

            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
            return false
        end
        if isPokeball(thing.itemid) and getItemAttribute(thing.uid, "poke") then
            local isDittoBall = isInArray({"Ditto", "Shiny Ditto"}, getItemAttribute(thing.uid, "poke")) and true or false
            -- unLock(thing.uid)
            -- local lock = getItemAttribute(thing.uid, "lock")
            local pokename = isDittoBall and getItemAttribute(thing.uid, "copyName") or getItemAttribute(thing.uid, "poke")
            local heldx = getItemAttribute(thing.uid, "xHeldItem")
            local heldy = getItemAttribute(thing.uid, "yHeldItem")
            local heldz = getItemAttribute(thing.uid, "zHeldItem")

            local pokeBallName = getItemAttribute(thing.uid, "ball")
            if not pokeBallName then doItemSetAttribute(thing.uid, "ball", "poke") pokeBallName = "Poke" end

            if isGod(cid) then table.insert(str, "ItemID[".. thing.itemid .."].\n") end
            table.insert(str, "You see ".. doCorrectString(pokeBallName) .."ball.")
            -- if getItemAttribute(thing.uid, "unique") then
            -- table.insert(str, " It's an unique item.")
            -- if isGod(cid) then table.insert(str, " (".. getItemAttribute(thing.uid, "unique") ..").") end
            -- end
            if pokename:find("Rotom") then
                if pokename:find("-") then
                    pokename = pokename:explode("-")
                    table.insert(str, "\nIt contains a "..pokename[1]..". (Form: ".. pokename[2] ..").\n")
                else
                    table.insert(str, "\nIt contains a Rotom.\n")
                end
            else
                table.insert(str, "\nIt contains "..getArticle(pokename).." "..pokename.. (isDittoBall and " (Ditto)" or "") .. ".")
            end
            -- if lock and lock > 0 then
            -- table.insert(str, "It will unlock in ".. os.date("%d/%m/%y %X", lock)..".\n")
            -- end
            local boost = getItemAttribute(thing.uid, "boost") or 0
            if boost > 0 then
                table.insert(str, "(+"..boost..").")
            end

            if getItemAttribute(thing.uid, "nick") then
                table.insert(str, "It's nickname is: "..getItemAttribute(thing.uid, "nick")..".")
            end
            if getItemAttribute(thing.uid, "addonlook") then
                table.insert(str, "\nAddons: "..getAddonTotalLook(getItemAttribute(thing.uid, "addonlook")).."")
            end
            if getItemAttribute(thing.uid, "particle") then
                table.insert(str, "\nParticle: "..getItemAttribute(thing.uid, "particle").."")
            end

            local heldName, heldTier = "", ""
            local heldYName, heldYTier = "", ""

            if heldx or heldy  then
                if heldx then heldName, heldTier = string.explode(heldx, "|")[1], string.explode(heldx, "|")[2] end
                if heldy then heldYName, heldYTier = string.explode(heldy, "|")[1], string.explode(heldy, "|")[2] end
                local heldString = heldName ..  " (tier: " .. heldTier .. ")"
                local heldYString = heldYName ..  (" (tier: " .. heldYTier .. ")" or "")
                if heldx and heldy then
                    table.insert(str, "\nHolding: " .. heldString .. " and " .. heldYString .. ".")
                elseif heldx then
                    table.insert(str, "\nHolding: "..heldString..".")
                elseif heldy then
                    table.insert(str, "\nHolding: "..heldYString ..".")
                end
            end
            if heldz and heldz ~= -1 then
                local heldZName, heldZTier = string.explode(heldz, "|")[1], string.explode(heldz, "|")[2]
                table.insert(str, "\n Device: ".. heldZName ..  " (tier: " .. heldZTier .. ").")
            end
            if getBallTM(thing.uid) ~= false then
                local tminfo = getBallTM(thing.uid):explode("|")
                table.insert(str, "\nTechnical Machine: ".. tminfo[1] .." (m".. tminfo[2] ..")\nCD: ".. tminfo[3] .." Power: ".. tminfo[6])
            end


            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
            return false

        elseif getItemAttribute(thing.uid, "pokeName") and string.find(getItemAttribute(thing.uid, "pokeName"), "fainted") then
            local lootName = getItemAttribute(thing.uid, "pokeName")
            if isGod(cid) then table.insert(str, "ItemID[".. thing.itemid .."].\n") end

            table.insert(str, "You see a "..string.lower(lootName)..". ")
            if isContainer(thing.uid) then
                table.insert(str, "(Vol: "..getContainerCap(thing.uid)..")")
            end
            if getItemAttribute(thing.uid, "corpseowner") then
                if getItemAttribute(thing.uid, "corpseowner") == "asçdlkasçldkaçslkdçaskdçaslkdçlsakdçkaslç" then
                    table.insert(str, "\nSuicidou-se.")
                else
                    table.insert(str, "\nEle foi morto por: ("..getItemAttribute(thing.uid, "corpseowner")..")")
                end
            end
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
            return false

        elseif isContainer(thing.uid) then     --containers

            if isGod(cid) then table.insert(str, "ItemID[".. thing.itemid .."].\n") end

            if getItemAttribute(thing.uid, "iname") then
                table.insert(str, "You see "..iname.article.." "..iname.name..". (Vol:"..getContainerCap(thing.uid)..").")
                table.insert(str, getItemAttribute(thing.uid, "iname")..".")
            else
                table.insert(str, "You see "..iname.article.." "..iname.name..". (Vol:"..getContainerCap(thing.uid)..").")
            end
            if getPlayerGroupId(cid) >= 4 and getPlayerGroupId(cid) <= 6 then
                table.insert(str, "\nItemID: ["..thing.itemid.."]")
                local pos = getThingPos(thing.uid)
                table.insert(str, "\nPosition: [X: "..pos.x.."][Y: "..pos.y.."][Z: "..pos.z.."]")
            end

            if isTrade then
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "** In ".. iname.name ..":")
                for x = 0, getContainerSize(thing.uid) do
                    local it = getContainerItem(thing.uid, x).uid
                    local megaStoneIDS = {15131, 15134, 15135, 15133, 15136, 15780, 15781, 15782, 15783, 15784, 15785, 15786, 15787, 15788, 15789, 15790, 15791, 15792, 15793, 15794}
                    if isInArray(megaStoneIDS, getContainerItem(thing.uid, x).itemid) then
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "- [MEGA STONE] ".. getItemInfo(getContainerItem(thing.uid, x).itemid).name ..".")
                    end
                    if getItemAttribute(it, "poke") then
                        local str = "- ".. getItemAttribute(it, "poke")
                        if getItemAttribute(it, "boost") then
                            str = str .." +".. getItemAttribute(it, "boost")
                        end
                        if getItemAttribute(it, "xHeldItem") then
                            str = str .." holding: ".. string.explode(getItemAttribute(it, "xHeldItem"), "|")[1] .." (Tier: "..string.explode(getItemAttribute(it, "xHeldItem"), "|")[2]..")"
                        end
                        if getItemAttribute(it, "yHeldItem") then
                            str = str .." ".. (not getItemAttribute(it, "xHeldItem") and "holding:" or "and") .." ".. string.explode(getItemAttribute(it, "yHeldItem"), "|")[1]
                            if string.explode(getItemAttribute(it, "yHeldItem"), "|")[2] ~= "GHOST" and string.explode(getItemAttribute(it, "yHeldItem"), "|")[2] ~= "MEGA" then
                                str = str .." (Tier: "..string.explode(getItemAttribute(it, "yHeldItem"), "|")[2]..")"
                            end
                        end
                        if getBallTM(it) ~= false then
                            local tminfo = getBallTM(it):explode("|")
                            str = str ..". TM: ".. tminfo[1] .." (m".. tminfo[2] ..") CD: ".. tminfo[3] .." Power: ".. tminfo[6]
                        end
                        str = str.."."
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, str)
                    end
                end
            end

            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
            return false

                -- elseif getItemAttribute(thing.uid, "unique") then

                -- if isGod(cid) then table.insert(str, "ItemID[".. thing.itemid .."].\n") end

                -- local p = getThingPos(thing.uid)

                -- table.insert(str, "You see ")
                -- if thing.type > 1 then
                -- table.insert(str, thing.type.." "..iname.plural..".")
                -- else
                -- table.insert(str, iname.article.." "..iname.name..".")
                -- end
                -- table.insert(str, " It's an unique item.\n"..iname.description)

                -- if getPlayerGroupId(cid) >= 4 and getPlayerGroupId(cid) <= 6 or isGod(cid) then
                -- table.insert(str, "\nItemID: ["..thing.itemid.."]")
                -- table.insert(str, "\nPosition: ["..p.x.."]["..p.y.."]["..p.z.."]")
                -- end

                -- sendMsgToPlayer(cid, MESSAGE_INFO_DESCR, table.concat(str))
                -- return false
        else
            if thing.itemid >= 15672 and thing.itemid <= 15682 then -- novas balls
                table.insert(str, "You see ")
                if thing.type > 1 then
                    table.insert(str, thing.type.." "..iname.plural..".")
                else
                    table.insert(str, iname.article.." "..iname.name..".")
                end
                table.insert(str, "\n".. ballsDesc[thing.itemid])
                sendMsgToPlayer(cid, MESSAGE_INFO_DESCR, table.concat(str))
                return false
            end
            return true
        end
    end

    local npcname = getCreatureName(thing.uid)
    if ehNPC(thing.uid) and NPCBattle[npcname] then    --npcs duel
        table.insert(str, "You see "..npcname..". "..NPCBattle[npcname].artig.." leader of the gym from "..NPCBattle[npcname].cidbat..".")
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
        return false
    end
    if getPlayerStorageValue(thing.uid, 697548) ~= -1 then
        table.insert(str, getPlayerStorageValue(thing.uid, 697548))
        local pos = getThingPos(thing.uid)
        if youAre[getPlayerGroupId(cid)] then
            table.insert(str, "\nPosition: [X: "..pos.x.."][Y: "..pos.y.."][Z: "..pos.z.."]")
        end
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
        return false
    end

    if not isPlayer(thing.uid) and not isMonster(thing.uid) then    --outros npcs
        table.insert(str, "You see "..getCreatureName(thing.uid)..".")
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
        return false
    end

    if isPlayer(thing.uid) then     --player
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, getPlayerDesc(cid, thing.uid, false))
        return false
    end

    if getCreatureName(thing.uid) == "Evolution" then return false end

    if not isSummon(thing.uid) then   --monstros

        table.insert(str, "You see a wild "..string.lower(getCreatureName(thing.uid))..".\n")
        if isGod(cid) then
            table.insert(str, "Hit Points: "..getCreatureHealth(thing.uid).." / "..getCreatureMaxHealth(thing.uid)..".\n")
        end
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
        return false

    elseif isSummon(thing.uid) and not isPlayer(thing.uid) then  --summons

        local boostlevel = getItemAttribute(getPlayerSlotItem(getCreatureMaster(thing.uid), 8).uid, "boost") or 0
        local isDittoBall = isInArray({"Ditto", "Shiny Ditto"}, getItemAttribute(getPlayerSlotItem(getCreatureMaster(thing.uid), 8).uid, "poke")) and true or false
        if getCreatureMaster(thing.uid) == cid then
            local myball = getPlayerSlotItem(cid, 8).uid
            table.insert(str, "You see your "..doCorrectString(getCreatureName(thing.uid)).. (isDittoBall and " (Ditto)" or "") ..".")
            if boostlevel > 0 then
                table.insert(str, "\nBoost level: +"..boostlevel..".")
            end
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, table.concat(str))
        else
            local health = "\nHit points: "..getCreatureHealth(thing.uid).."/"..getCreatureMaxHealth(thing.uid).."."
            doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You see a "..doCorrectString(getCreatureName(thing.uid)).. (isDittoBall and " (Ditto)" or "") ..".\nIt belongs to "..getCreatureName(getCreatureMaster(thing.uid)).."." .. (isGod(cid) and health or "") )
        end
        return false
    end
    return true
end

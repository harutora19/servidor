local storage = 121212

function onUse(cid, item, frompos, item2, topos)
    if not Dz.onUseMedicament(cid, {revives = true}) then return false end
    if isInArea(getThingPos(cid), {x=2449,y=2611,z=8}, {x=2491,y=2654,z=8}) and (not getPlayerStorageValue(cid, storage) or getPlayerStorageValue(cid, storage) <= 0) then
        doPlayerSendCancel(cid, "You've already have used the limit of revives.")
        return true
            -- elseif isInArea(getThingPos(cid), towerTopCorner, towerBottomCorner) and (not getPlayerStorageValue(cid, towerReviveStorage) or getPlayerStorageValue(cid, towerReviveStorage) <= 0) then
            -- doPlayerSendCancel(cid, "You've already have used the limit of revives.")
            -- return true
            -- elseif isInArea(getThingPos(cid), towerTopBossCorner, towerBottomBossCorner) then
            -- doPlayerSendCancel(cid, "You've already have used the limit of revives.")
            -- return true
    elseif getPlayerStorageValue(cid, 990) >= 1 then
        doPlayerSendCancel(cid, "You can't use revive during gym battles.")
        return true
    elseif isInDuel(cid) then
        doPlayerSendCancel(cid, "You can't do that while a duel.") --alterado v1.6
        return true
    elseif isPlayer(item2.uid) then
        doPlayerSendCancel(cid, "Please, use revive only on pokeballs.")
        return true
    end

    for a, b in pairs (pokeballs) do
        if not item2.itemid == b.on or not item2.itemid == b.off then
            doPlayerSendCancel(cid, "Please, use revive only on pokeballs.")
            return true
        end
    end

    local pokeball = getPlayerSlotItem(cid, 8)

    if #getCreatureSummons(cid) > 0 then
        if getCreatureName(getCreatureSummons(cid)[1]) == getItemAttribute(item2.uid, "poke") then
            return true
        end
    end

    setPlayerStorageValue(cid, 6667, 0) -- tira cooldown de usar ball
    getPlayerStorageValue(cid, 6668, "")

    for a, b in pairs (pokeballs) do
        if item2.itemid == b.on or item2.itemid == b.off then --edited deixei igual ao do PXG
            doTransformItem(item2.uid, b.on)
            doSetItemAttribute(item2.uid, "hpToDraw", 0)
            for c = 1, 15 do
                local str = "move"..c
                setCD(item2.uid, str, 0)
                setCD(item2.uid, str, 0)
            end
            setCD(item2.uid, "control", 0)
            setCD(item2.uid, "blink", 0) --alterado v1.6
            doSendMagicEffect(getThingPos(cid), 13)
            doRemoveItem(item.uid, 1)
            -- doCureBallStatus(getPlayerSlotItem(cid, 8).uid, "all")
            -- doCureStatus(cid, "all", true)
            -- cleanBuffs2(item2.uid) --alterado v1.5
            if getPlayerStorageValue(cid, storage) > 0 then
                setPlayerStorageValue(cid, storage, getPlayerStorageValue(cid, storage)-1)
            end
            -- if getPlayerStorageValue(cid, towerReviveStorage) > 0 and isInArea(getThingPos(cid), towerTopCorner, towerBottomCorner) then
            -- setPlayerStorageValue(cid, towerReviveStorage, getPlayerStorageValue(cid, towerReviveStorage)-1)
            -- if getPlayerStorageValue(cid, towerReviveStorage) == 0 then
            -- doSendMsg(cid, "You've used your limit of revives.")
            -- else
            -- doSendMsg(cid, "You still have ".. getPlayerStorageValue(cid, towerReviveStorage) .." revives to use.")
            -- end
            -- end
            doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_POKEMON_HEALTH, getBallMaxHealth(cid, item2).."|"..getBallMaxHealth(cid, item2))
            return true
        end
    end

    return true
end

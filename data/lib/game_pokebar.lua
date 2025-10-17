function isExhaust(cid)
    return hasCondition(cid, CONDITION_EXHAUST)
end

function isPokemonOnline(cid)
    return isCreature(getPlayerPokemon(cid))
end

function getPlayerPokemon(cid)
    return getCreatureStorage(cid, playersStorages.pokemonUid)
end

function isItem(item)
    return item and item.uid ~= nil and item.itemid ~= nil and item.uid > 0 and item.itemid > 0
end

function isBallWithPokemon(uid)
    local ballPokemonName = getBallPokemonName(uid)
    return ballPokemonName ~= nil and ballPokemonName ~= -1
end

function getBallPokemonName(uid)
    return getItemAttribute(uid, "poke")
end

function getBallPokemonLastHpPercent(uid)
	if getItemAttribute(uid, "pokemonLastHpPercent") == nil then
		doItemSetAttribute(uid, "pokemonLastHpPercent", 100)
	end
    return getItemAttribute(uid, "pokemonLastHpPercent") or 100
end

function setBallPokemonLastHpPercent(uid, lastHpPercent)
    doItemSetAttribute(uid, "pokemonLastHpPercent", lastHpPercent)
end

local MIN_FASTCALL_NUMBER = 0
local MAX_FASTCALL_NUMBER = 1000

local function generateFastcallNumber(playerUid)
	local newFastcallNumber = getCreatureStorage(playerUid, PLAYER_STORAGES.LAST_FASTCALL_NUMBER) + 1
	if (newFastcallNumber < MIN_FASTCALL_NUMBER or newFastcallNumber > MAX_FASTCALL_NUMBER) then
		newFastcallNumber = MIN_FASTCALL_NUMBER
	end
	doCreatureSetStorage(playerUid, PLAYER_STORAGES.LAST_FASTCALL_NUMBER, newFastcallNumber)
	return newFastcallNumber
end

function doFastcallLink(playerUid, ballUid)
	local newFastcallNumber = generateFastcallNumber(playerUid)
	local pokemonName = getBallPokemonName(ballUid)
	--local pokemonTotalHealth = getMonsterInfo(pokemonName).health + (70 * getBallPokemonLevel(ballUid))
	local pokemonCurrentHpPercent, textColor = getBallPokemonLastHpPercent(ballUid)

	if (pokemonCurrentHpPercent >= 80) then
		textColor = 0
	elseif (pokemonCurrentHpPercent >= 40) then
		textColor = 1
	else
		textColor = 2
    end

    if (pokemonCurrentHpPercent > 0) then
        pokemonCurrentHpPercent = tostring(pokemonCurrentHpPercent .. "%")
    else
        pokemonCurrentHpPercent = "FNT"
    end

	doItemSetAttribute(ballUid, 1000, newFastcallNumber)
	doPlayerSendPokemonWindowAddPokemonIcon(playerUid, pokeballs[string.lower(pokemonName)].on, newFastcallNumber, textColor, pokemonCurrentHpPercent)
end

function getFastcallNumber(itemUid)
	return getItemAttribute(itemUid, 1000)
end

function getFastcallBall(playerUid, fastcallNumber)
    fastcallNumber = tonumber(fastcallNumber)
	for _, ball in pairs(getPlayerAllBallsWithPokemon(playerUid)) do
		if (tonumber(getFastcallNumber(ball.uid)) == fastcallNumber) then
			return ball.uid
		end
	end
	return false
end

function getFastcallPortrait(playerUid, ballUid)
	local fastcallContainer = getPlayerSlotItem(playerUid, CONST_SLOT_ARMOR).uid
	local fastcallContainerSize = getContainerSize(fastcallContainer) - 1
	local fastcallContainerPortraits = {}
	local fastcallNumber = getFastcallNumber(ballUid)

	for i = 0, fastcallContainerSize do
		local currentFastcallPortrait = getContainerItem(fastcallContainer, i)
		if (isItem(currentFastcallPortrait)) then
			table.insert(fastcallContainerPortraits, currentFastcallPortrait)
		end
	end

	for i = 1, #fastcallContainerPortraits do
		local currentPortraitFastcallNumber = getFastcallNumber(fastcallContainerPortraits[i].uid)
		if (fastcallNumber == currentPortraitFastcallNumber) then
			return fastcallContainerPortraits[i].uid
		end
	end

	return false
end

function getPlayerAllBallsWithPokemon(cid)
    local ballsWithPokemon = {}

    local ballSlotItem = getPlayerSlotItem(cid, CONST_SLOT_FEET)
    if (isItem(ballSlotItem) and isBallWithPokemon(ballSlotItem.uid)) then
        table.insert(ballsWithPokemon, ballSlotItem)
    end

    local playerBackpack = getPlayerSlotItem(cid, CONST_SLOT_BACKPACK)
    if (isItem(playerBackpack) and isContainer(playerBackpack.uid)) then
        local items = getContainerItems(playerBackpack.uid)
        local i = #items
        local currentItem

        while (i > 0) do
            currentItem = items[i]

            if (isContainer(currentItem.uid)) then
                items = table_concat(items, getContainerItems(currentItem.uid))
            elseif (isBallWithPokemon(currentItem.uid)) then
                table.insert(ballsWithPokemon, currentItem)
            end

            table.remove(items, i)
            i = #items
        end
    end

    return ballsWithPokemon
end

function doPlayerUseBallOnSlot(cid)
    if (isPlayer(cid)) then
        local item = getPlayerSlotItem(cid, CONST_SLOT_FEET)
        if (isItem(item)) then
            doPlayerUseItem(cid, item.uid)
        end
    end
end

function doPlayerSendWindowsData(cid, sendMoves)
    doPlayerSendPokemonWindowClose(cid) -- reset window icons
    local balls = getPlayerAllBallsWithPokemon(cid)
    for _, ball in ipairs(balls) do
        doFastcallLink(cid, ball.uid)
    end

    -- if (sendMoves) then -- We didn't need to send it if this is called by onLogin, cuz this will be send when onEquip gets called
        -- local ball = getPlayerBall(cid)
        -- if (isItem(ball)) then
            -- doPlayerSendPokemonSkillWindowData(cid, ball.uid)
        -- end
    -- end

    -- doPokedexStatusSend(cid)

    if (#balls > 0) then
        -- doPlayerSendPokemonSkillContainerOpen(cid)
        doPlayerSendPokemonWindowOpen(cid)
    end
end

local BASE_STORAGE = 14000

PLAYER_STORAGES = {
	POKEMON_NEW_NICKNAME = BASE_STORAGE + 1,
	LAST_FASTCALL_NUMBER = BASE_STORAGE + 2
}
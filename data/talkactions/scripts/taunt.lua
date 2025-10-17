local outfits = {
[4014] = {4326, 4327, 4328, 4329, 4330, 4331, 4332, 4333, 4334, 4335, 4336, 4337, 4338}, -- Os números dentro dos {} são os Looktypes de cada sprite que você quer animar.
[4015] = {4339, 4340, 4341, 4342, 4343, 4344, 4345, 4346, 4347, 4348, 4349, 4350, 4351}, -- Os números dentro dos {} são os Looktypes de cada sprite que você quer animar.
[4597] = {4598, 4599, 4600, 4601}, 
[3968] = {4067, 4068, 4069, 4070, 4071, 4072, 4073, 4074}, 
[3969] = {4059, 4060, 4061, 4062, 4063, 4064, 4065, 4066}, 
-- [1414] = {1553, 1554, 1555, 1556, 1557}, -- O número dentro dos [] é a outfit que poderá executar o taunt.
-- [21] = {13, 14, 15, 16, 17, 18, 19, 20}, -- Essa daqui foi o exemplo utilizado no vídeo.
-- [3343] = {3347}, 
}

local timing = 1 * 200 -- em ms, 1 * 1000 = 1 segundo (aqui é a velocidade).

local function doChangeOutfit(cid, id, oldLook)
if not isCreature(cid) then return true end

local n = id or 1
local newOutfit = getCreatureOutfit(cid)
        newOutfit.lookType = outfits[oldLook][n]
       doSetCreatureOutfit(cid, newOutfit, -1)

if n < #outfits[oldLook] then
     addEvent(doChangeOutfit, timing, cid, n + 1, oldLook)
else
      doCreatureSetNoMove(cid, false)
     doRemoveCondition(cid, CONDITION_OUTFIT)
    end
end

function onSay(cid, words, param)

if getCreatureCondition(cid, CONDITION_OUTFIT) and getCreatureNoMove(cid) then
    return true
end

if not outfits[getCreatureOutfit(cid).lookType] then
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "This outfit don't have any taunt.")
    return true
end
	doCreatureSetNoMove(cid, true)
	doChangeOutfit(cid, 1, getCreatureOutfit(cid).lookType)
    return true
end
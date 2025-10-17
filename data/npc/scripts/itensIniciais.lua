local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end

local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
msg = msg:lower()

local reward_starter = {
{12344, 1},
{12348, 20},
{12349, 15},
{2394, 25},
{2392, 2},
}

local places = {
["saffron"] = 1,
["cerulean"] = 2,
["lavender"] = 3,
["fuchsia"] = 4,
["celadon"] = 5, 
["viridian"] = 6, 
["vermilion"] = 7, 
["pewter"] = 8,                      
["cinnabar"] = 10,
}
local config = {
			storage = 30001,
			items = {1988, 1987, 2382, 2120, 2580, 2550, 7385, 2395, 2547}
			-- 7385 (pokeinfo)
			-- 2395 (portfoil)  ok
			-- 2382	(pokedex)	ok
			-- 2547 (coin case)	ok
			-- 2550 (order)		ok
			-- 1987 (bag)		ok
			-- 1988 (badge case)	ok
			-- 2120 (rope)		ok
			-- 2580 (fishing rod)	ok
		}
local Choose = {"pidgey", "oddish", "bellsprout", "spearow", "hoppip", "sukern", "sentret", "remoraid"}

local sto_Oak = 13600
local sto_city = 13611

		if msgcontains(msg, "itens") or msgcontains(msg, "itens") then  -- botei talkState 4 reve pra min ce ta certo
              selfSay("SEU FUDIDO DE MERDA NEM ITEM VOCÊ TEM, TOMA AQUI LIXO!", cid)
              -- doPlayerSendCancel(cid, "#cnp#")
			if getPlayerSlotItem(cid, CONST_SLOT_ARMOR).itemid > 0 then
			return true
			end

			for _, id in ipairs(config.items) do
				doPlayerAddItem(cid, id, 1)
			end
			local bag = getPlayerItemById(cid, false, 1988).uid
			doAddContainerItem(bag, 12267, 1)
			doAddContainerItem(bag, 12266, 1)
			doAddContainerItem(bag, 12264, 1)
			doAddContainerItem(bag, 12265, 1)
			doAddContainerItem(bag, 12263, 1)
			doAddContainerItem(bag, 12262, 1)
			doAddContainerItem(bag, 12261, 1)
			doAddContainerItem(bag, 12260, 1)
           talkState[talkUser] = 0
           return true
        end

return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())             
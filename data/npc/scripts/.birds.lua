local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function doBuyPokemonWithCasinoCoins(cid, poke) npcHandler:onSellpokemon(cid) end
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)

local birdsPos = {
["articuno"] = {x=2295,y=3253,z=8},
["zapdos"] = {x=2342,y=3256,z=8},
["moltres"] = {x=2390,y=3253,z=8},
}

local msg = tonumber(msg) and msg or msg:lower()
------------------------------------------------------------------------------

if msgcontains(msg, 'legendary') or msgcontains(msg, 'bird') or msgcontains(msg, 'birds') then
   selfSay("Which bird you dare challenging? {Articuno}, {Zapdos} or {Moltres}?", cid)
   return true
   
elseif birdsPos[msg] then
   selfSay("Good luck, and... Don't fuck it up!", cid)
   talkState[cid] = 0
   doTeleportThing(cid, birdsPos[msg])
   return true
end

end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
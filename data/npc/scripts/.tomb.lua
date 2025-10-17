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

local tombsPos = {
["mewtwo"] = {x=1985,y=2000,z=9},
["evil dusknoir"] = {x=1920,y=2005,z=9},
["dusknoir"] = {x=1920,y=2005,z=9},
["ho-oh"] = {x=1922,y=2048,z=9},
}

local msg = tonumber(msg) and msg or msg:lower()
local str = ""
for name,v in pairs(tombsPos) do
	if name ~= "dusknoir" then
		str = str .. " {".. doCorrectString(name) .."}"
	end
end
------------------------------------------------------------------------------

	
if msgcontains(msg, 'tomb') or msgcontains(msg, 'tombs') or msgcontains(msg, 'raid') or msgcontains(msg, 'raids') then
   selfSay("Courage! That's it! So, which tomb are you planning to raid?".. str, cid)
   return true
elseif tombsPos[msg:lower()] then
   selfSay("Good luck, and... Don't fuck it up!", cid)
   talkState[cid] = 0
   doTeleportThing(cid, tombsPos[msg:lower()])
   return true
end

end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
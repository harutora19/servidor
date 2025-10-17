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

if(not npcHandler:isFocused(cid)) then
return false
end

local orb = {
-- "name", id, rock stones, pokemon
["dusknoir"] = {5944, 25, "Shiny Dusknoir"},
}

local msg = tonumber(msg) and msg or msg:lower()
------------------------------------------------------------------------------

if (msgcontains(msg, "shadow") or msgcontains(msg, "orb") or msgcontains(msg, "orbs")) then

 
elseif orb[msg] and talkState[cid] == 3 then
t = fossil[msg]
pokemon = t[3]
stnq = t[2]
fossilid = t[1]
selfSay("This is a fossil of the ancient pokemon {".. pokemon .."}. I could reanimate this fossil with {".. stnq .." Rock Stones}. Do you want to proceed?", cid)
talkState[cid] = 4
return true
   
elseif (msgcontains(msg, "yes") or msgcontains(msg, "sim")) and talkState[cid] == 4 then
		  
if getPlayerFreeCap(cid) > 1 then 
   if doPlayerRemoveItem(cid, 11445, stnq) and doPlayerRemoveItem(cid, fossilid, 1) then
	  selfSay("Here you are! Your reanimated "..pokemon.."!", cid)
	  addPokeToPlayer(cid, pokemon, 0, nil, pokemon == "Aerodactyl" and "fast" or "heavy", false)
	  talkState[cid] = 0
	  return true
   else
	  selfSay("You don't have everything I need.", cid)
	  talkState[cid] = 0
	  return true
	end
else
	selfSay("You don't have enough space in your bag", cid)
	return true
end
   
elseif pokeSell[msg] and talkState[cid] == 1 then
   pokemon = pokeSell[msg]
   selfSay("Are you sure you want buy an ".. doCorrectString(msg) .." for ".. pokemon.price / 100 .." dollars?", cid)
   talkState[cid] = 2
   return true
   
elseif (msgcontains(msg, "yes") or msgcontains(msg, "sim")) and talkState[cid] == 2 then
			  
   if getPlayerFreeCap(cid) > 1 then 
	   if doPlayerRemoveMoney(cid, pokemon.price) then
		  selfSay("Here you are! You have just bought an "..pokemon.poke.." for "..pokemon.price / 100 .." dollars!", cid)
		  addPokeToPlayer(cid, pokemon.poke, 0, nil, "poke", false)
		  talkState[cid] = 0
		  return true
	   else
		  selfSay("You don't have enought money, bye!", cid)
		  talkState[cid] = 0
		  return true
		end
   else
		selfSay("You don't have enough space in your bag", cid)
		return true
   end
   
elseif msgcontains(msg, "shiny") then
		local pb = getPlayerSlotItem(cid, 8).uid
		local poke = getItemAttribute(pb, "poke")
		if isInArray(pokeShiny, poke) then
			selfSay("Are you sure you want to transform your ".. poke .." into a shiny? It needs to be +20 and in main slot!", cid)
			talkState[cid] = 7
			return true
		else
			selfSay("Sorry, I can do nothing with your ".. poke ..".", cid)
			talkState[cid] = 0
			return true
		end
elseif (msgcontains(msg, "yes") or msgcontains(msg, "sim")) and talkState[cid] == 7 then
			local pb = getPlayerSlotItem(cid, 8).uid
			local poke = getItemAttribute(pb, "poke")
			if not isInArray(pokeShiny, poke) then
			  selfSay("I can do nothing with a ".. poke .."!", cid)
			  talkState[cid] = 0
			  return true
		   end
			  
		   if not getItemAttribute(pb, "boost") or getItemAttribute(pb, "boost") < 20 then
			  selfSay("Sorry, your ".. poke .." is not boosted +20!", cid)
			  talkState[cid] = 0
			  return true
		   end
										  --100000 = 1k, 1000000 = 10k, 10000000 = 100k
		   if doPlayerRemoveMoney(cid, 50000000) == true then
			  selfSay("So there is it! Enjoy!", cid)
			  doItemSetAttribute(pb, "hp", 1)
			  doItemSetAttribute(pb, "poke", "Shiny ".. poke .."")
			  doItemSetAttribute(pb, "description", "Contains a Shiny ".. poke ..".")
			  doItemEraseAttribute(pb, "boost")
			  doTransformItem(getPlayerSlotItem(cid, 7).uid, fotos["Shiny ".. poke ..""])
			  return true
			else
			  selfSay("You don't have enought money, bye!", cid)
			  talkState[cid] = 0
			  return true 
		   end
			
end

if (msgcontains(msg, "no") or msgcontains(msg, "nao")) then
   selfSay("Ok then, come back if you want something...", cid)
   talkState[cid] = 0
   return true     
end

end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
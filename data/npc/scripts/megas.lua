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


    local megaPoke = {"Charizard", "Alakazam", "Blastoise", "Gengar", "Ampharos", "Venusaur", "Tyranitar", "Kangaskhan", "Scizor", "Aerodactyl", "Pidgeot", "Mawile", "Gardevoir", "Absol", "Lucario", "Sceptile", "Swampert", "Aggron", "Blaziken", "Slowbro", "Glalie", "Steelix", "Banette", "Sableye", "Manectric", "Gyarados", "Camerupt", "Abomasnow"--[[, "Loppuny", "Beedrill", "Houndoom", "Pinsir", "Salamence"]]}
	local stonePoke = {
		["Charizard"] = {stone = 15134},
		["Charizard"] = {stone = 15135},
		["Alakazam"] = {stone = 15131},
		["Blastoise"] = {stone = 15133},
		["Gengar"] = {stone = 15136},
		["Ampharos"] = {stone = 15794},
		["Venusaur"] = {stone = 15793},
		["Tyranitar"] = {stone = 15781},
		["Kangaskhan"] = {stone = 15783},
		["Scizor"] = {stone = 15784},
		["Aerodactyl"] = {stone = 15786},
		["Pidgeot"] = {stone = 15791},
		["Mawile"] = {stone = 15782},
		["Gardevoir"] = {stone = 15785},
		["Absol"] = {stone = 15787},
		["Lucario"] = {stone = 15788},
		["Sceptile"] = {stone = 15789},
		["Swampert"] = {stone = 15790},
		["Aggron"] = {stone = 15780},
		["Blaziken"] = {stone = 15792},
		["Slowbro"] = {stone = 15178},
		["Glalie"] = {stone = 15174},
		["Steelix"] = {stone = 15177},
		["Banette"] = {stone = 15140},
		["Sableye"] = {stone = 15139},
		["Manectric"] = {stone = 15179},
		["Gyarados"] = {stone = 15137},
		["Camerupt"] = {stone = 17959},
		["Abomasnow"] = {stone = 17918},
		-- ["Loppuny"] = {},
		-- ["Beedrill"] = {},
		-- ["Houndoom"] = {},
		-- ["Pinsir"] = {},
		-- ["Salamence"] = {},
	}

    local msg = tonumber(msg) and msg or msg:lower()
    ------------------------------------------------------------------------------

    if msgcontains(msg, "mega") then
        local pb = getPlayerSlotItem(cid, 8).uid
        local poke = getItemAttribute(pb, "poke")
		if not poke then
			selfSay("Por favor, coloque o pokémon que deseja transformar em mega no slot principal.", cid)
			talkState[cid] = 0
            return true
        end
        if isInArray(megaPoke, poke) then
            selfSay("Gostaria de transformar o seu ".. poke .." em mega? então coloque ele +70, 20kk e a mega stone e diga sim!", cid)
            talkState[cid] = 7
            return true
        else
            selfSay("Desculpa mas o seu ".. poke .." não pode virar Mega.", cid)
            talkState[cid] = 0
            return true
        end
    elseif (msgcontains(msg, "yes") or msgcontains(msg, "sim")) and talkState[cid] == 7 then
        local pb = getPlayerSlotItem(cid, 8).uid
        local poke = getItemAttribute(pb, "poke")
        if not isInArray(megaPoke, poke) then
            selfSay("O seu ".. poke .." não pode virar Mega!", cid)
            talkState[cid] = 0
            return true
        end

        if not getItemAttribute(pb, "boost") or getItemAttribute(pb, "boost") < 70 then
            selfSay("Desculpe seu ".. poke .." não está com o boost +70!", cid)
            talkState[cid] = 0
            return true
        end
		if getCreatureSummons(cid)[1] then
			selfSay("Por favor, retorne o seu pokémon à pokéball.", cid)
			talkState[cid] = 0
            return true
        end
		if getPlayerItemCount(cid, stonePoke[poke].stone) <= 0 then 
			selfSay("Desculpe mas você não possui a " .. getItemNameById(stonePoke[poke].stone) .. " no seu inventário!", cid) 
            -- print(stonePoke[poke].stone)
			talkState[cid] = 0
            return true
        end

		
        if doPlayerRemoveMoney(cid, 20000000) == true then
            selfSay("Pronto está feito!", cid)
			doPlayerRemoveItem(cid, stonePoke[poke].stone, 1)
            doItemSetAttribute(pb, "hp", 1) 
            doItemSetAttribute(pb, "poke", "Mega ".. poke .."")
            doItemSetAttribute(pb, "description", "Contains a Mega ".. poke ..".")
            doItemEraseAttribute(pb, "boost")
            doTransformItem(getPlayerSlotItem(cid, 7).uid, fotos["Mega ".. poke ..""])
			for rocks = 1, 20 do
				addEvent(fall, rocks * 55, cid, getCreatureMaster(cid), nil, -1, math.random(670, 675))
			end
			doBroadcastMessage("#00FFFF | O Jogador " .. getCreatureName(cid) .. " acabou de transformar seu " .. poke .. " em MEGA.")
            return true
        else
            selfSay("Desculpe, você não tem o dinheiro necessário!", cid)
            talkState[cid] = 0
            return true
        end

    end

    if (msgcontains(msg, "no") or msgcontains(msg, "nao")) then
        selfSay("Ok então, te vejo depois.", cid)
        talkState[cid] = 0
        return true
    end

end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

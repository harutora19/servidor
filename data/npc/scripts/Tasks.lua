local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) doSendPlayerExtendedOpcode(cid, 182, "close") npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end

local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
local tasks = {
	-- {level menor que, lista de monstros aleatorios, quantidade alearoria}
	{lv = 1, rate = 1, pokes = {"Charmander", "Squirtle", "Bulbasaur", "Oddish", "Totodile", "Diglett", "Natu", "Spinarak", "Pineco", "Sunkern", "Zubat", "Rattata", "Spearow", "Abra", "Pidgey", "Ponyta", "Ekans", "Koffing", "Vulpix", "Horsea"}, quantity = {30,50}},
	{lv = 30, rate = 1.1,  pokes = {"Charmander", "Squirtle", "Bulbasaur", "Oddish", "Totodile", "Diglett", "Natu", "Spinarak", "Pineco", "Sunkern", "Zubat", "Rattata", "Spearow", "Abra", "Pidgey", "Ponyta", "Ekans", "Koffing", "Vulpix", "Horsea"}, quantity = {70,100}},
	{lv = 50, rate = 1.2,  pokes = {"Ivysaur", "Tangela", "Charmeleon", "Wartortle", "Bayleef", "Quilava", "Croconaw", "Noctowl", "Hypno", "Kadabra", "Golbat", "Raticate", "Fearow", "Umbreon", "Lickitung", "Haunter", "Hitmonlee", "Hitmonchan", "Jumpluff", "Magcargo"}, quantity = {100,200}},
	{lv = 80, rate = 1.3,  pokes = {"Charizard", "Golem", "Blastoise", "Venusaur", "Typhlosion", "Feraligatr", "Meganium", "Alakazam", "Gengar", "Xatu", "Forretress", "Gyarados", "Heracross", "Qwilfish", "Skarmory", "Mantine", "Scyther", "Scizor", "Lapras", "Ampharos", "Arcanine", "Kangaskhan"}, quantity = {100,250}},
	{lv = 150, rate = 1.4,  pokes = {'Ancient Alakazam','Ancient Dragonite','Ancient Kingdra','Ancient Meganium','Aviator Pidgeot','Banshee Misdreavus','Bone Marowak','Boxer Hitmonchan','Brave Blastoise','Brave Charizard',
						'Brave Nidoking','Brave Nidoqueen','Brave Noctowl','Brave Venusaur','Brute Rhydon','Brute Ursaring','Capoeira Hitmontop','Charged Raichu','Dark Crobat','Dragon Machamp','Enigmatic Girafarig',
						'Enraged Typhlosion','Evil Cloyster','Freezing Dewgong','Furious Ampharos','Furious Mantine','Furious Sandslash','Furious Scyther','Hard Golem','Heavy Piloswine','Hungry Snorlax','Lava Magmar',
						'Magnet Electabuzz','Master Alakazam','Master Stantler','Metal Scizor','Metal Skarmory','Milch-Miltank','Milch-miltank','Moon Clefable','Octopus Octillery','Psy Jynx','Roll Donphan','Singer Wigglytuff',
						'Taekwondo Hitmonlee','Tribal Feraligatr','Tribal Scyther','Tribal Xatu','Trickmaster Gengar','Undefeated Machamp','War Granbull','War Gyarados','War Heracross','Wardog Arcanine',}, quantity = {100,300}},
	{lv = 250, rate = 1.5,  pokes = {'Elder Arcanine','Elder Blastoise','Elder Charizard','Elder Dragonite','Elder Electabuzz','Elder Gengar','Elder Jynx','Elder Marowak','Elder Muk','Elder Crobat','Elder Pidgeot','Elder Pinsir','Elder Raichu','Elder Tangela','Elder Tentacruel','Elder Tyranitar','Elder Venusaur','Iron Steelix'}, quantity = {100,200}},
	{lv = 300, rate = 1.6,  pokes = {'Swablu','Snorunt','Spheal','Riolu','Seedot','Treecko','Taillow','Torchic','Mudkip','Lotad','Ralts','Slakoth','Whismur','Makuhita','Aron','Meditite','Electrike','Numel','Spoink','Trapinch','Corphish','Feebas','Shuppet','Duskull','Bagon','Beldum'}, quantity = {100,200}},
	{lv = 350, rate = 1.7,  pokes = {'Sealeo','Nuzleaf','Grovyle','Combusken','Marshtomp','Lombre','Kirlia','Vigoroth','Loudred','Lairon','Vibrava'}, quantity = {200,350}},
	{lv = 400, rate = 1.8,  pokes = {'Altaria','Glalie','Walrein','Lucario','Shiftry','Sceptile','Swellow','Blaziken','Swampert','Ludicolo','Gardevoir','Exploud','Hariyama','Sableye','Mawile','Aggron','Medicham','Manectric','Camerupt','Grumpig','Flygon','Zangoose','Seviper','Crawdaunt','Claydol','Armaldo','Banette','Dusclops','Shelgon','Metang'}, quantity = {250,400}},
	{lv = 1000, rate = 2, pokes = {'Altaria','Glalie','Walrein','Lucario','Shiftry','Sceptile','Swellow','Blaziken','Swampert','Ludicolo','Gardevoir','Exploud','Hariyama','Sableye','Mawile','Aggron','Medicham','Manectric','Camerupt','Grumpig','Flygon','Zangoose','Seviper','Crawdaunt','Claydol','Armaldo','Banette','Dusclops','Shelgon','Metang'}, quantity = {500,1000}},
	-- outland++
	--{lv = 350, pokes = {"Bellsprout","Pidgey"}, quantity = {300,400}},
	--{lv = 400, pokes = {"Bellsprout","Pidgey"}, quantity = {400,500}},
	--{lv = 450, pokes = {"Bellsprout","Pidgey"}, quantity = {400,600}},
}

local ratexp = getConfigValue('rateExperience') -- rate do config
local bonusParty = 0.1 -- 10% por cada player na party
local stages = {--{maiorque, rate},
{1, 75},
{50, 50},
{100, 25},
{150, 12.5},
{200, 7.5},
{250, 5},
{300, 2.5},
{350, 1.25},
{400, 1},
{450, 0.5},
{500, 0.25},
}

local delay = 2 * 3600 -- 2 horas

local rxp = 1.5 -- rate exp da task 50% do total

local rwd = 15644 -- devoted token
local stoN = 30019
local stoQ = 30020
local stoT = 30021

local tmp = 30024
local stoTtmp = 30025

local c = math.floor(getPlayerLevel(cid)/20)
local rc = c > 4 and c or 5

function genTask(cid)
	for s=30019,30025 do
		setPlayerStorageValue(cid, s, -1)
	end
	local t, r = {}, {}
	for i,v in pairs(tasks) do
		if getPlayerLevel(cid) >= v.lv then
			t = v
		end
	end
	while #r < 9 do
		local rn = t.pokes[math.random(#t.pokes)]
		if not isInArray(r, rn) then
			table.insert(r, rn)
			table.insert(r, math.random(t.quantity[1], t.quantity[2]))
			table.insert(r, tostring(getPortraitClientID(rn)))
		end
	end
	local ret = ""
	for i,v in ipairs(r) do
		ret = ret .. v .. (i == #r and "" or "|")
	end
	setPlayerStorageValue(cid, tmp, ret)
	setPlayerStorageValue(cid, stoTtmp, os.time() + (delay/2))
	return ret
end


        if msgcontains(msg, 'task') or msgcontains(msg, 'Task') then
			local n = getPlayerStorageValue(cid, stoN)
			local q = getPlayerStorageValue(cid, tmp)
			local t = getPlayerStorageValue(cid, stoT)
			if t and t > os.time() then
				local secs = (t - os.time())
				selfSay("I don't have any tasks for you right now. Come back in ".. math.ceil(secs / 60) .. " minutes.", cid)
			elseif (n and n ~= -1) then
				doSendPlayerExtendedOpcode(cid, 182, "check|"..getPlayerStorageValue(cid, stoN).."|"..getPlayerStorageValue(cid, stoQ).."|"..getPortraitClientID(getPlayerStorageValue(cid, stoN)).."|")
				--selfSay('Check', cid)
			elseif q then
				if not getPlayerStorageValue(cid, stoTtmp) or tonumber(getPlayerStorageValue(cid, stoTtmp)) == nil then
					setPlayerStorageValue(cid, stoTtmp, 0)
				end
				if q == -1 or getPlayerStorageValue(cid, stoTtmp) < os.time() then
					selfSay('Your previous task has expired.', cid)
					genTask(cid)
				end
				doSendPlayerExtendedOpcode(cid, 182, getPlayerStorageValue(cid, tmp))
			else
				if not q then
					genTask(cid)
				end
				--selfSay('show', cid)
				doSendPlayerExtendedOpcode(cid, 182, getPlayerStorageValue(cid, tmp))
			end
		elseif msgcontains(msg, 'bye') then
			doSendPlayerExtendedOpcode(cid, 182, "close")
		elseif msgcontains(msg, 'reset') then
			if isGod(cid) then
				for s=30019,30025 do
					setPlayerStorageValue(cid, s, -1)
				end
				selfSay('Okay.', cid)
			else
				if tonumber(getPlayerStorageValue(cid, stoTtmp)) == nil then
					setPlayerStorageValue(cid, stoTtmp, 0)
				end
				if getPlayerStorageValue(cid, stoTtmp) < os.time() then
					if getPlayerStorageValue(cid, stoT) < os.time() then
					selfSay("Okay! These are your new tasks. Pick one to proceed.",cid)
					genTask(cid)
					doSendPlayerExtendedOpcode(cid, 182, getPlayerStorageValue(cid, tmp))
					else
					selfSay("You've just finished a task with me! Come back in ".. math.ceil((getPlayerStorageValue(cid, stoT) - os.time()) / 60) .. " minutes.", cid)
					end
				else
					selfSay("You can't reset your task just yet. Come back in ".. math.ceil((getPlayerStorageValue(cid, stoTtmp) - os.time()) / 60) .. " minutes.", cid)
				end
			end
        end

return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())             
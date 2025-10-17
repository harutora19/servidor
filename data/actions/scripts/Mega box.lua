local megas = {
	["Alakazite"] = {id = 15131, megaID = "", pokeName = "Alakazam"},
	["Charizardite Y"] = {id = 15135, megaID = "Y", pokeName = "Charizard"},
	["Blastoisinite"] = {id = 15133, megaID = "", pokeName = "Blastoise"},	
	["Gengarite"] = {id = 15136, megaID = "", pokeName = "Gengar"},	
	
	["Pidgeotile"] = {id = 15791, megaID = "", pokeName = "Pidgeot"},
	["Venusaurite"] = {id = 15793, megaID = "", pokeName = "Venusaur"},	

	["Blazikenite"] = {id = 15792, megaID = "", pokeName = "Blaziken"},	
	["Mawlite"] = {id = 15782, megaID = "", pokeName = "Mawile"},	
	["Lucarionite"] = {id = 15788, megaID = "", pokeName = "Lucario"},
	["Sceptilite"] = {id = 15789, megaID = "", pokeName = "Sceptile"},	
	["Swampertile"] = {id = 15790, megaID = "", pokeName = "Swampert"},	
	
	-- novos
	["Manectrite"] = {id = 15179, megaID = "", pokeName = "Manectric"},
	["Steelixite"] = {id = 15177, megaID = "", pokeName = "Steelix"},
	["Banettite"] = {id = 15140, megaID = "", pokeName = "Banette"},
	["Glalite"] = {id = 15174, megaID = "", pokeName = "Glalie"},			
}

local megasAS = {
	-- novos
	["Gyaradite"] = {id = 15137, megaID = "", pokeName = "Gyarados"},	
	["Sablenite"] = {id = 15139, megaID = "", pokeName = "Sableye"},	
	["Gengarite X"] = {id = 15141, megaID = "X", pokeName = "Gengar"},	
	["Slowbronite"] = {id = 15178, megaID = "", pokeName = "Slowbro"},	
	
	["Charizardite X"] = {id = 15134, megaID = "X", pokeName = "Charizard"},
	["Ampharosite"] = {id = 15794, megaID = "", pokeName = "Ampharos"},	
	["Aggronite"] = {id = 15780, megaID = "", pokeName = "Aggron"},	
	["Tyranitarite"] = {id = 15781, megaID = "", pokeName = "Tyranitar"},
	["Scizorite"] = {id = 15784, megaID = "", pokeName = "Scizor"},
	["Gardevoirite"] = {id = 15785, megaID = "", pokeName = "Gardevoir"},
	["Aerodactylite"] = {id = 15786, megaID = "", pokeName = "Aerodactyl"},
	["Absolite"] = {id = 15787, megaID = "", pokeName = "Absol"},
}

local card_id = {15131, 15133, 15135, 15136, 15782, 15783, 15788, 15789, 15790, 15791, 15792, 15793, 15179, 15177, 15140, 15174} -- joga os id dos card aqui
local card_idAS = {15134, 15780, 15781, 15784, 15785, 15786, 15787, 15794, 15137, 15139, 15141, 15178}

function onUse(cid, item, frompos, item2, topos)
	local level = 100 -- level
	-- if getPlayerFreeCap(cid) > 1 then -- precisa ter 1 espaço
		if getPlayerLevel(cid) >= level then
			local w = card_id[math.random (1,#card_id)]
			local t = megas[getItemNameById(w)]
			if item.actionid == 23723 then
				w = card_idAS[math.random(1,#card_idAS)]
				t = megasAS[getItemNameById(w)]
			end
			doPlayerAddItem(cid, w)
			doBroadcastMessage("#DAA520 | O jogador " .. getCreatureName(cid) .." abriu a mega box e tirou a mega stone : " ..getItemNameById(w)..".")
			
				local dir = "data/logs/rare drop.log"
				local arq = io.open(dir, "a+")
				local txt = arq:read("*all")
					  arq:close()
				local arq = io.open(dir, "w")
					  arq:write(""..txt.."\n[OPEN BOX ".. os.date("%x %X] ") .. getCreatureName(cid) .." -> ".. getItemNameById(w))
					  arq:close()
					  
			--if t then
			--	addPokeToPlayer(cid, t.pokeName, 0, nil, "poke")
			--end
			if not isGod(cid) then doRemoveItem(item.uid, 1) end
		else
			doPlayerSendCancel(cid,"You must be at least level "..level..".")
		end 
		return true
	-- else
		-- doPlayerSendCancel(cid,"You don't have enough weight.")
	-- end 
end
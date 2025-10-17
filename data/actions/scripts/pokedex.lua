local function checkDex(cid)
	local unlock = 0
	for i = 1, #oldpokedex do
		if getPlayerInfoAboutPokemon(cid, oldpokedex[i][1]).dex then
			unlock = unlock + 1
		end
	end
	return unlock
end

local rate = 200

local sto = 63999

function onUse(cid, item, fromPos, item2, toPos)
	
	if not isCreature(item2.uid) then
		return true
	end
	
	local poke = getCreatureName(item2.uid)
	
	if isMonster(item2.uid) then
	
		if isInArray({"Dummy"}, poke) then
			return true
		end
		
		local name = doCorrectString(getCreatureName(item2.uid))
		local this = newpokedex[name]
		local myball = 0
		if isSummon(item2.uid) then
			myball = getPlayerSlotItem(getCreatureMaster(item2.uid), 8)
		end
		if not getPlayerInfoAboutPokemon(cid, poke).dex then
			local exp = this.level * rate
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have unlocked ".. getCreatureName(item2.uid).." in your pokedex!")
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have gained "..exp.." experience points.")
			doSendMagicEffect(getThingPos(cid), 210)
			doPlayerAddExperience(cid, exp)
			doAddPokemonInDexList(cid, poke)
			local name = doCorrectString(getCreatureName(item2.uid))
			doShowPokedexRegistration(cid, name, myball, item2)		
		else
			local name = doCorrectString(getCreatureName(item2.uid))
			doShowPokedexRegistration(cid, name, myball, item2)			
		end
		return true
	end
	
	if not isPlayer(item2.uid) then return true end
	
	local kanto = 0
	local johto = 0
	
	for i = 1, #oldpokedex do
		if getPlayerInfoAboutPokemon(item2.uid, oldpokedex[i][1]).dex then
			if i <= 151 then
				kanto = kanto+1
			elseif i >= 209 then
				johto = johto+1
			end
		end
	end
	
	return true
end
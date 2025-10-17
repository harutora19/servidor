-- oak: 30 kanto, 65 kanto, 135 kanto, 30 johto, 60 johto, 90 johto
-- catcher: charizard, blastoise, venusaur, gengar, alakazam, dragonite, electabuzz, scyther, jynx, pidgeot, muk, marowak
-- 10 de cada:		fire		water		leaf	darkness	enigma	crystal		thunder		coccon	ice		heart	venom earth
-- pegou todos = 10 boost stones

-- 20 catch box 1 e xp, 50 catch box 2 e xp, 100 catch box 3 e xp, 135 kanto catch muita xp, outfit?, box shiny?
local pbag, gbag, sbag, ubag = 12683, 12682, 12684, 12685

dexQuest = {

}

caughtQuest = {
	
}

function getPlayerDexTables(cid)
	local ret = {
	kanto = {},
	johto = {},
	hoenn = {},
	unova = {},
	sinnoh = {},
	}
	
	for i = 1,649 do
		local d = getPlayerStorageValue(cid, 20000 + i)
		if d then
			if tostring(d):find("dex,") then
				if getPokemonNameByNumber(i) then
					if i <= 151 then
					  table.insert(ret.kanto, getPokemonNameByNumber(i))
					elseif i >= 152 and i <= 251 then
					  table.insert(ret.johto, getPokemonNameByNumber(i))
					elseif i >= 252 and i <= 386 then
					  table.insert(ret.hoenn, getPokemonNameByNumber(i))
					elseif i >= 387 and i <= 493 then
					  table.insert(ret.unova, getPokemonNameByNumber(i))
					elseif i >= 494 and i <= 649 then
					  table.insert(ret.sinnoh, getPokemonNameByNumber(i))
					end
				end
			end
		end
	end
	return ret
end

function getPlayerCaughtTables(cid)
	local ret = {
	kanto = {},
	johto = {},
	hoenn = {},
	unova = {},
	sinnoh = {},
	}
	for i = 1,649 do
		local d = getPlayerStorageValue(cid, 20000 + i)
		if d then
			if tostring(d):find("catch,") then
				if getPokemonNameByNumber(i) then
					if i <= 151 then
					  table.insert(ret.kanto, getPokemonNameByNumber(i))
					elseif i >= 152 and i <= 251 then
					  table.insert(ret.johto, getPokemonNameByNumber(i))
					elseif i >= 252 and i <= 386 then
					  table.insert(ret.hoenn, getPokemonNameByNumber(i))
					elseif i >= 387 and i <= 493 then
					  table.insert(ret.unova, getPokemonNameByNumber(i))
					elseif i >= 494 and i <= 649 then
					  table.insert(ret.sinnoh, getPokemonNameByNumber(i))
					end
				end
			end
		end
	end
	return ret
end

function hasPlayerCaught(cid, name)
	for i,v in pairs(getPlayerCaughtTables(cid)) do
		if isInArray(v, doCorrectString(name)) then
			return true
		end
	end
	return false
end
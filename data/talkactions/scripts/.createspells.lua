--<instant name="Quick Attack" words="spell000" lvl="1000" mana="0" event="script" value="ps/Quick Attack.lua"></instant>

function createSpell(name, spellnum)
	
	local fileret = {}
	
	local dir = "data/spells/scripts/ps/".. name ..".lua"
	local arq = io.open(dir, "w")
	arq:write('function onCastSpell(cid, var)\n	if isSummon(cid) then return true end\n\n	docastspell(cid, "'.. name ..'")\nreturn true\nend')
	arq:close()	
	
	
	local dir2 = "data/spells/spells.xml"
	local arq2 = io.open(dir2, "r")
	local startwriting = false
		for line in arq2:lines() do
			table.insert(fileret, line)
			if startwriting then
				table.insert(fileret, '<instant name="'.. name ..'" words="newspell'.. spellnum ..'" lvl="1000" mana="0" event="script" value="ps/'.. name ..'.lua"></instant>')
				startwriting = false
			end
			if line:find("<spells>") then
				startwriting = true
			end
		end
		arq2:close()
		
	local arq3 = io.open(dir2, "w") --Write the file.
	for i, linee in ipairs(fileret) do
		arq3:write(linee, "\n")
	end
	arq3:close()
		
	return true
end


function onSay(cid, words, param, channel)
 
	local spellstoadjust = {}
	local tmpspells = {"Hi Jump Kick", "Stampage", "Magnitude"}
	
	for i,name in pairs(tmpspells) do
		if not isInArray(spellstoadjust, name) then
			table.insert(spellstoadjust, name)
		end
	end
	
	for ii,namee in pairs(spellstoadjust) do
		createSpell(namee, 448+ii)
	end
	
    return true
end
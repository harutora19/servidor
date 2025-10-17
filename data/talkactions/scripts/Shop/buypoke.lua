local tab = {
["#buyursaring#"] = {price=25,pokemon="Shiny Ursaring",boost=0,gender=nil,ball="moon",unique=false,mega=false},
["#buydragonite#"] = {price=25,pokemon="Shiny Dragonite",boost=0,gender=nil,ball="tale",unique=false,mega=false},
["#buymagmortar#"] = {price=25,pokemon="Shiny Magmortar",boost=0,gender=nil,ball="magu",unique=false,mega=false},
["#buyelectivire#"] = {price=25,pokemon="Shiny Electivire",boost=0,gender=nil,ball="tinker",unique=false,mega=false},
["#buyflygon#"] = {price=25,pokemon="Shiny Flygon",boost=0,gender=nil,ball="magu",unique=false,mega=false},
["#buysceptile#"] = {price=25,pokemon="Shiny Sceptile",boost=0,gender=nil,ball="dusk",unique=false,mega=false},
["#buyswampert#"] = {price=25,pokemon="Shiny Swampert",boost=0,gender=nil,ball="net",unique=false,mega=false},
["#buyheracross#"] = {price=25,pokemon="Shiny Heracross",boost=0,gender=nil,ball="premier",unique=false,mega=false},
["#buyinfernape#"] = {price=25,pokemon="Shiny Infernape",boost=0,gender=nil,ball="yume",unique=false,mega=false},
["#buybrozong#"] = {price=25,pokemon="Shiny Bronzong",boost=0,gender=nil,ball="yume",unique=false,mega=false},
}

function onSay(cid, words, param, channel)
	
	local p = tab[words]
	if p then
		if doPlayerRemoveItem(cid, 2145, p.price) then
			doSendMsg(cid, "You've bought a ".. p.pokemon .." for ".. p.price .." diamonds.")
			addPokeToPlayer(cid, p.pokemon, p.boost, p.gender, p.ball, p.unique, p.mega)
			
			local dir = "data/logs/[diamonds] buypoke.log"
			local arq = io.open(dir, "a+")
			local txt = arq:read("*all")
			arq:close()
			local arq = io.open(dir, "w")
			arq:write(""..txt.."\n[".. os.date("%x %X] ") .. getCreatureName(cid) .." -> ".. p.pokemon)
			arq:close()	
			
		else
			doSendMsg(cid, "You don't have enough diamonds.")
		end	
	end
	return true
end

local chance = 10000 -- = 100% | 1 = 0,01%

baseMTable = {
{id = 14188, ch = 30, cmn = 1, cmx = 1}, -- mega box
{id = 17121, ch = 30, cmn = 1, cmx = 1}, -- device
-- {id = 18420, ch = 30, cmn = 1, cmx = 1}, -- device
{type = 'pkmn', id = "Zoroark", ch = 10},
{type = 'pkmn', id = "Shiny Rampardos", ch = 10},
{type = 'pkmn', id = "Shiny Honchkrow", ch = 10},
{type = 'pkmn', id = "Shiny Empoleon", ch = 10},
{type = 'pkmn', id = "Shiny Heatmor", ch = 10},
{type = 'pkmn', id = "Shiny Gardevoir", ch = 10},
{type = 'pkmn', id = "Shiny Torterra", ch = 10},
{id = 17202, ch = 59, cmn = 1, cmx = 1}, -- tm S
{id = 17203, ch = 159, cmn = 1, cmx = 1}, -- tm A
{id = 17204, ch = 250, cmn = 1, cmx = 1}, -- tm B
-- {id = 17205, ch = 500, cmn = 1, cmx = 1}, -- tm C
-- {id = 17206, ch = 1000, cmn = 1, cmx = 1}, -- tm D
{id = 18421, ch = 40, cmn = 1, cmx = 1}, -- mega boost stone
{id = 12339, ch = 40, cmn = 1, cmx = 1}, -- boosted box
{id = 12618, ch = 500, cmn = 1, cmx = 1}, -- stamina 3h
{id = 12618, ch = 1000, cmn = 1, cmx = 1}, -- stamina 3h
{id = 17225, ch = 1000, cmn = 1, cmx = 1}, -- exp charm
{id = 17227, ch = 1000, cmn = 1, cmx = 1}, -- luck charm
-- {id = 14185, ch = 500, cmn = 1, cmx = 1}, -- held Box
{id = 15646, ch = 500, cmn = 1, cmx= 25}, -- 20~40 honored token
{id = 15646, ch = 250, cmn = 25, cmx= 50}, -- 20~40 honored token
{id = 6569, ch = 500, cmn = 1, cmx= 10}, -- rare candy
{id = 6569, ch = 175, cmn = 10, cmx= 25}, -- rare candy
}

seasonMTable = {
}

function doPlayerRollMachine(cid)
	local prize = 'none'
	local rett = {}
	
	for ind = 1, 10000 do
		rett[ind] = {}
	end
	for i,v in pairs(baseMTable) do
		table.insert(rett[v.ch], v)
	end
	for i,v in pairs(seasonMTable) do
		table.insert(rett[v.ch], v)
	end
	
	while prize == 'none' do
		for i,v in ipairs(rett) do
			if #v > 0 then
				if math.random(chance) <= i then
					prize = v[math.random(#v)]
					break
				end
			end
		end
		if prize ~= 'none' then
			if prize.ch <= 100 then
				doBroadcastMessage("#00FA9A | O jogador ".. getCreatureName(cid) .." rodou uma mystery key e pegou o item: ".. (prize.type == 'pkmn' and prize.id or getItemNameById(prize.id)) ..".")
			end
			if prize.type == 'pkmn' then
				doSendMsg(cid, "You've rolled a mystery ticket and received: a ".. prize.id .." (".. (prize.ch / 100) .."%).")
				addPokeToPlayer(cid, prize.id, 0, "poke")
			elseif prize.type == 'box' then
			else
				local c = math.random(prize.cmn, prize.cmx)
				if doPlayerAddItem(cid, prize.id, c) then
					doSendMsg(cid, "You've rolled a mystery ticket and received: ".. (c > 1 and c or "a") .." ".. getItemNameById(prize.id) .." (".. (prize.ch / 100) .."%).")
				else
					local m = doCreateItemEx(1993)
					addItemInFreeBag(m, prize.id, c)   
					doPlayerSendMailByName(getCreatureName(cid), m, 1)
					doSendMsg(cid, "You've rolled a mystery ticket and received: ".. (c > 1 and c or "a") .." ".. getItemNameById(prize.id) .." (".. (prize.ch / 100) .."%). Since your bag is full, your prize has been sent to your depot.")
				end
			end
			doSendMagicEffect(getThingPos(cid), 27)
		end
	end
	
	local dir = "data/logs/[diamonds] machine.log"
	local arq = io.open(dir, "a+")
	local txt = arq:read("*all")
	arq:close()
	local arq = io.open(dir, "w")
	arq:write(""..txt.."\n[".. os.date("%x %X] ") .. getCreatureName(cid))
	arq:close()	
	
	return true
end

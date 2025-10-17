local helds = {
	["X-Attack"] = {15559, 15560, 15561, 15562, 15563, 15564, 15565},	
	["X-Block"] = {15566, 15567, 15568, 15569, 15570, 15571, 15572},
	["X-Boost"] = {15573, 15574, 15575, 15576, 15577, 15578, 15579}, 
	["X-Critical"] = {15580, 15581, 15582, 15583, 15584, 15585, 15586}, 
	["X-Defense"] = {15587, 15588, 15589, 15590, 15591, 15592, 15593}, 
	["X-Experience"] = {15594, 15595, 15596, 15597, 15598, 15599, 15600}, 
	["X-Hellfire"] = {15601, 15602, 15603, 15604, 15605, 15606, 15607}, 
	["X-Elemental"] = {15608, 15609, 15610, 15611, 15612, 15613, 15614}, 
	["X-Lucky"] = {15615, 15616, 15617, 15618, 15619, 15620, 15621},
	["X-Poison"] = {15622, 15623, 15624, 15625, 15626, 15627, 15628}, 
	["X-Return"] = {15629, 15630, 15631, 15632, 15633, 15634, 15635}, 
	["X-Vitality"] = {15636, 15637, 15638, 15639, 15640, 15641, 15642},
	["Y-Cure"] = {13941, 13942, 13943, 13944, 13945, 13946, 13947}, -- uissu
	["Y-Wing"] = {13948, 13949, 13950, 13951, 13952, 13953, 13954}, -- uissu
	["X-Vampiric"] = {13962, 13963, 13964, 13965, 13966, 13967, 13968}, -- uissu
	["X-Accuracy"] = {13969, 13970, 13971, 13972, 13973, 13974, 13975}, -- uissu
	["Y-Ghost"] = {id = 15643, megaID = "", pokeName = "none"},
}
local heldsName = {"X-Vitality", "X-Return", "X-Attack", "X-Block", "X-Boost", "X-Critical", "X-Defense", "X-Experience", "X-Hellfire", "X-Elemental", "X-Lucky", "X-Poison", "Y-Cure", "Y-Wing", "X-Vampiric", "X-Accuracy", "Y-Ghost"} -- deixe sempre o y-ghost por ultimo!

function doPlayerAddRandomHeld2(cid, tier)
   local heldT = helds[heldsName[math.random(1, (#heldsName - 1))]]
	if tier == 7 then
		heldT = helds[heldsName[math.random(1, #heldsName)]]
	end
   local held = heldT[1]
	if held then
		if tier == 2 then
		   held = heldT[2]
		elseif tier == 3 then
		   held = heldT[3] 
		elseif tier == 4 then
		   held = heldT[4] 
		elseif tier == 5 then
		   held = heldT[5] 
		elseif tier == 6 then
		   held = heldT[6] 
		elseif tier == 7 then
		   held = heldT[7] 
		end
	else
	    held = heldT.id
	end
	doSendMsg(cid, "You've got a ".. getItemNameById(held) ..".")
	doPlayerAddItem(cid, held, 1)
end

function getHeldTierById(id)
	if id == 15643 then return 7 end
	for i,v in pairs(helds) do
		for h=1,7 do
			if v[h] == id then
				return h
			end
		end
	end
	return false
end

local cost = {
50000,
100000,
250000,
500000,
750000,
1500000,
3000000,
}

function onUse(cid, item, topos, item2, frompos)

	local heldsInMachine = {
	[1] = {},
	[2] = {},
	[3] = {},
	[4] = {},
	[5] = {},
	[6] = {},
	[7] = {},
	}

	if item.itemid == 16179 then
		
		local hpos = topos
		hpos.x = hpos.x - 1
		local hmc = getTileItemById(hpos, 16178)
		for i=0,7 do
			local tmph = getContainerItem(hmc.uid, i)
			if tmph.itemid then
				if getHeldTierById(tmph.itemid) then
					table.insert(heldsInMachine[getHeldTierById(tmph.itemid)], tmph)
					--doSendMsg(cid, "Tier: "..getHeldTierById(tmph.itemid))
				end
			end
		end
		-- check count tiers
		local count = 0
		for t=1,7 do
			local nn = #heldsInMachine[t]
			if nn > 1 then
				count = count + nn
			end
		end
		if getPlayerStorageValue(cid, 271313) < os.time() then
			if count > 3 then
				doSendMagicEffect(topos, 34)
				doSendMsg(cid, "Please, fuse 23helds at a time only. (".. count ..")")
			elseif count < 3 then
				doSendMagicEffect(topos, 34)
				doSendMsg(cid, "You need 3 helds of same tier to fuse. (".. count ..")")
			else
				doSendMagicEffect(topos,3)
				doSendMsg(cid, "Are you sure you want to fuse these helds?")
				setPlayerStorageValue(cid, 271313, os.time() + 10)
			end
		else
			-- fuse helds
			setPlayerStorageValue(cid, 271313, 0)
			for i,v in pairs(heldsInMachine) do
				if #v == 3 then
					if doPlayerRemoveMoney(cid, cost[i]) then
						doSendMagicEffect(topos, 28)
						doPlayerAddRandomHeld2(cid, math.min(7, i+1))
						doRemoveItem(v[1].uid)
						doRemoveItem(v[2].uid)
						doRemoveItem(v[3].uid)
					else
						doSendMagicEffect(topos, 34)
						doSendMsg(cid, "You don't have ".. cost[i] .." dollars.")
					end
					return true
				end
			end
			--
		end
	end

return true
end
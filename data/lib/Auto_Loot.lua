--[[
	Auto Loot System by Danyel Varejão
]]

AutoLoot = {
	Min_Level = 1, -- Level minimo pra utilizar o auto loot.
	Max_Slots = 50, -- Máximo de slots permitidos.
	Boost_Actived = true,
	
	-- Nao mexa daqui pra baixo caso nao entenda --
	Storage_Boost = 45000,
	Storage_On_Items = 45001,
	Storages = {
		Count_Gold = 45003,
		Count_Items = 45004,
		Count_Table = 45005,
		Slots = {45006, 45007, 45008, 45009, 45010, 45011, 45012, 45013, 45014, 45015, 45016, 45017, 45018, 45019, 45020, 45021, 45022, 45023, 45024, 45025, 45026, 45027, 45028, 45029, 45030, 45031, 45032, 45033, 45034, 45035, 45036, 45037, 45038, 45039, 45040, 45041, 45042, 45043, 45044, 45045, 45046, 45047, 45048, 45049, 45050} -- Storage pra cada slot.
	}
}

AutoLoot_Boost = {
	-- [ID do item] = Valor,
	[2406] = 36, 
	[2537] = 4800, 
	[2377] = 480, 
	[2663] = 600, 
	[2472] = 240000, 
	[2398] = 36, 
	[2475] = 7200, 
	[2519] = 6000, 
	[2497] = 10800, 
	[2523] = 180000, 
	[2494] = 108000, 
	[2400] = 144000, 
	[2491] = 6000, 
	[2421] = 108000, 
	[2646] = 240000, 
	[2477] = 7200, 
	[2413] = 84, 
	[2656] = 18000, 
	[2498] = 48000, 
	[2647] = 600, 
	[2534] = 30000, 
	[7402] = 24000, 
	[2466] = 36000, 
	[2465] = 240, 
	[2408] = 120000, 
	[2518] = 1800, 
	[2500] = 3000, 
	[2376] = 30, 
	[2470] = 96000, 
	[2388] = 24, 
	[2645] = 48000, 
	[2434] = 2400, 
	[2463] = 480, 
	[2536] = 9600, 
	[2387] = 240, 
	[2396] = 4800, 
	[2381] = 240, 
	[2528] = 4800, 
	[2409] = 1800, 
	[2414] = 12000, 
	[2427] = 9000, 
	[2407] = 7200, 
	[2458] = 42, 
	[2383] = 960, 
	[2392] = 3600, 
	[2488] = 18000, 
	[2525] = 120, 
	[2423] = 240, 
	[2462] = 4800, 
	[2520] = 48000, 
	[2390] = 180000, 
	[2417] = 72, 
	[2436] = 1200, 
	[5741] = 42000, 
	[2378] = 120, 
	[2487] = 24000, 
	[2476] = 6000,
	[8891] = 36000, 
	[2459] = 36, 
	[2195] = 48000, 
	[2391] = 7200, 
	[2464] = 120, 
	[8889] = 72000, 
	[2432] = 12000, 
	[2431] = 108000, 
	[2492] = 72000, 
	[2515] = 240, 
	[2430] = 2400, 
	[2393] = 12000, 
	[7419] = 36000, 
	[2522] = 120000, 
	[2514] = 180000
}

function AutoLoot.CountTable(table)
    local Count = 0
    if type(table) == "table" then
        for index in pairs(table) do
            Count = Count + 1
        end
        return Count
    end
    return false
end

function AutoLoot.getContainerItemsInfo(ContainerUID)
    local Table = {}
    if ContainerUID and ContainerUID > 0 then
        local Index = 0   
        for i = 0, getContainerSize(ContainerUID) - 1 do
            local item = getContainerItem(ContainerUID, i)
            Index = Index + 1
            Table[Index] = {UID = item.uid, ItemID = item.itemid, Count = item.type}
        end
        return Table
    end
    return false
end

function AutoLoot.String(String)
	local Table = {}
	local x, old, last = 0, 0, 0
	local first, second, final = 0, 0, 0
	if type(String) ~= "string" then
		return Table
	end
	for i = 2, #String - 1 do
		if string.byte(String:sub(i,i)) == string.byte(':') then
			x, second, last = x + 1, i - 1, i + 2
			for t = last, #String - 1 do
				if string.byte(String:sub(t,t)) == string.byte(',') then
					first = x == 1 and 2 or old
					old, final = t + 2, t - 1
					local Index = String:sub(first, second)
					local Var = String:sub(last, final)
					Table[tonumber(Index) or tostring(Index)] = tonumber(Var) or tostring(Var)
					break
				end
			end
		end
	end
	return Table
end

function AutoLoot.TranslateString(Table)
	local String = ""
	if type(Table) ~= "table" then
		return String
	end
	for i, last in pairs(Table) do
		String = String..i..": ".. last ..", "
	end
	String = "a"..String.."a"
	return tostring(String)
end

function AutoLoot.getPlayerStorageZero(cid, key)
    return getPlayerStorageValue(cid, key) > 0 and getPlayerStorageValue(cid, key) or 0
end

function AutoLoot.getStorageZero(key)
    return getGlobalStorageValue(key) > 0 and getGlobalStorageValue(key) or 0
end

function AutoLoot.setPlayerTableStorage(cid, key, value)
	return doPlayerSetStorageValue(cid, key, AutoLoot.TranslateString(value))
end

function AutoLoot.setGlobalTableStorage(key, value)
	return setGlobalStorageValue(key, AutoLoot.TranslateString(value))
end

function AutoLoot.getPlayerTableStorage(cid, key)
	return AutoLoot.String(getPlayerStorageValue(cid, key))
end

function AutoLoot.getGlobalTableStorage(key)
	return AutoLoot.String(getGlobalStorageValue(key))
end

function AutoLoot.getPlayerList(cid)
	local Table = {}
	for i = 1, #AutoLoot.Storages.Slots do
		if getPlayerStorageValue(cid, AutoLoot.Storages.Slots[i]) ~= -1 then
			table.insert(Table, getPlayerStorageValue(cid, AutoLoot.Storages.Slots[i]))
		end
	end
	return Table
end

function AutoLoot.ExistItemByName(name)
	local Items = io.open("data/items/items.xml", "r"):read("*all")
	local GetITEM = Items:match('name="' .. name ..'"')
	if GetITEM == nil or GetITEM == "" then
		return false
	end
	return true
end

function AutoLoot.addToList(cid, name)
	local ItemID = getItemIdByName(name)
	if AutoLoot.getPlayerList(cid) and isInArray(AutoLoot.getPlayerList(cid), ItemID) then
		return false
	end
	for i = 1, #AutoLoot.Storages.Slots do
		if getPlayerStorageValue(cid, AutoLoot.Storages.Slots[i]) == -1 then
			doPlayerSetStorageValue(cid, AutoLoot.Storages.Slots[i], ItemID)
			return true
		end
	end
end

function AutoLoot.removeFromList(cid, name)
	local ItemID = getItemIdByName(name)
	for i = 1, #AutoLoot.Storages.Slots do
		if getPlayerStorageValue(cid, AutoLoot.Storages.Slots[i]) == ItemID then
			doPlayerSetStorageValue(cid, AutoLoot.Storages.Slots[i], -1)
			return true
		end
	end
	return false
end

function AutoLoot.Boost(cid)
	return tonumber(getPlayerStorageValue(cid, AutoLoot.Storage_Boost)) >= os.time()
end

function AutoLoot.Items(cid, position)
	if not isPlayer(cid) then 
		return true
	end
	local Check, String, Position = false, "", {}
	for i = 1, 255 do
		position.stackpos = i
		if getThingFromPos(position).uid and getThingFromPos(position).uid > 0 and isContainer(getThingFromPos(position).uid) then
			Position = position
			Check = true
			break
		end
	end
	if Check then
		local CorpseUID = AutoLoot.getContainerItemsInfo(getThingFromPos(Position).uid)		
		if CorpseUID then
			for Index, Item in pairs(CorpseUID) do
				if Index < AutoLoot.CountTable(CorpseUID) then
					if Item.UID and Item.ItemID then
						if isContainer(Item.UID) then
							local Bag = AutoLoot.getContainerItemsInfo(Item.UID)
							for i = 1, AutoLoot.CountTable(Bag) do
								if isInArray(AutoLoot.getPlayerList(cid), Bag[i].ItemID) then
									if Bag[i].Count > 1 then
										doRemoveItem(Bag[i].uid, Bag[i].Count)
										doPlayerAddItem(cid, Bag[i].ItemID, Bag[i].Count)
										String = String.." ".. Bag[i].Count .." ".. getItemNameById(Bag[i].ItemID) .." +"
									else
										doRemoveItem(Bag[i].uid)
										if AutoLoot.Boost_Actived and AutoLoot.Boost(cid) then
												doPlayerAddItem(cid, Bag[i].ItemID, 1)
												String = String.." 1 ".. getItemNameById(Bag[i].ItemID) .." +"
										else
											doPlayerAddItem(cid, Bag[i].ItemID, 1)
											String = String.." 1 ".. getItemNameById(Bag[i].ItemID) .." +"
										end
									end
								end
							end
						end
					end
				end
				if isInArray(AutoLoot.getPlayerList(cid), Item.ItemID) then
					if Item.Count > 1 then
						doRemoveItem(Item.UID, Item.Count)
						doPlayerAddItem(cid, Item.ItemID, Item.Count)
						String = String.." ".. Item.Count .." ".. getItemNameById(Item.ItemID) .." +"
					else
						doRemoveItem(Item.UID)
						if AutoLoot.Boost_Actived and AutoLoot.Boost(cid) then
								doPlayerAddItem(cid, Item.ItemID, 1)
								String = String.." 1 "..getItemNameById(Item.ItemID).." +"
						else
							doPlayerAddItem(cid, Item.ItemID, 1)
							String = String.." 1 "..getItemNameById(Item.ItemID).." +"
						end
					end
				end
			end
		end
	end
	AutoLoot.setPlayerTableStorage(cid, AutoLoot.Storages.Count_Table, {[1] = String, [2] = 0})
end

function AutoLoot.Message(cid)
	if not isPlayer(cid) then 
		return true
	end
	local Table = AutoLoot.getPlayerTableStorage(cid, AutoLoot.Storages.Count_Table)
	if AutoLoot.CountTable(Table) >= 1 then
		if Table[1] then
			if Table[2] and Table[2] > 0 then
				doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "[Auto Loot System] Coletados: ".. Table[1] .." ".. Table[2] .." gold coins.")
			else
				if type(Table[1]) == "string" and string.len(Table[1]) > 1 then
					doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "[Auto Loot System] Coletados: "..Table[1])
				end
			end
		elseif not Table[1] then
			if Table[2] then
				doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "[Auto Loot System] Coletados: "..Table[2].." gold coins.")
			end
		end
	end
	doPlayerSetStorageValue(cid, AutoLoot.Storages.Count_Table, -1)
end
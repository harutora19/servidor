json = require('data/lib/json')

local market_items = {}

local pokeballs = {}
local stones_items = {}
local pokebolas_items = {}
local diamond_items = {2145}
local addon_items = {}
local outfit_items = {}
local held_items = {}
local furniture_items = {}
local berry_items = {}
local plate_items = {}
local doll_items = {}
local food_items = {}
local utilities_items = {}
local suplies_items = {}

local block_items = {}

function isBlockItem(itemId) return isInArray(block_items, itemId) end
function isPokeball(itemId) return isItemPokeball(itemId) end
function isStones(itemId) return isStone(itemId) end
function isPokebolas(itemId) return isInArray(pokebolas_items, itemId) end
function isDiamonds(itemId) return isInArray(diamond_items, itemId) end
function isAddons(itemId) return isInArray(addon_items, itemId) end
function isOutfits(itemId) return isInArray(outfit_items, itemId) end
function isHelds(itemId) return isInArray(held_items, itemId) end
function isFurnitures(itemId) return isInArray(furniture_items, itemId) end
function isBerrys(itemId) return isInArray(berry_items, itemId) end
function isPlates(itemId) return isInArray(plate_items, itemId) end
function isDolls(itemId) return isInArray(doll_items, itemId) end
function isFoods(itemId) return isInArray(food_items, itemId) end
function isUtilities(itemId) return isInArray(utilities_items, itemId) end
function isSuplies(itemId) return isInArray(suplies_items, itemId) end

function getMarketItemName(itemId, uid)
  if isPokeball(itemId) and getItemAttribute(uid, "poke") then
    return getItemAttribute(uid, "poke")
  end
  return getItemInfo(itemId).name
end

function getMarketPokeInfo(itemId, uid)
  local info = {name = getItemInfo(itemId).name}
  if isPokeball(itemId) and getItemAttribute(uid, "poke") then
    info.name = getItemAttribute(uid, "poke")
  end
  return info
end

function getPokeMarketDescription(itemId, uid, pokemonFRIENDSHIP, pokemonFRIENDSHIPLUCK, pokemonSex, pokemonName, pokemonNickname, pokemonLevel)
  local description = ""
  if isPokeball(itemId) and getItemAttribute(uid, "poke") then
	local heldx = getItemAttribute(uid, "xHeldItem")
	local heldy = getItemAttribute(uid, "yHeldItem")
	local heldz = getItemAttribute(uid, "zHeldItem")
    description = description..getItemAttribute(uid, "poke")
	if getItemAttribute(uid, "boost") then
		description = description.. "\nBoost: " ..getItemAttribute(uid, "boost")
	end
            local heldName, heldTier = "", ""
            local heldYName, heldYTier = "", ""

            if heldx or heldy  then
                if heldx then heldName, heldTier = string.explode(heldx, "|")[1], string.explode(heldx, "|")[2] end
                if heldy then heldYName, heldYTier = string.explode(heldy, "|")[1], string.explode(heldy, "|")[2] end
                local heldString = heldName ..  " (tier: " .. heldTier .. ")"
                local heldYString = heldYName ..  (" (tier: " .. heldYTier .. ")" or "")
                if heldx and heldy then
                    -- table.insert(str, "\nHolding: " .. heldString .. " and " .. heldYString .. ".")
					description = description.. "\nHeld: " ..heldString .. " and " .. heldYString .. "."
                elseif heldx then
                    description = description.. "\nHeld: " ..heldString
                elseif heldy then
                   description = description.. " Held: " .. heldYString
                end
            end

	-- if getItemAttribute(uid, "xHeldItem") then
		-- description = description.. "\nHeld X: " ..getItemAttribute(uid, "xHeldItem")
	-- end
	-- if getItemAttribute(uid, "yHeldItem") then
		-- description = description.. " Held Y: " ..getItemAttribute(uid, "yHeldItem")
	-- end

  else
    description = getItemInfo(itemId).description
  end
    return description
  end

function nearOnMarket(cid)
  local lastMarketPosition = getPlayerStorageValue(cid, playersStorages.marketPos)
  local pos = {x = 0,y = 0,z = 0,stackpos = 0}
  local explode = string.explode(lastMarketPosition, ',')
  for s=1, #explode do
    if string.find(explode[s], 'X:') then
	  pos.x = tonumber(string.explode(explode[s], 'X:')[1])
	end
    if string.find(explode[s], 'Y:') then
	  pos.y = tonumber(string.explode(explode[s], 'Y:')[1])
	end
    if string.find(explode[s], 'Z:') then
	  pos.z = tonumber(string.explode(explode[s], 'Z:')[1])
	end
    if string.find(explode[s], 'S:') then
	  pos.stackpos = tonumber(string.explode(explode[s], 'S:')[1])
	end
  end
  if getDistanceBetween(getCreaturePosition(cid), pos) > 5 then return false end
  return true
end

function sendMarketClose(cid)
  doSendPlayerExtendedOpcode(cid, GameServerOpcodes.Market, table.tostring(Protocol_create('close')))
end

function refreshMarketOnClient(cid)
  doRefreshMarketItems()
  sendMarketBuyItems(cid, "Todos", 1, 0)
  sendMarketSellItems(cid)
  sendMarketHistoric(cid)
end

function doRefreshMarketItems()
  local refresh = false
  if refresh then getMarketItems() end
end

function setMarketHistoric(guid, negotiation, cid)
  negotiation = os.date('*t').day.."/"..os.date('*t').month.."/"..os.date('*t').year.." - "..negotiation
  local historic = getMarketHistoric(guid)
  historic[#historic+1] = {time = os.time(), negotiation = negotiation}
  if #historic >= 2 then table.sort(historic, function(a,b) return a.time > b.time end) end
  if historic[31] then historic[31] = nil end
  db.executeQuery("UPDATE `market_historic` set `historic` = '"..json.encode(historic).."' WHERE `player_id` = "..guid)
  if cid then sendMarketHistoric(cid) end
end

function getMarketHistoric(guid)
  local historic = {}
  local query = ("SELECT `historic` FROM `market_historic` WHERE `player_id` = "..guid)
  local mysql = db.getResult(query)
  if mysql:getID() ~= -1 then
    historic = json.decode(mysql:getDataString('historic'))
  else
    db.executeQuery("INSERT INTO `market_historic` (`player_id`, `historic`) VALUES ("..guid..", '"..json.encode(historic).."')")
  end
  if #historic >= 2 then table.sort(historic, function(a,b) return a.time < b.time end) end
  return historic
end

function sendMarketHistoric(cid)
  local protocol = Protocol_create('market_historic')
  Protocol_add(protocol, getMarketHistoric(getPlayerGUID(cid)))
  doSendPlayerExtendedOpcode(cid, GameServerOpcodes.Market, table.tostring(protocol))
end

function sendMarketSellItems(cid)
  local send_market_items = {}
  for item_code, market_item in pairs(market_items) do
    if getPlayerGUID(cid) == market_item.playerseller_id then
	  send_market_items[#send_market_items+1] = market_item
	end
  end
  if #send_market_items == 0 then
	local protocol = Protocol_create("marketsellitems")
	Protocol_add(protocol, true)
	Protocol_add(protocol, {})
	doSendPlayerExtendedOpcode(cid, GameServerOpcodes.Market, table.tostring(protocol))
	return true
  end 
  local count = 1
  local first = true
  local new_send_market_items = {}
  for i=1, #send_market_items, 1 do
    new_send_market_items[i] = send_market_items[i]
    if count == 5 or i == #send_market_items then
      local protocol = Protocol_create("marketsellitems")
      Protocol_add(protocol, first)
      Protocol_add(protocol, new_send_market_items)
      doSendPlayerExtendedOpcode(cid, GameServerOpcodes.Market, table.tostring(protocol))
	  first = false
	  count = 1
	  new_send_market_items = {}
	end
	count = count+1
  end
end


function sendMarketBuyItems(cid, category, page, focus, order, searchstring)
  -- if not nearOnMarket(cid) then return sendMarketClose(cid) end
  if not order then order = "timeasc" end
  local send_market_items = {}
  local qnt_per_page = 15
  for item_code, itemInfo in pairs(market_items) do
    if itemInfo.time - os.time() > 0 then
      if (category == "Todos" or getItemCategory(itemInfo.itemid) == category) then
        if not searchstring or (string.find(string.lower(itemInfo.item_name), string.lower(searchstring)) or string.find(string.lower(itemInfo.playerseller_name), string.lower(searchstring))) then
          local market_item = {
            item_code         = itemInfo.item_code,
            playerseller_name = itemInfo.playerseller_name,
            itemid            = itemInfo.itemid,
            spriteId          = itemInfo.spriteId,
            count             = itemInfo.count,
            price             = itemInfo.price,
            time              = itemInfo.time,
      	    item_name         = itemInfo.item_name,
      	    poke_info         = itemInfo.poke_info,
			description       = itemInfo.description,
          }
      	  send_market_items[#send_market_items+1] = market_item
        end
      end
	end
  end
  local maxPage = math.ceil(#send_market_items / qnt_per_page)
  if string.find(order, 'itemdesc') then 
    table.sort(send_market_items, function(a,b) return a.item_name < b.item_name end)
  elseif string.find(order, 'itemasc') then
    table.sort(send_market_items, function(a,b) return a.item_name > b.item_name end)
  elseif string.find(order, 'sellerdesc') then
    table.sort(send_market_items, function(a,b) return a.playerseller_name < b.playerseller_name end)
  elseif string.find(order, 'sellerasc') then
    table.sort(send_market_items, function(a,b) return a.playerseller_name > b.playerseller_name end)
  elseif string.find(order, 'amountdesc') then
    table.sort(send_market_items, function(a,b) return a.count < b.count end)
  elseif string.find(order, 'amountasc') then
    table.sort(send_market_items, function(a,b) return a.count > b.count end)
  elseif string.find(order, 'pricedesc') then
    table.sort(send_market_items, function(a,b) return a.price < b.price end)
  elseif string.find(order, 'priceasc') then
    table.sort(send_market_items, function(a,b) return a.price > b.price end)
  end
  local max_send = 0
  local resend_page = page
  if page > 1 then
    if #send_market_items < page*qnt_per_page then
	  max_send = page*qnt_per_page - (page*qnt_per_page - #send_market_items)
	else
	  max_send = page*qnt_per_page
	end
	page = (page-1)*qnt_per_page+1
  else
    if #send_market_items < qnt_per_page then
      max_send = #send_market_items
    else
	  max_send = qnt_per_page
    end	
  end
  local new_send_market_items = {}
  for _=page, max_send, 1 do
    new_send_market_items[#new_send_market_items+1] = send_market_items[_]
  end
  local protocol = Protocol_create("marketbuyitems")
  Protocol_add(protocol, category)
  Protocol_add(protocol, resend_page)
  Protocol_add(protocol, maxPage)
  Protocol_add(protocol, focus)
  Protocol_add(protocol, searchstring or '')
  Protocol_add(protocol, new_send_market_items)
  doSendPlayerExtendedOpcode(cid, GameServerOpcodes.Market, table.tostring(protocol))
end

function checkMarketCanSellItem(cid, container_index, slot_index)
  -- if not nearOnMarket(cid) then return sendMarketClose(cid) end
  local item = {itemid = 0}
  if container_index >= CONST_SLOT_FIRST and container_index <= CONST_SLOT_LAST then
    item = getPlayerSlotItem(cid, container_index) or item
  elseif container_index >= 64 and container_index <= 80 then
    item = getContainerItemByIndex(cid, container_index - 64, slot_index) or item
  end
  if item.itemid == 0 then
    return doPlayerPopupFYI(cid, "Item não encontrado")
  elseif isBlockItem(item.itemid) then -- block item
    return doPlayerPopupFYI(cid, "Você não pode vender este item")
  elseif isContainer(item.uid) and getContainerSize(item.uid) > 0 then
    return doPlayerPopupFYI(cid, "Você não pode vender este item")
  elseif getItemInfo(item.itemid).worth > 0 then
    return doPlayerPopupFYI(cid, "Você não pode vender este item.")
  elseif not getItemInfo(item.itemid).movable then
    return doPlayerPopupFYI(cid, "Você não pode vender este item.")
  end
  local itemInfo = {item_code = "", itemid = item.itemid, count = item.type, spriteId = getItemInfo(item.itemid).clientId}
  if not isItemStackable(item.itemid) then
    itemInfo.item_code = generateCode()
    doItemSetAttribute(item.uid, playersStorages.marketBase, itemInfo.item_code)
  end
  itemInfo.description = getPokeMarketDescription(item.itemid, item.uid)
  itemInfo.poke_info = getMarketPokeInfo(item.itemid, item.uid)
  local protocol = Protocol_create("marketsellitemschecked")
  Protocol_add(protocol, itemInfo)
  doSendPlayerExtendedOpcode(cid, GameServerOpcodes.Market, table.tostring(protocol))
end

function getMarketItems()
  market_items = {}
  local query = "SELECT `market_items`.*, `players`.`name` FROM `market_items` INNER JOIN `players` ON `market_items`.`playerseller_id` = `players`.`id`"
  local mysql = db.getResult(query)
  if mysql:getID() ~= -1 then
    while(true) do
	  local market_item = {
        item_code         = mysql:getDataString('item_code'),
        playerseller_id   = mysql:getDataInt('playerseller_id'),
        playerseller_name = mysql:getDataString('name'),
        itemid            = mysql:getDataInt('itemid'),
        count             = mysql:getDataInt('count'),
        price             = mysql:getDataInt('price'),
        time              = mysql:getDataInt('time'),
      }
      local item = doCreateItemEx(market_item.itemid, market_item.count)
      doItemLoadAttributes(item, 'attributes', mysql:getID())
      doItemSetCount(item, market_item.count)
	  market_item.item_name = getMarketItemName(market_item.itemid, item)
	  market_item.poke_info = getMarketPokeInfo(market_item.itemid, item)
	  market_item.spriteId = getItemInfo(market_item.itemid).clientId
	  market_item.description = getPokeMarketDescription(market_item.itemid, item)
	  market_items[market_item.item_code] = market_item
      if not(mysql:next())then
        break
      end
    end
    mysql:free()
  end
end

function getMarketFee(price)
  return math.max(1, price / 1000)
end

function doMarketSellItem(cid, code, itemId, count, price)
  -- if not nearOnMarket(cid) then return sendMarketClose(cid) end
  if not code or code == "" or code == 'nil' or code == nil then code = generateCode() end
  if itemId == 0 then return doPlayerPopupFYI(cid, "Item não encontrado") end
  if price < 0 or price > 99999999 then return doPlayerPopupFYI(cid, "Preço inválido") end
  local item = isItemStackable(itemId) and getPlayerItemByIdInMarket(cid, itemId) or getPlayerItemByCode(cid, code)
  if not item then return doPlayerPopupFYI(cid, "Item não encontrado") end
  if isItemUnique(item.uid) then return doPlayerPopupFYI(cid, "Você não pode vender este item unico") end
  if isContainer(item.uid) and getContainerSize(item.uid) > 0 then
    return doPlayerPopupFYI(cid, "Você não pode vender este item")
  elseif getItemInfo(item.itemid).worth > 0 then
    return doPlayerPopupFYI(cid, "Você não pode vender este item")
  elseif not getItemInfo(item.itemid).movable then
    return doPlayerPopupFYI(cid, "Você não pode vender este item")
  end
  -- price = price
  if getPlayerItemCount(cid, item.itemid) < count then
    return doPlayerPopupFYI(cid, "Você não tem tantos itens")
  end
  if getPlayerMoney(cid) < getMarketFee(price * count) then
    return doPlayerPopupFYI(cid, "Você não possui o dinheiro da taxa")
  end
  doPlayerRemoveMoney(cid, getMarketFee(price * count))
  local market_item = {
    item_code = code, playerseller_id = getPlayerGUID(cid), playerseller_name = getCreatureName(cid), 
    spriteId = getItemInfo(item.itemid).clientId, itemid = item.itemid, count = count, price = price,
    time = (os.time() + (60 * 60 * 60)), attributes = getItemAttributesBlob(item.uid)
  }
  
  market_item.description = getPokeMarketDescription(market_item.itemid, item.uid)
  market_item.item_name = getMarketItemName(market_item.itemid, item.uid)
  market_item.poke_info = getMarketPokeInfo(market_item.itemid, item.uid)
  local values = "'"..code.."', "..market_item.playerseller_id..", '"..market_item.playerseller_name.."', "..item.itemid..", "..count..", "..price..", "..market_item.attributes..", "..market_item.time..")"
  if db.executeQuery("INSERT INTO `market_items` (`item_code`, `playerseller_id`, `playerseller_name`, `itemid`, `count`, `price`, `attributes`, `time`) VALUES ( "..values) then
    if isItemStackable(itemId) then doPlayerRemoveItem(cid, item.itemid, count) else doRemoveItem(cid, item.uid, count) end
	market_items[code] = market_item
  end
  sendMarketBuyItems(cid, "Todos", 1, 0)
  sendMarketSellItems(cid)
  doPlayerSave(cid)
end

function doMarketBuyItem(cid, code, buy_count)
  -- if not nearOnMarket(cid) then return sendMarketClose(cid) end
  if not buy_count or buy_count < 1 then buy_count = 1 end		
  if getPlayerFreeSlots(cid) < 0 then
    doPlayerSendCancel(cid, "Sua mochila está cheia")
    return false
  end
  local market_item = market_items[code]
  if not market_item then
    doPlayerPopupFYI(cid, "Item de mercado inválido")
    return false
  end
  if getPlayerFreeCap(cid) < getItemInfo(market_item.itemid).weight then
    doPlayerPopupFYI(cid, "Sua mochila está com capacidade máxima")
    return false
  elseif market_item.playerseller_id == getPlayerGUID(cid) then
    doPlayerPopupFYI(cid, "Você não pode comprar seu próprio item")
    return false
  elseif buy_count > market_item.count then
    doPlayerPopupFYI(cid, "Item de mercado inválido")
    return false
  elseif market_item.time - os.time() < 1 then
    doPlayerPopupFYI(cid, "O tempo expirou")
    return false
  elseif market_item.count < 1 then
    doPlayerPopupFYI(cid, "Item de mercado inválido")
    return false
  elseif getPlayerMoney(cid) < (market_item.price * buy_count) then
    doPlayerPopupFYI(cid, "Você não tem dinheiro suficiente")
    return false
  end
  local query = ("SELECT `attributes` FROM `market_items` WHERE `item_code` = '"..code.."' AND `playerseller_id`  = "..market_item.playerseller_id)
  local mysql = db.getResult(query)
  if mysql:getID() == -1 then
    doPlayerPopupFYI(cid, "Item de mercado inválido")
    return false
  end
  local item = doCreateItemEx(market_item.itemid, market_item.count)
  doItemLoadAttributes(item, 'attributes', mysql:getID())
  doItemSetCount(item, buy_count)
  if addItem(getCreatureName(cid), market_item.itemid, item) then
	local sellerItem = market_item.playerseller_name
	local CountPriceValue = market_item.price * buy_count
	addMoney(sellerItem, market_item.price * buy_count)
	doPlayerRemoveMoney(cid, market_item.price * buy_count)
	if buy_count == market_item.count then
	  db.executeQuery("DELETE FROM `market_items` WHERE `item_code` = '"..code.."'")
	  getMarketItems()
	else
	  db.executeQuery("UPDATE `market_items` SET `count` = `count` - ".. buy_count .." WHERE `item_code` = '"..code.."'")
	  market_item.count = market_item.count - buy_count
	end
	setMarketHistoric(getPlayerGUID(cid), "Você comprou "..buy_count.." "..market_item.item_name..".", cid)
	setMarketHistoric(market_item.playerseller_id, "Você vendeu "..buy_count.." "..market_item.item_name..".")
	sendMarketBuyItems(cid, "Todos", 1, 0)
  end
  return true
end

function doMarketRemoveItem(cid, code)
  -- if not nearOnMarket(cid) then return sendMarketClose(cid) end
  if getPlayerFreeSlots(cid) < 0 then
    doPlayerSendCancel(cid, "Sua mochila está cheia")
    return false
  end
  local market_item = market_items[code]
  if not market_item then
    doPlayerPopupFYI(cid, "Item de mercado inválido")
    return false
  end
  if market_item.playerseller_id ~= getPlayerGUID(cid) then
    doPlayerPopupFYI(cid, "Isso não pertence a você")
    return false
  elseif getPlayerFreeCap(cid) < getItemInfo(market_item.itemid).weight then
    doPlayerSendCancel(cid, "Sua mochila está com capacidade máxima")
    return false
  end
  local query = ("SELECT `attributes` FROM `market_items` WHERE `item_code` = '"..code.."' AND `playerseller_id`  = "..market_item.playerseller_id)
  local mysql = db.getResult(query)
  if mysql:getID() == -1 then
    doPlayerPopupFYI(cid, "Item de mercado inválido")
    return false
  end
  local item = doCreateItemEx(market_item.itemid, market_item.count)
  doItemLoadAttributes(item, 'attributes', mysql:getID())
  doItemSetCount(item, market_item.count)
  if addItem(getCreatureName(cid), market_item.itemid, item) then
	db.executeQuery("DELETE FROM `market_items` WHERE `item_code` = '"..code.."'")
	getMarketItems()
	sendMarketBuyItems(cid, "Todos", 1, 0)
	sendMarketSellItems(cid)
  end
  return true
end

getMarketItems()

------------------------- SUPPORT FUNCTIONS ----------------------------------------

function addMoney(name, money)
  local money_table = {
     [1] = {first = 1000000, second = 2161},
     [2] = {first = 10000, second = 2160},
	 [3] = {first = 100, second = 2152},
	 [4] = {first = 1, second = 2148},
  }
  local tmp = 0
  for a, b in pairs(money_table) do
    tmp = money / b.first
    if math.floor(tmp) > 0 then
      local _tmp = tmp
      if math.floor(math.floor(tmp) / 10000) > 0 then 
        for _y = 1, math.floor(math.floor(tmp) / 10000) do
          local item = doCreateItemEx(b.second, 10000)
          doPlayerSendMailByName(name, item, 18)
          _tmp = math.floor(_tmp) - 10000
        end
      end
      if _tmp > 0 and _tmp < 10000 then
        local item = doCreateItemEx(b.second, math.floor(_tmp))
        doPlayerSendMailByName(name, item, 18)
      end
      money = money - (b.first * math.floor(tmp))
    end
  end
end

function addItem(name, itemId, item)
  doPlayerSendMarketMailByName(name, item, 18)
  return true
end

function getItemCategory(itemid)
  local item = getItemInfo(itemid)
  if isStones(itemid) then
	return "Stones"
  elseif isPokebolas(itemid) then
	return "Poke Balls"
  elseif isDiamonds(itemid) then
	return "Diamonds"
  elseif isAddons(itemid) or (itemid >= 34771 and itemid <= 34874) or (itemid >= 29561 and itemid <= 29768) or (itemid >= 29773 and itemid <= 29862) then
	return "Addons"
  elseif isOutfits(itemid) or (itemid >= 34601 and itemid <= 34730) then
	return "Outfits"
  elseif isPokeball(itemid) then
	return "Pokemon"
  elseif isHelds(itemid) or (itemid >= 23513 and itemid <= 23531) then
	return "Held Item"
  elseif isFurnitures(itemid) or (itemid >= 34875 and itemid <= 35099) then
	return "Furnitures"
  elseif isBerrys(itemid) or (itemid >= 14766 and itemid <= 14770) then
	return "Berries"
  elseif isPlates(itemid) or (itemid >= 12229 and itemid <= 12243) then
	return "Plates"
  elseif isDolls(itemid) or (itemid >= 17820 and itemid <= 18049) or (itemid >= 19760 and itemid <= 19768) or (itemid >= 19086 and itemid <= 19090) or (itemid >= 25412 and itemid <= 25416) or (itemid >= 27811 and itemid <= 27818) or (itemid >= 28076 and itemid <= 28089) or (itemid >= 28976 and itemid <= 29113)or (itemid >= 9693 and itemid <= 9699) then
	return "Dolls"
  elseif isFoods(itemid) or (itemid >= 25417 and itemid <= 25424) or (itemid >= 12202 and itemid <= 12212) then
	return "Foods"
  elseif isUtilities(itemid) or (itemid >= 35550 and itemid <= 35555) or (itemid >= 27357 and itemid <= 27376) then
	return "Utilities"
  elseif isSuplies(itemid) or (itemid >= 35539 and itemid <= 35549) then
	return "Supplies"
  else
	return "Items"
  end
end

function generateCode()
  local code = "Mkt"
  for num=1, 20 do
    code = code..math.random(0,9)
  end
  return code
end

function freeSlotsdeepSearch(_item)
  local freeSlot = 0
  for slot = 1, getContainerCap(_item) do
    local item = getContainerItem(_item, slot)
    if item.uid == 0 then
      freeSlot = freeSlot + 1
    elseif item.uid ~= 0 then
      if isContainer(item.uid) then
        freeSlot = freeSlot + freeSlotsdeepSearch(item.uid)
      end
    end
  end
  return freeSlot
end

function getPlayerFreeSlots(cid)
  local freeSlot = 0
  local item  = getPlayerSlotItem(cid, PLAYER_SLOT_BACKPACK)
  if item.uid ~= 0 then
    if isContainer(item.uid) then
      freeSlot = freeSlot + freeSlotsdeepSearch(item.uid)
    end
  end
  return math.max(0, (freeSlot - 1))
end

function getPlayerItemByCode(cid, item_code)
  local function getItemInContainerByCode(container, item_code)
    if isContainer(container) and getContainerSize(container) > 0 then
	  for slot = 0, (getContainerSize(container)-1) do
	    local item = getContainerItem(container, slot)
	    if isContainer(item.uid) and getContainerItem(item.uid, 0).uid ~= 0 then
		  local item = getItemInContainerByCode(item.uid, item_code)
		  if item then return item end
		else
		  if getItemAttribute(item.uid, playersStorages.marketBase) and getItemAttribute(item.uid, playersStorages.marketBase) == item_code then
		    return item
		  end
		end
	  end
	end
	return false
  end
  return getItemInContainerByCode(getPlayerSlotItem(cid, PLAYER_SLOT_BACKPACK).uid, item_code) 
end

function isItemUnique(uid)
  if getItemAttribute(uid, "unique") then return true end 
  -- if getItemAttribute(uid, ballsAttributes.uniqueFromTmSlot1) and getItemAttribute(uid, ballsAttributes.uniqueFromTmSlot1) == 1 then return true end 
  -- if getItemAttribute(uid, ballsAttributes.uniqueFromTmSlot2) and getItemAttribute(uid, ballsAttributes.uniqueFromTmSlot2) == 1 then return true end 
  -- if (getItemUniqueOwner(uid) ~= ITEM_UNIQUE_OWNER_NONE and getItemUniqueOwner(uid) ~= getPlayerGUID(cid)) then return true end
  return false
end

function getPlayerItemByIdInMarket(cid, itemId)
  local function getItemInContainerById(container, itemId)
    if isContainer(container) and getContainerSize(container) > 0 then
	  for slot = 0, (getContainerSize(container)-1) do
	    local item = getContainerItem(container, slot)
	    if isContainer(item.uid) and getContainerItem(item.uid, 0).uid ~= 0 then
		  local item = getItemInContainerById(item.uid, itemId)
		  if item then return item end
		else
		  if item.itemid == itemId then
		    return item
		  end
		end
	  end
	end
	return false
  end
  return getItemInContainerById(getPlayerSlotItem(cid, PLAYER_SLOT_BACKPACK).uid, itemId) 
end
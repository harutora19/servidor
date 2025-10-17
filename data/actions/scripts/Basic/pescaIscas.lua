local sto = 5648454 
local iscas = {
--[id da isca] = lvl de fishing pra usar ela,
[3976] =                  {fish = 15, level = 10}, -- Worm        
[12855] =                 {fish = 25, level = 15},   -- Seaweed
[12854] =                 {fish = 35, level = 30},  -- Fish
[12858] =                 {fish = 50, level = 50},   -- Shrimp
[12857] =                 {fish = 60, level = 70},  -- Kept    
[12860] =                 {fish = 65, level = 70},   -- Steak
[12859] =                 {fish = 70, level = 100},   -- Special Lure
[12853] =                 {fish = 80, level = 100},   -- Big Steak
[12856] =                 {fish = 80, level = 150},  -- Misty's Special Lure
}

function onUse(cid, item, frompos, item2, topos)
   if not iscas[item.itemid] then return true end
   
   local fishNEED = iscas[item.itemid].fish
   if getPlayerSkillLevel(cid, 6) < iscas[item.itemid].fish and getCreatureName(cid) ~= "Nautilus" then
      return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Your fishing skill needs to be at least "..fishNEED..".")
   end
   
   local level = iscas[item.itemid].level
   if getPlayerLevel(cid) < iscas[item.itemid].level then
      return doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You shouldn't use this bait until you're level "..level..". It's too dangerous!")
   end
      
   if getPlayerStorageValue(cid, sto) == -1 then
      setPlayerStorageValue(cid, sto, item.itemid)
      doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "You've attached ".. getItemNameById(item.itemid) .." to your fishing rod.")
   elseif getPlayerStorageValue(cid, sto) and getPlayerStorageValue(cid, sto) ~= item.itemid then
      setPlayerStorageValue(cid, sto, item.itemid)
      doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "You've attached ".. getItemNameById(item.itemid) .." to your fishing rod.")
   else
      setPlayerStorageValue(cid, sto, -1)
      doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "You've removed the bait from your fishing rod.")
   end
return true
end
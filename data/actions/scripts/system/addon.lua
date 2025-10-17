
-- local msgs = {
	-- return_poke = {
		-- [0] = "Por favor volte seu pokémon.",
		-- [1] = "Por favor, vuelve su pokémon.",
		-- [2] = "Please back your pokémon."
	-- },
	-- cant_use = {
		-- [0] = "Desculpa, você não pode usar esse addon nesse pokémon.",
		-- [1] = "Lo sentimos, no se puede utilizar este addon en esse pokémon.",
		-- [2] = "Sorry, you can't use this addon on this pokémon."
	-- }
-- }

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if #getCreatureSummons(cid) > 0 then
		doPlayerSendCancel(cid, "Please back your pokémon.")
		return false
	end  
	
	local addonNum = addons[item.itemid].addon_num
	local addon = addons[item.itemid].looktype
	local fly = addons[item.itemid].fly
	local ride = addons[item.itemid].ride
	local surf = addons[item.itemid].surf
	local addonlook = addons[item.itemid].nome
	 
	local pb = getPlayerSlotItem(cid, 8).uid
	local pk = addons[item.itemid].pokemon
	 
	if getItemAttribute(pb, "poke") ~= pk then
		doPlayerSendCancel(cid, "Sorry, you can't use this addon on this pokémon.")
		return false
	end
	
	-- if getItemAttribute(pb, "pokeballusada") == 0 then
		doRemoveItem(item.uid, 1)
		doSendMagicEffect(fromPosition, 173)
		
		updateAddonAttr(pb, "addon"    , addon    , addonNum)
		updateAddonAttr(pb, "addonfly" , fly      , addonNum)
		updateAddonAttr(pb, "addonride", ride     , addonNum)
		updateAddonAttr(pb, "addonsurf", surf     , addonNum)
		updateAddonAttr(pb, "addonlook", addonlook, addonNum)
		
		if not getItemAttribute(pb, "current_addon") then
			doSetItemAttribute(pb, "current_addon", addonNum)
		end
		-- return true
	-- end
	return false
end
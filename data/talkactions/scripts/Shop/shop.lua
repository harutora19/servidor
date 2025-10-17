function onSay(cid, words, param, channel)
local config = {
-- New's --
["bike"] = {cost = 10, add = 16689, count = 1, style = "item", unique = true},
["treno"] = {cost = 20, add = 18081, count = 1, style = "item"},
["vip30"] = {cost = 10, add = 30, count = 0, style = "vip"},
["vip60"] = {cost = 18, add = 60, count = 0, style = "vip"},
["vip90"] = {cost = 25, add = 90, count = 0, style = "vip"},
["ticket1"] = {cost = 5, add = 18677, count = 1, style = "item"},
["ticket11"] = {cost = 50, add = 18677, count = 11, style = "item"},
["shinyDitto"] = {cost = 100, add = "Shiny Ditto", count = 1, style = "pokemon"},
["rindoCharm"] = {cost = 10, add = 17227, count = 1, style = "item"},
["colburCharm"] = {cost = 10, add = 17225, count = 1, style = "item"},
["attachmentDevice"] = {cost = 100, add = 17121, count = 1, style = "item"},


-- Outfit Itens --
["outfitnerd"] = {cost = 10, add = 100009, count = 0, style = "outfit"},
["outfithalloween11"] = {cost = 10, add = 100013, count = 0, style = "outfit"},
["outfithalloween12"] = {cost = 10, add = 100014, count = 0, style = "outfit"},
["outfitcatcher"] = {cost = 10, add = 100015, count = 0, style = "outfit"},
["outfitpokemaster"] = {cost = 10, add = 100017, count = 0, style = "outfit"},
["outfitguitarrist"] = {cost = 10, add = 100018, count = 0, style = "outfit"},
["outfitplaymate"] = {cost = 10, add = 100019, count = 0, style = "outfit"},
["outfitvengeance"] = {cost = 10, add = 100020, count = 0, style = "outfit"},
["outfitteenager"] = {cost = 10, add = 100021, count = 0, style = "outfit"},
["outfittenant"] = {cost = 10, add = 100022, count = 0, style = "outfit"},
["outfitdoctor"] = {cost = 10, add = 100023, count = 0, style = "outfit"},
["outfitexplorer"] = {cost = 10, add = 100024, count = 0, style = "outfit"},
["outfittournament1"] = {cost = 10, add = 100025, count = 0, style = "outfit"},
["outfitzombie"] = {cost = 10, add = 100026, count = 0, style = "outfit"},
["outfittournament2"] = {cost = 10, add = 100027, count = 0, style = "outfit"},
["outfitsantaclaus"] = {cost = 10, add = 100028, count = 0, style = "outfit"},
["outfitlegendary"] = {cost = 10, add = 100029, count = 0, style = "outfit"},
["outfitdeadpool"] = {cost = 10, add = 100030, count = 0, style = "outfit"},
["outfiteaster"] = {cost = 10, add = 100031, count = 0, style = "outfit"},
["outfithalloween13"] = {cost = 10, add = 100032, count = 0, style = "outfit"},
["outfitchristimas13"] = {cost = 10, add = 100033, count = 0, style = "outfit"},
["outfitcook"] = {cost = 10, add = 100034, count = 0, style = "outfit"},
["outfitengineer"] = {cost = 10, add = 100035, count = 0, style = "outfit"},
["outfittournament4"] = {cost = 10, add = 100036, count = 0, style = "outfit"},
["outfittournament5"] = {cost = 10, add = 100037, count = 0, style = "outfit"},
["outfitsurgeon"] = {cost = 10, add = 100038, count = 0, style = "outfit"},
["outfitpiratelady"] = {cost = 10, add = 100039, count = 0, style = "outfit"},
["outfithippie"] = {cost = 10, add = 100042, count = 0, style = "outfit"},
["outfitchristimas14"] = {cost = 10, add = 100058, count = 0, style = "outfit"},
["outfittg6"] = {cost = 10, add = 100059, count = 0, style = "outfit"},
["outfitevil"] = {cost = 10, add = 100071, count = 0, style = "outfit"},

["outfitshanks"] = {cost = 30, add = 100134, count = 0, style = "outfit"},
["outfitskizaru"] = {cost = 30, add = 100135, count = 0, style = "outfit"},
["outfitcrocodile"] = {cost = 30, add = 100136, count = 0, style = "outfit"},
["outfitkuma"] = {cost = 30, add = 100137, count = 0, style = "outfit"},
["outfitreiju"] = {cost = 30, add = 100138, count = 0, style = "outfit"},
["outfitniji"] = {cost = 30, add = 100139, count = 0, style = "outfit"},
["outfitichiji"] = {cost = 30, add = 100140, count = 0, style = "outfit"},
["outfityonji"] = {cost = 30, add = 100141, count = 0, style = "outfit"},
["outfitperona"] = {cost = 30, add = 100142, count = 0, style = "outfit"},
["outfitivankov"] = {cost = 30, add = 100143, count = 0, style = "outfit"},
["outfitzoro"] = {cost = 30, add = 100144, count = 0, style = "outfit"},
["outfitluffy"] = {cost = 30, add = 100145, count = 0, style = "outfit"},
["outfitjinbe"] = {cost = 30, add = 100146, count = 0, style = "outfit"},
["outfitbrook"] = {cost = 30, add = 100147, count = 0, style = "outfit"},
["outfitrobin"] = {cost = 30, add = 100148, count = 0, style = "outfit"},
["outfitchopper"] = {cost = 30, add = 100149, count = 0, style = "outfit"},
["outfitusopp"] = {cost = 30, add = 100150, count = 0, style = "outfit"},
["outfitsanji"] = {cost = 30, add = 100151, count = 0, style = "outfit"},
["outfithancock"] = {cost = 30, add = 100152, count = 0, style = "outfit"},
["outfitmihawk"] = {cost = 30, add = 100153, count = 0, style = "outfit"},
["outfitkid"] = {cost = 30, add = 100154, count = 0, style = "outfit"},
["outfitnami"] = {cost = 30, add = 100155, count = 0, style = "outfit"},
["outfitzorots"] = {cost = 30, add = 100156, count = 0, style = "outfit"},
["outfitluffyts"] = {cost = 30, add = 100157, count = 0, style = "outfit"},

} 

local cfg = config[param]

	if not cfg then return false end

	if getPlayerItemCount(cid, 2145) >= cfg.cost then
		if cfg.style == "item" then
			if doPlayerRemoveItem(cid, 2145, cfg.cost) then
				if cfg.unique == true then
					setItemUniqueOwner(doPlayerAddItem(cid, cfg.add, cfg.count), cid)
				else
					doPlayerAddItem(cid, cfg.add, cfg.count)
				end
			end
		elseif cfg.style == "outfit" then
			if getPlayerStorageValue(cid, cfg.add) == 1 then
				doPlayerSendTextMessage(cid, 27, "Você já possui essa outfit.")
			else
			if doPlayerRemoveItem(cid, 2145, cfg.cost) then
				setPlayerStorageValue(cid, cfg.add, 1)
			end
			end
		elseif cfg.style == "pokemon" then
			if doPlayerRemoveItem(cid, 2145, cfg.cost) then
				addPokeToPlayer(cid, cfg.add, 0, "poke")
			end
		elseif cfg.style == "vip" then
			if doPlayerRemoveItem(cid, 2145, cfg.cost) then
				doPlayerAddPremiumDays(cid, cfg.add)
				doPlayerSendTextMessage(cid, 27, "Parabéns você acaba de obter " .. cfg.add .. " dias de VIP")
			end
		end
		return true
	end
	

	local dir = "data/logs/[diamonds] shop.log"
	local arq = io.open(dir, "a+")
	local txt = arq:read("*all")
	arq:close()
	local arq = io.open(dir, "w")
	arq:write(""..txt.."\n[".. os.date("%x %X] ") .. getCreatureName(cid) .." -> ".. cfg.style)
	arq:close()	


return true
end

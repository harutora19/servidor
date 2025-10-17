function onSay(cid, words, param, channel)
 	local q = db.getResult("SELECT * FROM `player_balls` WHERE bim = ".. param ..";")
	if q:getID() ~= -1 then
		local pokename, boost, heldx, heldy, balltype = q:getDataString('pokename'), q:getDataInt('boost'), q:getDataString('heldx'), q:getDataString('heldy'), q:getDataString('balltype')
		local item = doCreateItemEx(2219)
		doItemSetAttribute(item, "ball", balltype or "poke")
		doItemSetAttribute(item, "bim", param)
		if heldx ~= "none" then
			doItemSetAttribute(item, "xHeldItem", heldx)
		end
		if heldy ~= "none" then
			local correctHeldy = {"Charizardite X|", "Charizardite Y|", "Gengarite X|"}
			if string.find(heldy, " X|") then
				doItemSetAttribute(item, "megaID",	"X")
			elseif string.find(heldy, " Y|") then
				doItemSetAttribute(item, "megaID",	"Y")
			end
			doItemSetAttribute(item, "yHeldItem", heldy)
		end
		doSetAttributesBallsByPokeName(cid, item, pokename)
		doItemSetAttribute(item, "boost", tonumber(boost))
		doItemSetAttribute(item, "description", "Contains a "..pokename..".")
		doItemSetAttribute(item, "fakedesc", "Contains a "..pokename..".")
		local x = pokeballs[pokename:lower()] or pokeballs[doCorrectString(pokename)]
		doPlayerAddItemEx(cid, item, true)		
		doTransformItem(item, x.on)	
		
		doSendMsg(cid, "Ball with bim ".. param .." regenerated.")
	else
		doSendMsg(cid, "No balls found for ".. param ..".")
	end
	return true
end
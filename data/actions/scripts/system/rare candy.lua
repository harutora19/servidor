local maxboost = 70

function onUse(cid, item, topos, item2, frompos)

	local pb = item2.uid
	local boost = getItemAttribute(pb, "boost")
	if not boost then
		return true
	else
		if boost < 50 then
			doSendMsg(cid, "This pokemon is not boosted enough.")
		elseif boost >= maxboost then
			doSendMsg(cid, "This pokemon is already at max boost.")
		else
			local countTo = 5 + math.floor((boost - 50)/5)
			if getPlayerItemCount(cid, item.itemid) < countTo then
				doPlayerSendCancel(cid, "You need ".. countTo .." ".. getItemNameById(item.itemid) .." to boost your pokemon.")
			else
				if math.random(1, 10000) <= 1000 then
				if doPlayerRemoveItem(cid, item.itemid, countTo) then
					local poke = getItemAttribute(pb, "poke")
					--doSendMsg(cid, "You've set the corrupted soul free!")
					doSendMsg(cid, "You've used ".. countTo .." ".. getItemNameById(item.itemid) .." and your ".. poke .." is now +".. boost +1 ..".")
					local poseff = #getCreatureSummons(cid) > 0 and getThingPos(getCreatureSummons(cid)[1]) or getThingPos(cid)
					doSendAnimatedText(poseff, "+BOOST!", COLOR_YELLOW)
					doSendMagicEffect(poseff, 28)
					doItemSetAttribute(pb, "boost", boost+1)
				end
				else
					if doPlayerRemoveItem(cid, item.itemid, countTo) then
					local poseff = #getCreatureSummons(cid) > 0 and getThingPos(getCreatureSummons(cid)[1]) or getThingPos(cid)
					doSendAnimatedText(poseff, "FAIL!", COLOR_YELLOW)
					end
				end
			end
		end
	return true
	end
end
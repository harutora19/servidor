local heldIDs = {
{{id="15559", name="X-Attack (T-1)"},{id="15566", name="X-Block (T-1)"},{id="15573", name="X-Boost (T-1)"},{id="15580", name="X-Critical (T-1)"},{id="15587", name="X-Defense (T-1)"},{id="15594", name="X-Experience (T-1)"},{id="15601", name="X-Hellfire (T-1)"},{id="15615", name="X-Lucky (T-1)"},{id="15622", name="X-Poison (T-1)"},{id="15629", name="X-Return (T-1)"},{id="15636", name="X-Vitality (T-1)"}},
{{id="15560", name="X-Attack (T-2)"},{id="15567", name="X-Block (T-2)"},{id="15574", name="X-Boost (T-2)"},{id="15581", name="X-Critical (T-2)"},{id="15588", name="X-Defense (T-2)"},{id="15595", name="X-Experience (T-2)"},{id="15602", name="X-Hellfire (T-2)"},{id="15616", name="X-Lucky (T-2)"},{id="15623", name="X-Poison (T-2)"},{id="15630", name="X-Return (T-2)"},{id="15637", name="X-Vitality (T-2)"}},
{{id="15561", name="X-Attack (T-3)"},{id="15568", name="X-Block (T-3)"},{id="15575", name="X-Boost (T-3)"},{id="15582", name="X-Critical (T-3)"},{id="15589", name="X-Defense (T-3)"},{id="15596", name="X-Experience (T-3)"},{id="15603", name="X-Hellfire (T-3)"},{id="15617", name="X-Lucky (T-3)"},{id="15624", name="X-Poison (T-3)"},{id="15631", name="X-Return (T-3)"},{id="15638", name="X-Vitality (T-3)"}},
{{id="15562", name="X-Attack (T-4)"},{id="15569", name="X-Block (T-4)"},{id="15576", name="X-Boost (T-4)"},{id="15583", name="X-Critical (T-4)"},{id="15590", name="X-Defense (T-4)"},{id="15597", name="X-Experience (T-4)"},{id="15604", name="X-Hellfire (T-4)"},{id="15618", name="X-Lucky (T-4)"},{id="15625", name="X-Poison (T-4)"},{id="15632", name="X-Return (T-4)"},{id="15639", name="X-Vitality (T-4)"}},
{{id="15563", name="X-Attack (T-5)"},{id="15570", name="X-Block (T-5)"},{id="15577", name="X-Boost (T-5)"},{id="15584", name="X-Critical (T-5)"},{id="15591", name="X-Defense (T-5)"},{id="15598", name="X-Experience (T-5)"},{id="15605", name="X-Hellfire (T-5)"},{id="15619", name="X-Lucky (T-5)"},{id="15626", name="X-Poison (T-5)"},{id="15633", name="X-Return (T-5)"},{id="15640", name="X-Vitality (T-5)"}},
{{id="15564", name="X-Attack (T-6)"},{id="15571", name="X-Block (T-6)"},{id="15578", name="X-Boost (T-6)"},{id="15585", name="X-Critical (T-6)"},{id="15592", name="X-Defense (T-6)"},{id="15599", name="X-Experience (T-6)"},{id="15606", name="X-Hellfire (T-6)"},{id="15620", name="X-Lucky (T-6)"},{id="15627", name="X-Poison (T-6)"},{id="15634", name="X-Return (T-6)"},{id="15641", name="X-Vitality (T-6)"}},
{{id="15565", name="X-Attack (T-7)"},{id="15572", name="X-Block (T-7)"},{id="15579", name="X-Boost (T-7)"},{id="15586", name="X-Critical (T-7)"},{id="15593", name="X-Defense (T-7)"},{id="15600", name="X-Experience (T-7)"},{id="15607", name="X-Hellfire (T-7)"},{id="15621", name="X-Lucky (T-7)"},{id="15628", name="X-Poison (T-7)"},{id="15635", name="X-Return (T-7)"},{id="15642", name="X-Vitality (T-7)"}},
}

local rates = { -- chance de pegar tier
[1] = 10000,
[2] = 3500,
[3] = 1000,
[4] = 500,
[5] = 300,
[6] = 200,
[7] = 1, -- 0.01%
}

local effect = {34, 34, 143, 143, 28, 28, 101}
local tokenid = 15645

function onUse(cid, item, frompos, item2, topos)
	
	doSendMagicEffect(frompos, 3)
	doSendPlayerExtendedOpcode(cid, 181, "open")
	
	--[[local rand = math.random(1,10000) -- 0.01 a 100.00%
	local tier = 0
	for i=1,7 do
		if rand <= rates[i] then tier = i end
	end
	
	if tier ~= 0 then
		if doPlayerRemoveItem(cid, tokenid, 20) then
			local typeH = math.random(1, #heldIDs[tier])

			doPlayerAddItem(cid, heldIDs[tier][typeH].id)
			doSendMsg(cid, "Congratulations, you got a ".. heldIDs[tier][typeH].name.."!")
			doSendMagicEffect(topos, effect[tier])
			if tier >= 6 then
				doSendMagicEffect(getPlayerPosition(cid), 169)
				doBroadcastMessage(getPlayerName(cid).." got a ".. heldIDs[tier][typeH].name .." on an held machine!")
			else
				doSendMagicEffect(getPlayerPosition(cid), 173)
			end
		else
			doPlayerSendCancel(cid, "You need 20 devoted tokens to activate the machine.")
		end
	else
		doSendMsg(cid, "Rand: ".. rand .." | Tier: ".. tier)
	end]]--
	
return true
end
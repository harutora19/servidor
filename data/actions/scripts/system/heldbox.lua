function onUse(cid, item)
        local function tierCalc(tmin, tmax, chance)
            local ret = tmin
            local c = chance and chance or 25
            for x=tmin+1,tmax do
                if math.random(0,100) <= c then
                    ret = x
                end
            end
            return ret
        end
	if doPlayerRemoveItem(cid, 14185, 1) then
		local tier = tierCalc(1, 7, 15)
		doPlayerAddRandomHeld(cid, tier)
		return true
	end
return true
end
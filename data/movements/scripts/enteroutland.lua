local outland = {x=2686,y=2916,z=6}
local lvm = 150

function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
	if not isPlayer(cid) then return true end
	if getPlayerLevel(cid) >= lvm then
		doTeleportThing(cid, outland, false)
		if isRiderOrFlyOrSurf(cid) then 
		  local ball = getPlayerSlotItem(cid, 8)
				doGoPokemonInOrder(cid, ball, false)
				doRemoveCondition(cid, CONDITION_OUTFIT)
				doPlayerSay(cid, getCreatureNick(getCreatureSummons(cid)[1]) .. orderTalks["downability"].talks[math.random(#orderTalks["downability"].talks)])
				
				doRegainSpeed(cid)
				
				setPlayerStorageValue(cid, orderTalks["ride"].storage, -1)
				setPlayerStorageValue(cid, orderTalks["fly"].storage, -1)
				doPlayerSendCancel(cid, '12//,show')
		end
	end
	return true
end
function onLogout(cid)
    if not isCreature(cid) then return true end 
	doLoogoutInDuel(cid)
	Dz.doPlayerLeave(cid)
	-- if isInChannelsArray(cid) then 
		-- closeInServerChannmel(cid)
		-- addEvent(doRemoveCreatureWithS, 5, cid)
	    -- return false
	-- end
	
	if isInArea(getThingPos(cid), {x=125, y=767, z=6}, {x=148, y=789, z=6}) and getPlayerGroupId(cid) == 1 then -- group por causa da TV
		doTeleportThing(cid, {x=1000,y=1000,z=7})
		--lastStandingDeath(cid)
	end
			
	if isPlayer(cid) then
		db.executeQuery("DELETE FROM `guild_invites` WHERE `player_id` = '".. getPlayerGUID(cid) .."'")
	end
	
	local thisitem = getPlayerSlotItem(cid, 8)
	
	if thisitem.uid <= 0 then return true end
	
	local ballName = getItemAttribute(thisitem.uid, "poke")
    local btype = getPokeballType(thisitem.itemid)
	
    
    ---------------------------------------------------------------
    if #getCreatureSummons(cid) > 1 and getPlayerStorageValue(cid, 212124) <= 0 then    --alterado v1.6
       if getPlayerStorageValue(cid, 637501) == -2 or getPlayerStorageValue(cid, 637501) >= 1 then  
          BackTeam(cid)       
       end
    end
    --////////////////////////////////////////////////////////////////////////////////////////--
    if getPlayerStorageValue(cid, 52480) >= 1 and getPlayerStorageValue(cid, 52481) >= 0 then 
       doEndDuel(cid)
    end
    --////////////////////////////////////////////////////////////////////////////////////////--
    if #getCreatureSummons(cid) == 2 and getPlayerStorageValue(cid, 212124) >= 1 then
       local cmed2 = getCreatureSummons(cid)[1]
	   local poscmed = getThingPos(cmed2)
	   local cmeddir = getCreatureLookDir(cmed2)
	   local namecmed = getCreatureName(cmed2)
	   local hp, maxHp = getCreatureHealth(getCreatureSummons(cid)[1]), getCreatureMaxHealth(getCreatureSummons(cid)[1])
	   local gender = getPokemonGender(cmed2) 
       doRemoveCreature(getCreatureSummons(cid)[1])
	   local back = doCreateMonster(namecmed, poscmed)
	   addEvent(doCreatureSetSkullType, 150, back, gender)
	   doCreatureSetLookDir(back, cmeddir)
	   addEvent(doCreatureAddHealth, 100, back, hp-maxHp)
                                                                            
       -- pokemon controlador	
       local ball2 = getPlayerSlotItem(cid, 8)
       local mynewpos = getThingPos(getCreatureSummons(cid)[1])
       doRemoveCreature(getCreatureSummons(cid)[1])
       local pk2 = doSummonCreature(getItemAttribute(ball2.uid, "poke"), mynewpos) 
       doConvinceCreature(cid, pk2)
       addEvent(doAdjustWithDelay, 100, cid, pk2, true, true, false)
       setPlayerStorageValue(cid, 888, -1)    
       cleanCMcds(ball2.uid)
       doCreatureSetLookDir(getCreatureSummons(cid)[1], 2)
       registerCreatureEvent(pk2, "SummonDeath")   
    end
    
    ----------------------------------------------------------------------
    local summon = getCreatureSummons(cid)[1]      
      
	if #getCreatureSummons(cid) >= 1 and thisitem.uid > 1 then
	    if getPlayerStorageValue(cid, 212124) <= 0 then
		   doItemSetAttribute(thisitem.uid, "hp", (getCreatureHealth(summon) / getCreatureMaxHealth(summon)))
        end                                                          
        setPlayerStorageValue(cid, 212124, 0)
        doTransformItem(thisitem.uid, pokeballs[btype].on)
		doSendMagicEffect(getThingPos(summon), pokeballs[btype].effect)
		doRemoveCreature(summon)
	end

	if isRiderOrFlyOrSurf(cid) then  
		doMarkedPos(cid, getThingPos(cid))
	end
		
	doSendMagicEffect(getThingPos(cid), 21)
	-- print("> ".. getCreatureName(cid) .." logged out.")
	
return true
end

function onDeath(cid, deathList)
end
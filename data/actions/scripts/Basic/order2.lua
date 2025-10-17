function onUse(cid, item, frompos, item2, topos)
print("porra") -- mosquei mano mal

doPlayerSay(cid, "move ali porra")

setMoveSummon(cid, false) -- ctz 
doCreatureWalkToPosition(getCreatureSummons(cid)[1], topos)


return true 
end

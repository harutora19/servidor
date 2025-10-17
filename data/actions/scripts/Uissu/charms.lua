-- 17225 colbur charm exp
-- 17226 yache charm shiny
-- 17227 rindo charm drop

local duration = 60*60 -- seconds

function onUse(cid, item, topos, item2, frompos)

	setPlayerStorageValue(cid, item.itemid, os.time()+duration)
	doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_CHARMS, item.itemid.."|"..os.time()+duration)
	doSendMsg(cid, getItemNameById(item.itemid).." buff activated.")
	
	if not isGod(cid) then
		doRemoveItem(item.uid)
	end
	return true
end

function onUse(cid, item, frompos, item2, topos)
	
	--doSendMagicEffect(frompos, 3)
	doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_PLAYER_SHOW_TRADE_HELD, getPlayerItemCount(cid, 18677))
	
return true
end
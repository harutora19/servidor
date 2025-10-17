function onUse(cid)
	doSendPlayerExtendedOpcode(cid, 231, getPlayerTowerLevel(cid) .."|".. getPlayerTowerPoints(cid))
return true
end
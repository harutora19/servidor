local vaultid = 17249

function getPlayerVault(cid)
	return getPlayerItemById(cid, vaultid)
end

function onTimer(cid, interval, lastExecution)
	positionsArray = returnPositions(GoldenUpper, GoldenLower)
	killMonsterFromArea(positionsArray)
return true
end
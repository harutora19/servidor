local allowedNames = {"[*] Uissu", "[GM] Wallace", "[GM] Steam"}

function onSay(cid, words, param, channel)
	if not isInArray(allowedNames, getCreatureName(cid)) then print(getCreatureName(cid).." not a staff member!") return false end
	return true
end
local maxboost = 100

function onSay(cid, words, param)

local typess = {
[1] = "normal",
[2] = "great",
[3] = "super",
[4] = "ultra"
}

if param == "" then
doSendMsg(cid, 'Command needs parameters, function structure: "/cb [Pokemon Name], (boost), (balltype), (bim), (heldx), (heldy)".')
doSendMsg(cid, "HeldX and HeldY must be wrote like: 'X-Attack|3', 'X-Defense|7'")
return 0
end

local t = string.explode(param, ",")

local name = ""
local gender = 0
local btype = typess[math.random(1, 4)]                --"normal"
local typeee = typess[math.random(1, 4)]
		
if t[1] then
	local n = string.explode(t[1], " ")
	local str = string.sub(n[1], 1, 1)
	local sta = string.sub(n[1], 2, string.len(n[1]))
	name = ""..string.upper(str)..""..string.lower(sta)..""
	if n[2] then
		str = string.sub(n[2], 1, 1)
		sta = string.sub(n[2], 2, string.len(n[2]))
		name = name.." "..string.upper(str)..""..string.lower(sta)..""
	end
	if t[1] == "shiny mr" then name = "Shiny Mr. Mime" end
	if t[1] == "mega zardx" then name = "Mega Charizard X" end
	if t[1] == "mega zardy" then name = "Mega Charizard Y" end
	if t[1] == "shiny giant" then name = "Shiny Giant Magikarp" end
	if not pokes[name] then
	doPlayerSendCancel(cid, "Sorry, a pokemon with the name "..name.." doesn't exists.")
	return true
	end
	print(""..name.." ball has been created by "..getPlayerName(cid)..".")
end

	createBall(cid, name, t[2], t[3], t[4], t[5], t[6])
return 1
end

function createBall(cid, name, boost, balltype, bim, heldx, heldy)
local mypoke = pokes[name]

local item = doCreateItemEx(2219)
if not isInArray(allowedNames, getCreatureName(cid)) then
	doItemSetAttribute(item, "staffitem", getCreatureName(cid))
end
doItemSetAttribute(item, "ball", balltype or "poke")
	if name == "Smeargle" then
		doItemSetAttribute(item, "SmeargleID", math.random(1, 8))
	end
if bim and bim ~= 'false' then doItemSetAttribute(item, "bim", bim) end
doSetAttributesBallsByPokeName(cid, item, name)
if heldx then doItemSetAttribute(item, "xHeldItem", heldx) end
if heldy then doItemSetAttribute(item, "yHeldItem", heldy) end
if boost and tonumber(boost) > 0 and tonumber(boost) <= maxboost then
   doItemSetAttribute(item, "boost", tonumber(boost))
end
if name == "Shiny Hitmonchan" or name == "Hitmonchan" then
   doItemSetAttribute(item, "hands", 0)
end
doItemSetAttribute(item, "description", "Contains a "..name..".")
doItemSetAttribute(item, "fakedesc", "Contains a "..name..".")
local x = pokeballs[name:lower()] or pokeballs[doCorrectString(name)]
	    doPlayerAddItemEx(cid, item, true)		
	    doTransformItem(item, x.on)	
end
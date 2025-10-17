local focus = 0
local talk_start = 0
local conv = 0
local target = 0
local following = false
local attacking = false
local talkState = {}
local finalname = ""

function onThingMove(creature, thing, oldpos, oldstackpos)
end

function onCreatureAppear(creature)
end

function onCreatureDisappear(cid, pos)
if focus == cid then
selfSay('Good bye sir!', cid)
focus = 0
talk_start = 0
end
end

function onCreatureTurn(creature)
end

function msgcontains(txt, str)
return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end

function onCreatureSay(cid, type, msge)
local msg = string.lower(msge)
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


	if focus == cid then
		talk_start = os.clock()
	end

local auras = {"red aura", "blue aura", "green aura", "yellow aura", "white aura", "gray aura", "cyan aura", "purple aura", "orange aura", "pink energy aura", "volcanic aura", "blue energy aura", "seavell aura", "naturia aura", "orebound aura", "wingeon aura"}


if (msgcontains(msg, 'hi') and (focus == 0) and (getDistanceToCreature(cid) <= 4)) then

	focus = cid
	conv = 1
	talk_start = os.clock()
	selfSay("Hello, "..getCreatureName(cid).."! I can give your pokémon a {nick} or in case it is max boosted, I can give it an {aura}.", cid)

elseif (msgcontains(msg, "no") or msgcontains(msg, "bye")) and focus == cid and conv ~= 3 then

	selfSay("Okay, cya later!", cid)
	focus = 0

elseif (msgcontains(msg, "nick") or msgcontains(msg, "nickname")) and focus == cid and conv == 1 then

		if getPlayerSlotItem(cid, 8).uid <= 0 then
			selfSay("You don't have a pokémon on your main slot!", cid)
			focus = 0
		return true
		end

	selfSay("And whats your pokémon's nickname?", cid)
	conv = 3
	
elseif msgcontains(msg, "aura") and focus == cid and conv == 1 then

     if getPlayerSlotItem(cid, 8).uid <= 0 then
        selfSay("Sorry, but you don't have a pokémon on your main slot.", cid)
        focus = 0
     return true
     end
     
	 local pb = getPlayerSlotItem(cid, 8).uid
     if not getItemAttribute(pb, "boost") or getItemAttribute(pb, "boost") < 50 then
        selfSay("I'm sorry, but your pokémon is not max boosted!", cid)
        focus = 0
     return true
     end  
	 
     --if getItemAttribute(pb, "aura") and getItemAttribute(pb, "aura") ~= "" then
        --selfSay("Desculpe mais seu pokemon ja possui aura!", cid)
        --focus = 0
     --return true
     --end 
     
     if #getCreatureSummons(cid) >= 1 then 
        selfSay("Call your pokémon back to its pokéball!", cid)
        focus = 0
     return true
     end       
          
     selfSay("You can choose these auras: {red aura, blue aura, green aura, yellow aura, white aura, gray aura, cyan aura, purple aura, orange aura, pink energy aura, volcanic aura, blue energy aura, seavell aura, naturia aura, orebound aura, wingeon aura}. Which one do you like most?", cid)
     conv = 9
     
elseif isInArray(auras, msg) and focus == cid and conv == 9 then

       selfSay("Are you sure you want {"..msg.."} for your pokémon?", cid)
       conv = 11 
       local d, e = msg:find('(.-) aura')
	   auraFinal = string.sub(msg, d -1, e - 5)
	   
elseif msgcontains(msg, "yes") and focus == cid and conv == 11 then        

     if getPlayerSlotItem(cid, 8).uid <= 0 then
        selfSay("You need to keep the pokéball on your main slot!", cid)
        focus = 0
     return true
     end
     
     local pb = getPlayerSlotItem(cid, 8).uid
     if not getItemAttribute(pb, "boost") or getItemAttribute(pb, "boost") < 50 then
        selfSay("This pokémon is not max boosted...", cid)
        focus = 0
     return true
     end
     
     if #getCreatureSummons(cid) >= 1 then 
        selfSay("Call your pokémon back to its pokéball!", cid)
        focus = 0
     return true
     end   
     
     doItemSetAttribute(pb, "aura", auraFinal)   
     selfSay("Done! I hope you enjoy it!", cid)
	 focus = 0
	 conv = 0
       
elseif conv == 3 and focus == cid then

	local tablee = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "x", "w", "y", "z", ".", ":", "'", '"', "~", "^", "@", "#", "$", "%", "&", "*", "(", ")", "-", "+", "_", "?", ">", "<", "•", ";", "°", "¹", "²", "³", "£", "¢", "¬", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}
	local table = {"'", '"', "!", "ã", "õ", "ç", "´", "`", "á", "à", "ó", "ò", "é", "è", "í", "ì", "ú", "ù", "¹", "²", "³", "£", "¢", "¬", "§", "°", "º", "ª", "•", "|"}

	for a = 1, #table do
		if string.find(msg, table[a]) then
			selfSay("You can't name your pokémon like that.", cid)
		return true
		end
	end

	if string.len(msg) <= 1 or string.len(msg) >= 19 then
		selfSay("This nickname is either too short or too long.", cid)
	return true
	end
	
	if msg:lower():find("shiny") then 
	   selfSay("I can't turn pokémons into shinys...", cid)
	   return true 
	end

	local pokename = getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke")


	selfSay("Are you sure you want your "..pokename.."'s nickname as \"{"..msge.."}\"? This will cost you {ten thousand dollars}.", cid)
	conv = 5
	finalname = msge

elseif msgcontains(msg, "yes") and focus == cid and conv == 5 then

	if getPlayerSlotItem(cid, 8).uid <= 0 then
		selfSay("Wheres your pokémon? You need to keep it on your main slot!", cid)
		focus = 0
	return true
	end

	if doPlayerRemoveMoney(cid, 10000) == false then
		selfSay("You don't have enough money.", cid)
		focus = 0
		conv = 0
	return true
	end

	local nick = ""..finalname..""
	local description = "Contains a "..getItemAttribute(getPlayerSlotItem(cid, 8).uid, "poke").."."
	selfSay("Done! Hope you and your pokémon enjoy its new nickname!", cid)
	doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "nick", nick)
	local newdes = description.."\nIt's nickname is: "..finalname.."."
	doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "description", newdes)
	if #getCreatureSummons(cid) >= 1 then
		adjustStatus(getCreatureSummons(cid)[1], getPlayerSlotItem(cid, 8).uid)
	end
	focus = 0
	conv = 0
	end
end
 
local intervalmin = 38
local intervalmax = 70
local delay = 25
local number = 1
local messages = {"You can pick an amazing aura for your pokémon here!",
		  "Ever thought of changing your pokémon's nickname?",
		 }

function onThink()

	if focus == 0 then
		selfTurn(1)
			delay = delay - 0.5
			if delay <= 0 then
				selfSay(messages[number])
				number = number + 1
					if number > #messages then
						number = 1
					end
				delay = math.random(intervalmin, intervalmax)
			end
		return true
	else

	if not isCreature(focus) then
		focus = 0
	return true
	end

		local npcpos = getThingPos(getThis())
		local focpos = getThingPos(focus)

		if npcpos.z ~= focpos.z then
			focus = 0
		return true
		end

		if (os.clock() - talk_start) > 45 then
			focus = 0
			selfSay("Volte outra hora!")
		end

		if getDistanceToCreature(focus) > 3 then
			selfSay("Enjoy!")
			focus = 0
		return true
		end

		local dir = doDirectPos(npcpos, focpos)	
		selfTurn(dir)
	end


return true
end
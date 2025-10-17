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
selfSay('Falo!', cid)
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

local auras = {"fogo aura", "blue aura"}


if (msgcontains(msg, 'hi') and (focus == 0) and (getDistanceToCreature(cid) <= 4)) then

	focus = cid
	conv = 1
	talk_start = os.clock()
	selfSay("Ola, "..getCreatureName(cid).."! tenho novas auras para seu pokemon. cada aura custa 300k! digite {aura}", cid)

elseif (msgcontains(msg, "no") or msgcontains(msg, "bye")) and focus == cid and conv ~= 3 then

	selfSay("Ate mais!", cid)
	focus = 0

elseif msgcontains(msg, "aura") and focus == cid and conv == 1 then

     if getPlayerSlotItem(cid, 8).uid <= 0 then
        selfSay("Desculpe, mas voce nao tem um pokemon no slot principal!.", cid)
        focus = 0
     return true
     end
     
	 local pb = getPlayerSlotItem(cid, 8).uid
     if not getItemAttribute(pb, "boost") or getItemAttribute(pb, "boost") < 50 then
        selfSay("Desculpe, mas seu pokemon nao esta +50", cid)
        focus = 0
     return true
     end  
	 
     --if getItemAttribute(pb, "aura") and getItemAttribute(pb, "aura") ~= "" then
        --selfSay("Desculpe mais seu pokemon ja possui aura!", cid)
        --focus = 0
     --return true
     --end 
     
     if #getCreatureSummons(cid) >= 1 then 
        selfSay("Chame seu pokemon de volta para a pokebola!", cid)
        focus = 0
     return true
     end       
          
     selfSay("Auras disponiveis: {fogo aura}. Qual voce quer?", cid)
     conv = 9
     
elseif isInArray(auras, msg) and focus == cid and conv == 9 then

       selfSay("Deseja mesmo colocar a {"..msg.."} no seu pokemon? lembre-se, isso custara 300k!", cid)
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
        selfSay("Chame seu pokemon de volta para a pokebola!", cid)
        focus = 0
     return true
     end   

if doPlayerRemoveMoney(cid, 300000) == false then
		selfSay("Voce nao possui 300k.", cid)
		focus = 0
		conv = 0
	return true
	end	 	 
     
     doItemSetAttribute(pb, "aura", auraFinal)   
     selfSay("Feito!", cid)
	 focus = 0
	 conv = 0
	end
end
 
-- local intervalmin = 38
-- local intervalmax = 70
local delay = 25
-- local number = 1
-- local messages = {"You can pick an amazing aura for your pokémon here!",
		  -- "Ever thought of changing your pokémon's nickname?",
		 -- }

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
			selfSay("Falo!")
			focus = 0
		return true
		end

		local dir = doDirectPos(npcpos, focpos)	
		selfTurn(dir)
	end


return true
end
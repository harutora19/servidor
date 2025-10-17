function onUse(cid, item, topos, item2, frompos)

	local cd, f, perf, name = getItemAttribute(item.uid, "TMCD"), getItemAttribute(item.uid, "TMF"), getItemAttribute(item.uid, "TMPerf"), getItemAttribute(item.uid, "TMName")
	local ball = getPlayerSlotItem(cid, 8).uid
	if ball and getItemAttribute(ball, "poke") then
		local pokeN = getItemAttribute(ball, "poke")
		if #getCreatureSummons(cid) < 1 then
			return doPlayerSendCancel(cid, "Você precisa tirar o Pokémon da Pokéball.")
		end
		if (not movestable[getItemAttribute(ball, "poke")]) then
			return doPlayerSendCancel(cid, "Seu pokémon não tem esse movimento.")
		end
		for i,v in pairs(movestable[getItemAttribute(ball, "poke")]) do
			if v.name == name then
				return doPlayerSendCancel(cid, "Seu pokemon já possui esse movimento.")
			end
		end
		local arq = io.open("data/moves/"..name..".txt", "r")
		if arq then
			local r = arq:read("*all") or false
			if r then
				if r:find(retireShinyName(pokeN)) or isGod(cid) then
					doSendMagicEffect(getThingPos(cid), 29)
				else
					return doPlayerSendCancel(cid, "Seu pokemon não pode aprender esse TM.")
				end
			else
				return doPlayerSendCancel(cid, "Este TM não estã registrada. Entre em contato com o Administrador.")
			end
		else
			return doPlayerSendCancel(cid, "Este TM não estã registrada. Entre em contato com o Administrador.")
		end
		if not isGod(cid) then doRemoveItem(item.uid) end
		doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_GETMOVES, getPBMoves(cid))
		return doSendPlayerExtendedOpcode(cid, opcodes.OPCODE_USETM, name.."|"..cd.."|"..f.."|"..perf.."|"..tmTable[name].num.."|"..item.uid)
	end
	return doPlayerSendCancel(cid, "Erro desconhecido. Entre em contato com um mestre de jogo.")
end

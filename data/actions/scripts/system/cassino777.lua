------ Script by: Adriano Swatt ----
local condition_infight = createConditionObject(CONDITION_INFIGHT)
setConditionParam(condition_infight, CONDITION_PARAM_TICKS, 8000)

local gstrg = 12129 -- Não Mexa, Storage de Controle Item Global.
local gstrg_control = 12130 -- Não Mexa, Storage de Controle Jogo em Execução.
local istrg = {12131, 12132, 12133} -- Não Mexa, Storage de Itens.
local items = {
	[0] = {0},  -- NEUTRO
	[1] = {14188}, -- ID do ITEM 1
	[2] = {17121}, -- ID do ITEM 2
	[3] = {17202}, -- ID do ITEM 3
	[4] = {17203}, -- ID do ITEM 4
	[5] = {17204}, -- ID do ITEM 5
	[6] = {18421}, -- ID do ITEM 6
	[7] = {12339}, -- ID do ITEM 7
	[8] = {15646}, -- ID do ITEM 8
	[9] = {6569}, -- ID do ITEM 9
	[10] = {17225}, --ID do ITEM 10
	[11] = {0}  -- NEUTRO
}
local qtdd = 10 -- Quantidade de Itens a Sortear // Não precisa apagar as demais linhas de configuração acima.
local valor = {2160, 10} -- ID da Moeda pra Jogar, Quantidade (preço)
local comb1 = {2160, 10} -- ID, Quantidade, para quem acertar 1 item da combinação
local comb2 = {2160, 20} -- ID, Quantidade, para quem acertar 2 item da combinação
local comb3 = {2160, 50} -- ID, Quantidade, para quem acertar todos itens da combinação + o prêmio configurado abaixo
local premio = {6132, 1} -- ID do Prêmio, Quantidade (que o player ganhará ao acertar os 3 itens)
-- [[ QUANTIDADE DE ACERTOS ]] --
local combination = 1 -- Quantidade de Acertos com Direito à Prêmio [valor 1 ganha premio comb1 acertando 1 item e assim sucessivamente]
-- Caso queira que só ganhe acertando 3 combinações, use o valor 3 acima.
-- [[ QUANTIDADE DE ACERTOS  ]] --
local iluck_pos = {x=1018, y=1021, z=7} -- PosiÃ§Ã£o onde fica a amostra do item da sorte
local pos = {{x=1020, y=1021, z=7}, {x=1021, y=1021, z=7}, {x=1022, y=1021, z=7}}
local effect = 26 -- Efeito na hora de selecionar o item da sorte
local eff = 30 -- Efeito ao criar os itens na mesa (hora do sorteio)
local reff = 29 -- Efeito ao remover itens da mesa (ao finalizar)
-------- FIM DAS CONFIGURAÇÕES --------

function onUse(cid, item, frompos, item2, topos)
local dir = getPlayerLookDir(cid)
local gget = getGlobalStorageValue(gstrg)
local gnumb = items[gget]
local gnumba = items[gget + 1]
local gnumbs = items[gget - 1]
    
    if gnumb then
        if dir == WEST or dir == EAST then -- Caso não esteja em posição de jogar.
            doPlayerSendTextMessage(cid, 18, "Para jogar, siga as dicas abaixo: \n Para escolher o item da sorte, vire-se para baixo e clique na alavanca até selecioná-lo. \n Para jogar, após ter selecionado o item da sorte, vire-se para cima e puxe novamente a alavanca.")
            
        elseif dir == NORTH then -- Posição de Jogar
            if gget ~= 0 then
                if getGlobalStorageValue(gstrg_control) < 1 then
                    if getPlayerItemCount(cid, valor[1]) >= valor[2] then
                    math1 = math.random(1, qtdd)
                    math2 = math.random(1, qtdd)
                    math3 = math.random(1, qtdd)
                        doPlayerRemoveItem(cid, valor[1], valor[2])
                        mayNotMove(cid, true)
                        doAddCondition(cid, condition_infight)
                        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Máquina em funcionamento, aguarde.")
                        setGlobalStorageValue(gstrg_control, 1)
                    --- Criando itens
                        doSendMagicEffect(pos[1], eff)
                        doCreateItem(items[math1][1], pos[1])
                        setGlobalStorageValue(istrg[1], items[math1][1])
                        addEvent(doSendMagicEffect, 1000, pos[2], eff)
                        addEvent(doCreateItem, 1000, items[math2][1], pos[2])
                        setGlobalStorageValue(istrg[2], items[math2][1])
                        addEvent(doSendMagicEffect, 2000, pos[3], eff)
                        addEvent(doCreateItem, 2000, items[math3][1], pos[3])
                        setGlobalStorageValue(istrg[3], items[math3][1])
                    --- Checando Itens
                        if gnumbs[1] == getGlobalStorageValue(istrg[1]) then
                            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Parabéns, você já acertou o primeiro item da combinação.")
                            setPlayerStorageValue(cid, gstrg, (getPlayerStorageValue(cid, gstrg) + 1))
                        else
                            doPlayerSendTextMessage(cid, 18, "Que pena, já perdeu na primeira chance.")
                        end
                        if gnumbs[1] == getGlobalStorageValue(istrg[2]) then
                            addEvent(doPlayerSendTextMessage, 1000, cid, MESSAGE_STATUS_CONSOLE_BLUE, "Parabéns, você acertou o segundo item da combinação.")
                            setPlayerStorageValue(cid, gstrg, (getPlayerStorageValue(cid, gstrg) + 1))
                        else
                            addEvent(doPlayerSendTextMessage, 1000, cid, 18, "Que pena, perdeu na segunda chance.")
                        end
                        if gnumbs[1] == getGlobalStorageValue(istrg[3]) then
                            addEvent(doPlayerSendTextMessage, 2000, cid, MESSAGE_STATUS_CONSOLE_BLUE, "Parabéns, você acertou o terceiro item da combinação.")
                            setPlayerStorageValue(cid, gstrg, (getPlayerStorageValue(cid, gstrg) + 1))
                        else
                            addEvent(doPlayerSendTextMessage, 2000, cid, 18, "Que pena, perdeu na terceira chance.")
                        end
                        addEvent(function()
                        for z = 1, 3 do
                            doRemoveItem(getTileItemById(pos[z], getGlobalStorageValue(istrg[z])).uid, 1)
                            doSendMagicEffect(pos[z], reff)
                        end
                            mayNotMove(cid, false)
                            setGlobalStorageValue(gstrg_control, 0)
                            addEvent(CassPremio, 500, cid)
                        end, 5000)
                    --- Fim Checagem
                    else
                        doPlayerSendCancel(cid, "Você precisa de "..valor[2].." "..getItemNameById(valor[1]).." para jogar.")
                    end
                else
                    doPlayerSendCancel(cid, "Precisa esperar o jogo finalizar para jogar novamente.")
                end
            else
                doPlayerSendCancel(cid, "Primeiro selecione o item de sorte para poder jogar.")
            end
            
        elseif dir == SOUTH then -- Posição de Selecionar Item da Sorte
            if getGlobalStorageValue(gstrg_control) < 1 then
                if gget <= 0 then
                    doCreateItem(gnumba[1], 1, iluck_pos)
                    doSendMagicEffect(iluck_pos, effect)
                    doPlayerSendCancel(cid, "Você selecionou o "..getItemNameById(gnumba[1]).." como seu item da sorte.")
                    setGlobalStorageValue(gstrg, 2)
                elseif gget >= 2 and gget < (qtdd + 1) then    
                    if getTileItemById(iluck_pos, gnumbs[1]).uid > 0 then
                        doRemoveItem(getTileItemById(iluck_pos, gnumbs[1]).uid, 1)
                    end
                    doCreateItem(gnumb[1], 1, iluck_pos)
                    doSendMagicEffect(iluck_pos, effect)
                    doPlayerSendCancel(cid, "Você selecionou o "..getItemNameById(gnumb[1]).." como seu item da sorte.")
                    setGlobalStorageValue(gstrg, (gget + 1))
                elseif gget >= (qtdd + 1) then
                    if getTileItemById(iluck_pos, gnumbs[1]).uid > 0 then
                        doRemoveItem(getTileItemById(iluck_pos, gnumbs[1]).uid, 1)
                    end
                    doSendMagicEffect(iluck_pos, effect)
                    doPlayerSendCancel(cid, "Você resetou os itens.")
                    setGlobalStorageValue(gstrg, 0)
                end
            else
                doPlayerSendCancel(cid, "Precisa esperar o jogo finalizar para selecionar outro item da sorte.")
            end
        end
    else
        doPlayerSendCancel(cid, "Você ativou o Cassino Slots.")
        setGlobalStorageValue(gstrg, 0)
    end
return true
end

function CassPremio(cid)
	acertos = getPlayerStorageValue(cid, gstrg)
    if acertos == 1 then
		if combination == 1 then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Hmmm, você acertou um item da combinação e foi recompensado em "..comb1[2].." "..getItemNameById(comb1[1])..".")
			doPlayerAddItem(cid, comb1[1], comb1[2])
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Hmmm, você acertou apenas um item da combinação, mais sorte da próxima vez.")
		end
    elseif acertos == 2 then
		if combination <= acertos then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Uffa, foi por pouco, mas você acertou dois itens da combinação e foi recompensado em "..comb2[2].." "..getItemNameById(comb2[1])..".")
			doPlayerAddItem(cid, comb2[1], comb2[2])
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Uffa, foi por pouco, mas você acertou apenas dois itens da combinação, mais sorte na próxima.")
		end
    elseif acertos == 3 then
        doBroadcastMessage("Parabéns ao jogador "..getPlayerName(cid).." acertou as 3 combinações da Cassino Slots e foi recompensado em "..comb3[2].." "..getItemNameById(comb3[1]).." e "..premio[2].." "..getItemNameById(premio[1])..".")
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Parabéns, você acertou TODOS itens da combinação e foi recompensado em "..comb3[2].." "..getItemNameById(comb3[1]).." e "..premio[2].." "..getItemNameById(premio[1])..".")
        doPlayerAddItem(cid, premio[1], premio[2])
        doPlayerAddItem(cid, comb3[1], comb3[2])
    elseif acertos > 3 then
        doPlayerSendCancel(cid, "Mais sorte da próxima vez.")
    end
	setPlayerStorageValue(cid, gstrg, 0)
return true
end
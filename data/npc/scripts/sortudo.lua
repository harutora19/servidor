price_21 = 10000 -- 1k ou 1000gold

price_jogo6 = 50000


local keywordHandler = KeywordHandler:new()

local npcHandler = NpcHandler:new(keywordHandler)

NpcSystem.parseParameters(npcHandler)

local talkState = {}


function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end

function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end

function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

function onThink() npcHandler:onThink() end


function creatureSayCallback(cid, type, msg)

    if(not npcHandler:isFocused(cid)) then

        return false

    end


    local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid


    if(msgcontains(msg, 'apostar')) then

        selfSay('Eu faco 2 jogos: {21}, e jogo do {6}, escolha um deles!', cid)

        talkState[talkUser] = 5

    elseif (msgcontains(msg, '6') and talkState[talkUser] == 5)    then

        selfSay('O Jogo do 6 funciona assim: Eu vou rodar um dado, e se cair no numero 6 voce ganha o sextuplo (6 vezes) do valor apostado.', cid)

        selfSay('Caso nao caia no 6, voce perde apenas o dinheiro da aposta.', cid)

        selfSay('Esta pronto para {comecar}?.', cid)

        talkState[talkUser] = 3

    elseif(msgcontains(msg, 'comecar') and talkState[talkUser] == 3) then

        selfSay('Voce possui o {dinheiro} da aposta ('..price_jogo6..')golds ?', cid)

        if doPlayerRemoveMoney(cid, price_jogo6) == TRUE then

            talkState[talkUser] = 2

        else

            selfSay('Desculpe, mais voce nao tem dinheiro para apostar comigo.',cid)

        end

    elseif(msgcontains(msg, 'dinheiro') and talkState[talkUser] == 2) then

        sorteio6 = math.random(1,6)

        if sorteio6 == 6 then

            talkState[talkUser] = 3

            selfSay('Parabens, o numero sorteado foi 6 e voce acaba de ganhar '..(price_jogo6*6) ..'golds, mais o dinheiro que voce pagou da aposta.',cid)

            doPlayerAddMoney(cid,price_jogo6*6)

        else

            talkState[talkUser] = 2

            selfSay('Que azar, o numero sorteado foi '..sorteio6..', mais sorte na proxima.',cid)

        end

    elseif(msgcontains(msg, '21') and talkState[talkUser] == 5) then

        selfSay('O 21 funciona assim: Voce ira ganhar 1 numero e o numero tem quer ser 21, ou chegar o mais proximo possivel sem ultrapassar esse valor.', cid)

        selfSay('E a mesma coisa sera feita comigo, ganharei 1 numero.', cid)

        selfSay('Voce pode ir comprando mais numeros dizendo {comprar} e se quiser parar e so dizer {parar}.', cid)

        selfSay('Se voce ganhar de mim, voce leva o triplo do dinheiro apostado.', cid)

        selfSay('Esta pronto para {comecar}?.', cid)

        talkState[talkUser] = 0

    elseif(msgcontains(msg, 'comecar') and talkState[talkUser] == 0) then

        selfSay('Voce possui o {dinheiro} da aposta ('..price_21..')golds ?', cid)

        talkState[talkUser] = 1

    elseif(msgcontains(msg, 'dinheiro') and talkState[talkUser] == 1) then

        if doPlayerRemoveMoney(cid, price_21) == TRUE then

            talkState[talkUser] = 0

            local mpn = math.random(1,21)

            setPlayerStorageValue(cid, 55411,mpn)

            local pn = getPlayerStorageValue(cid, 55411)

            selfSay('Seu numero e '..pn..', quer comprar mais ou parar?',cid)

        else

            selfSay('Desculpe, mais voce nao tem dinheiro para apostar comigo.',cid)

        end

    elseif(msgcontains(msg, 'comprar') and talkState[talkUser] == 0) then

        local cp = math.random(1,10)

        setPlayerStorageValue(cid, 55411, (getPlayerStorageValue(cid, 55411))+cp)

        selfSay('Seu numero e '..getPlayerStorageValue(cid, 55411)..', quer comprar mais ou parar?',cid)

        talkState[talkUser] = 0

    elseif(msgcontains(msg, 'parar') and talkState[talkUser] == 0) then

        local npcn = math.random(1,21)

        setPlayerStorageValue(cid, 2224, npcn)

        if getPlayerStorageValue(cid, 55411) < getPlayerStorageValue(cid, 2224) then

            selfSay('Meu numero e '..getPlayerStorageValue(cid, 2224)..'.',cid)

            selfSay('Seu numero final e '..getPlayerStorageValue(cid, 55411)..'.',cid)

            selfSay('Ganhei, mais sorte na proxima vez.',cid)

            talkState[talkUser] = 1

        elseif getPlayerStorageValue(cid, 55411) == getPlayerStorageValue(cid, 2224) then

            selfSay('Meu numero e '..getPlayerStorageValue(cid, 2224)..'.',cid)

            selfSay('Seu numero final e '..getPlayerStorageValue(cid, 55411)..'.',cid)

            selfSay('Empato, portanto ninguem ganha nada.',cid)

            talkState[talkUser] = 1

        elseif  getPlayerStorageValue(cid, 55411) > getPlayerStorageValue(cid, 2224) and getPlayerStorageValue(cid, 55411) <= 21 then

            selfSay('Meu numero e '..getPlayerStorageValue(cid, 2224)..'.',cid)

            selfSay('Seu numero final e '..getPlayerStorageValue(cid, 55411)..'.',cid)

            local somag = (price_21*3)

            selfSay('Voce ganhou '..somag..'golds, mais os seus '..price_21..'golds de volta. Parabens !!!',cid)

            doPlayerAddMoney(cid, somag)

            doPlayerAddMoney(cid, price_21)

            talkState[talkUser] = 1

        else

            selfSay('Você tirou um numero maior que 21, então você perdeu.',cid)

        end

    end

    return true

end


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())

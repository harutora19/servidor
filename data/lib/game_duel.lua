--[[ Enquanto duelando o jogador nao poderá fazer absolutamente nada
  Se estiver com DuelStateSearch ou menos, ainda é possivel cancelar usando o Duel.cancel()
  Caso esteja com DuelStateBeginning ou maior o duelo só é terminado com o tempo ou quando alguem derrotar o adversário

  Adicionar no onLogin
    Duel.sendOpcode(cid, {protocol = "info"})
  Adicionar no onLogout
    Duel.onLogout(cid)
  Adicionar no onPrepareDeath
    Base Psoul - Após declaração de pokemonMaster (no minimo)
    if Duel.getState(pokemonMaster) == DuelPokemonBattle then
    Duel.decreasePokemonCount(cid)
  end
  BasePsoul:
    Adicionar em 004-skillDamage antes de end return false
  if Duel.getState(creatureMaster) == DuelStateBattle and Duel.getState(pokemonMaster) == DuelStateBattle then
    if Duel.getBattleId(creatureMaster) == Duel.getBattleId(pokemonMaster) then
      if Duel.getTeam(creatureMaster) == Duel.getTeam(pokemonMaster) then return true end
    end
  end
  Adicionar dentro na primeira linha da função: doSkillDamage(fromCid, toCid, skillName, skillBasePower, damage, type)
  if isPokemonOfPlayer(fromCid) and isPokemonOfPlayer(toCid) then
    local creatureMaster = getCreatureMaster(fromCid)
    local pokemonMaster = getCreatureMaster(toCid)
    if Duel.getState(creatureMaster) == DuelStateBattle and Duel.getState(pokemonMaster) == DuelStateBattle then
      if Duel.getBattleId(creatureMaster) == Duel.getBattleId(pokemonMaster) then
        if Duel.getTeam(creatureMaster) == Duel.getTeam(pokemonMaster) then return end
      end
    end
  end
]]

DuelTypeSolo = 1
DuelTypeDuo = 2

DuelStateNone = 0
DuelStateTeam = 1
DuelStateSearch = 2
DuelStateBeginning = 3
DuelStateBattle = 4

DuelBasePsoul = 1

Duel = {}
Duel.base = DuelBasePsoul
Duel.opcode = 77
Duel.storage = {
  state = 951357, team = 951358, lastPosition = 951359, 
  winsSolo = 951360, winsDuo = 951361,
  losesSolo = 951362, losesDuo = 951363,
  drawsSolo = 951364, drawsDuo = 951365,
  pointsSolo = 951366, pointsDuo = 951367, 
  battleId = 951364
}
Duel.points = 10 -- Pontos ao ganhar, e ao perder.
Duel.timeToEnd = 60000 * 6 -- Tempo máximo do duelo
Duel.teams = {}
Duel.searching = {}
Duel.searching[DuelTypeSolo] = {}
Duel.searching[DuelTypeDuo] = {}
Duel.battles = {}
Duel.arenas = {}
Duel.arenas[1] = {
  pos = {
    [1] = {x = 4864, y = 102, z = 6}, -- lider do time 1
    [2] = {x = 4864, y = 103, z = 6}, -- parceiro do time 1
    [3] = {x = 4870, y = 102, z = 6}, -- lider time 2
    [4] = {x = 4870, y = 103, z = 6}, -- parceiro time 2
  },
  centerPos = {x = 4867, y = 102, z = 6}, -- Posição que vai aparecer o animatedText pra começar (5,4,3,2,1)
  inUse = false,
}
Duel.arenas[2] = {
  pos = {
    [1] = {x = 4905, y = 102, z = 6}, -- lider do time 1
    [2] = {x = 4905, y = 103, z = 6}, -- parceiro do time 1
    [3] = {x = 4910, y = 102, z = 6}, -- lider time 2
    [4] = {x = 4910, y = 103, z = 6}, -- parceiro time 2
  },
  centerPos = {x = 4867, y = 102, z = 6}, -- Posição que vai aparecer o animatedText pra começar (5,4,3,2,1)
  inUse = false,
}




function Duel.sendOpcode(cid, params)
  local buffer = {protocol = params.protocol}
  if params.protocol == "team" then
  buffer.team = params.team
    local leader = getPlayerByName(params.team.leader)
  buffer.team.leaderOutfit = getCreatureOutfit(leader)
    buffer.leaderWins = {solo = Duel.getWins(leader, DuelTypeSolo), duo = Duel.getWins(leader, DuelTypeDuo)}
    buffer.leaderLoses = {solo = Duel.getLoses(leader, DuelTypeSolo), duo = Duel.getLoses(leader, DuelTypeDuo)}
    buffer.leaderPoints = {solo = Duel.getPoints(leader, DuelTypeSolo), duo = Duel.getPoints(leader, DuelTypeDuo)}
  local partner = getPlayerByName(params.team.partner)
  buffer.team.partnerOutfit = getCreatureOutfit(partner)
    buffer.partnerWins = {solo = Duel.getWins(partner, DuelTypeSolo), duo = Duel.getWins(partner, DuelTypeDuo)}
    buffer.partnerLoses = {solo = Duel.getLoses(partner, DuelTypeSolo), duo = Duel.getLoses(partner, DuelTypeDuo)}
    buffer.partnerPoints = {solo = Duel.getPoints(partner, DuelTypeSolo), duo = Duel.getPoints(partner, DuelTypeDuo)}
  elseif params.protocol == "info" then
    buffer.name = getCreatureName(cid)
  buffer.outfit = getCreatureOutfit(cid)
    buffer.wins = {solo = Duel.getWins(cid, DuelTypeSolo), duo = Duel.getWins(cid, DuelTypeDuo)}
    buffer.loses = {solo = Duel.getLoses(cid, DuelTypeSolo), duo = Duel.getLoses(cid, DuelTypeDuo)}
    buffer.points = {solo = Duel.getPoints(cid, DuelTypeSolo), duo = Duel.getPoints(cid, DuelTypeDuo)}
  elseif params.protocol == "invite" then
    buffer.leader = params.leader
  elseif params.protocol == "searching" then
    buffer.dType = params.dType
  end
  doSendPlayerExtendedOpcode(cid, Duel.opcode, json.encode(buffer))
end

function Duel.invitePartner(cid, name)
  if Duel.getState(cid) >= DuelStateSearch then return end
  local partner = getPlayerByName(name)
  if not isPlayer(partner) then
    doPlayerPopupFYI(cid, "Esse jogador nao existe.")
  return
  end
  if Duel.getState(partner) ~= DuelStateNone then
    doPlayerPopupFYI(cid, "Esse jogador nao pode aceitar no momento.")
    return
  end
  Duel.sendOpcode(partner, {protocol = "invite", leader = getCreatureName(cid)})
  -- Mandar pro cliente o convite.
end

function Duel.acceptInvite(cid, name)
  if Duel.getState(cid) ~= DuelStateNone then return end
  local leader = getPlayerByName(name)
  if not isPlayer(leader) then
    doPlayerPopupFYI(cid, "Esse jogador nao existe.")
  return
  end
  if Duel.getState(leader) ~= DuelStateNone then
    doPlayerPopupFYI(cid, "Esse jogador esta em outro duelo.")
    return
  end
  local team = {leader = name, partner = getCreatureName(cid)}
  table.insert(Duel.teams, team)
  Duel.setState(leader, DuelStateTeam)
  Duel.setState(cid, DuelStateTeam)
  Duel.sendOpcode(cid, {protocol = "team", team = team})
  Duel.sendOpcode(leader, {protocol = "team", team = team})
end

function Duel.cancel(cid, removeDuo)
  local state = Duel.getState(cid)
  local name = getCreatureName(cid)
  if state == DuelStateTeam then
    Duel.setState(cid, DuelStateNone)
    for pos, team in pairs(Duel.teams) do
    if team.leader == name or team.partner == name then
      Duel.setState(getPlayerByName(team.leader), DuelStateNone)
      Duel.sendOpcode(getPlayerByName(team.leader), {protocol = "info"}) 
      Duel.setState(getPlayerByName(team.partner), DuelStateNone)
      Duel.sendOpcode(getPlayerByName(team.partner), {protocol = "info"})
    Duel.teams[pos] = nil
      break 
    end
  end
  elseif state == DuelStateSearch then
    local fns = true
    for pos, member in pairs(Duel.searching[DuelTypeSolo]) do
      if member == name then table.remove(Duel.searching[DuelTypeSolo], pos) break end
    end
    for pos, member in pairs(Duel.searching[DuelTypeDuo]) do
      if type(member) == 'table' then
        if member.leader == name or member.partner == name then
      if not removeDuo then
            local team = {leader = member.leader, partner = member.partner}
            table.insert(Duel.teams, team)
        local leader, partner = getPlayerByName(member.leader), getPlayerByName(member.partner)
            Duel.setState(leader, DuelStateTeam)
            Duel.setState(partner, DuelStateTeam)
            Duel.sendOpcode(leader, {protocol = "team", team = team})
            Duel.sendOpcode(partner, {protocol = "team", team = team})
      fns = false
      end
      table.remove(Duel.searching[DuelTypeDuo], pos)
      break
    end
      else
        if member == name then  table.remove(Duel.searching[DuelTypeDuo], pos) break end
      end
    end
  if fns then
      Duel.setState(cid, DuelStateNone)
      Duel.sendOpcode(cid, {protocol = "info"})
  end
  end
end

function Duel.search(cid, dType)
if(not getTileInfo(getCreaturePosition(cid)).protection) then
    doPlayerPopupFYI(cid, "Voce precisa estar em area PZ")
    return 
  end
  local state = Duel.getState(cid)
  if state > DuelStateTeam then return end
  local name = getCreatureName(cid)
  if state == DuelStateTeam then
    local searchTeam = nil
    for pos, team in pairs(Duel.teams) do
    if team.leader == name or team.partner == name then searchTeam = {leader = team.leader, partner = team.partner} break end
  end
  if not searchTeam then
    Duel.setState(cid, DuelStateNone)
    Duel.sendOpcode(cid, {protocol = "normalize"})
  return
  end
 -- print(searchTeam.leader, searchTeam.partner)
  local leader = getPlayerByName(searchTeam.leader)
  local partner = getPlayerByName(searchTeam.partner)
  Duel.setState(leader, DuelStateSearch)
  Duel.setState(partner, DuelStateSearch)
  Duel.sendOpcode(leader, {protocol = "searching", dType = DuelTypeDuo})
  Duel.sendOpcode(partner, {protocol = "searching", dType = DuelTypeDuo})
  table.insert(Duel.searching[DuelTypeDuo], searchTeam)
  else
    Duel.setState(cid, DuelStateSearch)
    Duel.sendOpcode(cid, {protocol = "searching", dType = dType})
    table.insert(Duel.searching[dType], getCreatureName(cid))
  end
  Duel.checkSearch(dType)
end

function Duel.checkSearch(dType)
  local members = {}
  if dType == DuelTypeSolo then
    for _, name in pairs(Duel.searching[DuelTypeSolo]) do
      if Duel.canDuel(getPlayerByName(name)) then
        table.insert(members, name)
        if #members == 2 then
          return Duel.start(DuelTypeSolo, members)
        end
      end
    end
  elseif dType == DuelTypeDuo then
    local players = 0
    for _, member in pairs(Duel.searching[DuelTypeDuo]) do
      if type(member) == 'table' and players <= 2 then
        if Duel.canDuel(getPlayerByName(member.leader)) and Duel.canDuel(getPlayerByName(member.partner)) then
          table.insert(members, member)
          players = players + 2
        end
      else
        if Duel.canDuel(getPlayerByName(member)) then
          table.insert(members, member)
          players = players + 1
        end
      end
      if players == 4 then
        Duel.start(DuelTypeDuo, members)
      end
    end
  end
end

function Duel.start(dType, members)
  local arenaId = Duel.getAvailableArena()
  if not arenaId then return end
  print(Duel.arenas[1].inUse, Duel.arenas[2].inUse)
  local arena = Duel.arenas[arenaId]
  local battle = {id = os.time(), dType = dType, teams = {[1] = {},[2] = {}}, arenaId = arenaId}
  if dType == DuelTypeSolo then
    for cnt, member in pairs(members) do
      for pos, name in pairs(Duel.searching[DuelTypeSolo]) do
        if member ~= name then table.remove(Duel.searching[DuelTypeSolo], pos) break end
      end
      Duel.beginningBattle(getPlayerByName(member), battle, arena.pos[cnt == 1 and 1 or 3])
      battle.teams[cnt] = {[1] = member}
    end
  elseif dType == DuelTypeDuo then
    local first = true
    for cnt, member in pairs(members) do
      if type(member) == 'table' then
        for pos, name in pairs(Duel.searching[DuelTypeDuo]) do
          if member.leader ~= name then table.remove(Duel.searching[DuelTypeDuo], pos) break end
        end
        for pos, name in pairs(Duel.searching[DuelTypeDuo]) do
          if member.partner ~= name then table.remove(Duel.searching[DuelTypeDuo], pos) break end
        end
        if #members == 2 then
          Duel.beginningBattle(getPlayerByName(member.leader), battle, arena.pos[cnt == 1 and 1 or 3])
          Duel.beginningBattle(getPlayerByName(member.partner), battle, arena.pos[cnt == 1 and 2 or 4])
          Duel.setTeam(getPlayerByName(member.leader), cnt)
          Duel.setTeam(getPlayerByName(member.partner), cnt)
          battle.teams[cnt] = {member.leader, member.partner}
        elseif #members == 3 then
          Duel.beginningBattle(getPlayerByName(member.leader), battle, arena.pos[1])
          Duel.beginningBattle(getPlayerByName(member.partner), battle, arena.pos[2])
          Duel.setTeam(getPlayerByName(member.leader), 1)
          Duel.setTeam(getPlayerByName(member.partner), 1)
          battle.teams[1] = {member.leader, member.partner}
        end
      else
        for pos, name in pairs(Duel.searching[DuelTypeDuo]) do
          if member ~= name then table.remove(Duel.searching[DuelTypeDuo], pos) break end
        end
        if #members == 3 then
          Duel.beginningBattle(getPlayerByName(member), battle, arena.pos[first and 3 or 4])
          first = false
          Duel.setTeam(getPlayerByName(member), 2)
      table.insert(battle.teams[2], member)
        else -- #members == 4
          Duel.beginningBattle(getPlayerByName(member), battle, arena.pos[cnt])
          Duel.setTeam(getPlayerByName(member), cnt <= 2 and 1 or 2)
      table.insert(battle.teams[math.ceil(cnt/2)], member)
        end
      end
    end
  end
  Duel.battles[battle.id] = battle
  local buffer = {protocol = "beginning", teams = {}, dType = dType}
  for teamId, team in ipairs(battle.teams) do
    buffer.teams[teamId] = {}
    for _, member in ipairs(team) do
      local duelist = getPlayerByName(member)
      buffer.teams[teamId][_] = {
        name = member,
        outfit = getCreatureOutfit(duelist),
        wins = Duel.getWins(duelist, dType),
        loses = Duel.getLoses(duelist, dType),
        points = Duel.getPoints(duelist, dType),
      }
    end
  end
  for teamId, team in ipairs(battle.teams) do
    for _, member in pairs(team) do
      local duelist = getPlayerByName(member)
      doSendPlayerExtendedOpcode(getPlayerByName(member), Duel.opcode, json.encode(buffer))
    end
  end
  arena.inUse = true
  addEvent(Duel.battle, 5000, battle.id)
end

function Duel.beginningBattle(duelist, battle, pos)
  if isPokemonOnline(duelist) then
    doPlayerUseBallOnSlot(duelist)
  end
  Duel.setBattleId(duelist, battle.id)
  Duel.setState(duelist, DuelStateBeginning)
  Duel.saveLastPosition(duelist)
  doTeleportThing(duelist, pos)
  doCreatureSetNoMove(duelist, true)
  addEvent(doCreatureSetNoMove, 5000, duelist, false)   
        -- 10s = 5 do atraso + 5 do dul start funcao daq 10s se n tiver duelando duel end popup avisando o pq
end

function Duel.battle(battleId)
  local battle = Duel.battles[battleId]
  if not battle then return end
  for teamId, team in ipairs(battle.teams) do
    for _, member in pairs(team) do
      local duelist = getPlayerByName(member)
      Duel.setState(duelist, DuelStateBattle)
      Duel.resetPokemonCount(duelist)
    end
  end
  if battle.dType == DuelTypeSolo then
    doPartyDuelInvite(getPlayerByName(battle.teams[1][1]), getPlayerByName(battle.teams[2][1]))
    doPartyDuelCreate(getPlayerByName(battle.teams[1][1]), 1, 6, 0)
    doPartyDuelInvite(getPlayerByName(battle.teams[1][1]), getPlayerByName(battle.teams[2][1]))
    doPartyDuelJoin(getPlayerByName(battle.teams[1][1]), getPlayerByName(battle.teams[2][1]))
  elseif battle.dType == DuelTypeDuo then
    doPartyDuelInvite(getPlayerByName(battle.teams[1][1]), getPlayerByName(battle.teams[2][1])) -- lider do time 1 chama lider do time 2
    doPartyDuelCreate(getPlayerByName(battle.teams[1][1]), 2, 6, 0)
    doPartyDuelInvite(getPlayerByName(battle.teams[1][1]), getPlayerByName(battle.teams[2][1])) -- lider do time 1 chama lider do time 2
    doPartyDuelJoin(getPlayerByName(battle.teams[1][1]), getPlayerByName(battle.teams[2][1])) -- lider do time 2 aceita
    doPartyDuelInvite(getPlayerByName(battle.teams[1][1]), getPlayerByName(battle.teams[1][2])) -- lider do time 2 chama parceiro do time 2
    doPartyDuelJoin(getPlayerByName(battle.teams[1][1]), getPlayerByName(battle.teams[1][2])) -- parceiro do time 2 aceita
    doPartyDuelInvite(getPlayerByName(battle.teams[2][1]), getPlayerByName(battle.teams[2][2])) -- lider do time 1 chama parceiro do time 1
    doPartyDuelJoin(getPlayerByName(battle.teams[2][1]), getPlayerByName(battle.teams[2][2])) -- parceiro aceita
  end
  local function check(bid)
    local battle = Duel.battles[bid]
    if not battle then return end
  local finish = false
    for teamId, team in ipairs(battle.teams) do
      for _, member in pairs(team) do
    if not isDueling(getPlayerByName(member)) then finish = true break end
    end
  if finish then Duel.endBattle(bid, true) end
  end -- vai dar bom confia willsmith
  end
  addEvent(check, 6000, battleId) -- 1s a + de proteçao kk provavel pq ele conta de 0 a 5 e n de 1 a 5
  addEvent(Duel.endBattle, Duel.timeToEnd, battleId)
  -- esse timer ja ta? s-- Colocar um timer pro duelo finalizar.
end

function Duel.endBattle(battleId, draw)
 -- print("duel.endbattle")
  local battle = Duel.battles[battleId]
  if not battle then print("not battle") return end
  local win = 0
  if not draw then
    -- Tempo acabou, verificar quem tem mais pokemons
    local pkmc = {[1] = 0,[2] = 0}
    for teamId, team in ipairs(battle.teams) do
      for _, member in pairs(team) do
        local duelist = getPlayerByName(member)
        pkmc[teamId] = pkmc[teamId] + getPlayerDuelPokemonRemaing(duelist)
        -- pkmc[teamId] = pkmc[teamId] + Duel.getPokemonCount(duelist)
      end
    end
    if pkmc[1] > pkmc[2] then
      win = 1
    elseif pkmc[2] < pkmc[1] then
      win = 2
    end
  end
 -- print("win: "..win)
  for teamId, team in ipairs(battle.teams) do
    for _, member in pairs(team) do
      local duelist = getPlayerByName(member)
      if win == 0 then Duel.addDraw(duelist, battle.dType)
      elseif teamId == win then Duel.addWin(duelist, battle.dType) Duel.addPoints(duelist, battle.dType)
      else Duel.addLose(duelist, battle.dType) Duel.removePoints(duelist, battle.dType)
      end
      Duel.setState(duelist, DuelStateNone)
      Duel.sendOpcode(duelist, {protocol = "info"})
      doTeleportThing(duelist, Duel.getLastPosition(duelist))
 --     print("endBattle: "..member)
    end
  end
--  print("finish")
  Duel.arenas[battle.arenaId].inUse = false
  Duel.battles[battleId] = nil
end

function Duel.canDuel(cid)
  -- Todas as verificações se o jogador pode duelar naquele momento(6xpokemons, posição, etc)
  if Duel.baseVersion == DuelBasePsoul then
    if #getPlayerAllBallsWithPokemon(cid) ~= 6 then return false end
    if isPokemonOnline(cid) then return false end
    if getTilePzInfo(getCreaturePosition(cid)) then return false end
    if getPlayerFrontierIsland(cid) then return false end
  end
  return true
end

function Duel.getAvailableArena()
  for arenaId, arena in ipairs(Duel.arenas) do
    if not arena.inUse then return arenaId end
  end
  return nil
end

function Duel.getPokemonCount(cid)
  return math.max(0, getPlayerStorageValue(cid, Duel.storage.pokemonCount))
end

function Duel.resetPokemonCount(cid)
  setPlayerStorageValue(cid, Duel.storage.pokemonCount, 6)
end

function Duel.decreasePokemonCount(cid)
  local pokemonCount = Duel.getPokemonCount(cid)
  setPlayerStorageValue(cid, Duel.storage.pokemonCount, pokemonCount - 1)
  if pokemonCount-1 == 0 then
    Duel.endBattle(Duel.getBattleId(cid))
  end
end

function Duel.getState(cid)
  return math.max(DuelStateNone, getPlayerStorageValue(cid, Duel.storage.state))
end

function Duel.setState(cid, state)
  setPlayerStorageValue(cid, Duel.storage.state, state)
end

function Duel.getTeam(cid)
  return math.max(1, getPlayerStorageValue(cid, Duel.storage.team))
end

function Duel.setTeam(cid, team)
  setPlayerStorageValue(cid, Duel.storage.team, team)
end

function Duel.getLastPosition(cid)
  return json.decode(getPlayerStorageValue(cid, Duel.storage.lastPosition))
end

function Duel.saveLastPosition(cid)
  setPlayerStorageValue(cid, Duel.storage.lastPosition, json.encode(getThingPos(cid)))
end

function Duel.getBattleId(cid)
  return getPlayerStorageValue(cid, Duel.storage.battleId)
end

function Duel.setBattleId(cid, battleId)
  setPlayerStorageValue(cid, Duel.storage.battleId, battleId)
end

function Duel.getPoints(cid, dType)
  return math.max(0, getPlayerStorageValue(cid, dType == DuelTypeSolo and Duel.storage.pointsSolo or Duel.storage.pointsDuo))
end

function Duel.addPoints(cid, dType)
  setPlayerStorageValue(cid, dType == DuelTypeSolo and Duel.storage.pointsSolo or Duel.storage.pointsDuo, Duel.getPoints(cid, dType) + Duel.points)
end

function Duel.removePoints(cid, dType)
  setPlayerStorageValue(cid, dType == DuelTypeSolo and Duel.storage.pointsSolo or Duel.storage.pointsDuo, Duel.getPoints(cid, dType) - Duel.points)
end

function Duel.getWins(cid, dType)
  return math.max(0, getPlayerStorageValue(cid, dType == DuelTypeSolo and Duel.storage.winsSolo or Duel.storage.winsDuo))
end

function Duel.addWin(cid, dType)
  setPlayerStorageValue(cid, dType == DuelTypeSolo and Duel.storage.winsSolo or Duel.storage.winsDuo, Duel.getWins(cid, dType) + 1)
end

function Duel.getLoses(cid, dType)
  return math.max(0, getPlayerStorageValue(cid, dType == DuelTypeSolo and Duel.storage.losesSolo or Duel.storage.losesDuo))
end

function Duel.addLose(cid, dType)
  setPlayerStorageValue(cid, dType == DuelTypeSolo and Duel.storage.losesSolo or Duel.storage.losesDuo, Duel.getLoses(cid, dType) + 1)
end

function Duel.getDraws(cid, dType)
  return math.max(0, getPlayerStorageValue(cid, dType == DuelTypeSolo and Duel.storage.drawsSolo or Duel.storage.drawsDuo))
end

function Duel.addDraw(cid, dType)
  setPlayerStorageValue(cid, dType == DuelTypeSolo and Duel.storage.drawsSolo or Duel.storage.drawsDuo, Duel.getDraws(cid, dType) + 1)
end

function Duel.onLogout(cid)
  local state = Duel.getState(cid)
  if state >= DuelStateBeginning then return false end
  Duel.cancel(cid, true)
  return true
end

function Duel.onReloadCreatureScripts()
  for pos, team in pairs(Duel.teams) do
    Duel.setState(getPlayerByName(team.leader), DuelStateNone)
    Duel.sendOpcode(getPlayerByName(team.leader), {protocol = "info"}) 
    Duel.setState(getPlayerByName(team.partner), DuelStateNone)
    Duel.sendOpcode(getPlayerByName(team.partner), {protocol = "info"})
  end
  for pos, member in pairs(Duel.searching[DuelTypeSolo]) do
    Duel.setState(getPlayerByName(member), DuelStateNone)
    Duel.sendOpcode(getPlayerByName(member), {protocol = "info"})
  end
  for pos, member in pairs(Duel.searching[DuelTypeDuo]) do
    if type(member) == 'table' then
      Duel.setState(getPlayerByName(member.leader), DuelStateNone)
      Duel.sendOpcode(getPlayerByName(member.leader), {protocol = "info"})
      Duel.setState(getPlayerByName(member.partner), DuelStateNone)
      Duel.sendOpcode(getPlayerByName(member.partner), {protocol = "info"})
    else
      Duel.setState(getPlayerByName(member), DuelStateNone)
      Duel.sendOpcode(getPlayerByName(member), {protocol = "info"})
    end
  end
end
local config = {
shallow = "no",
delay = 1,
events = 1
}

local savingEvent = 0

function onThink(interval, lastExecution, thinkInterval)
doBroadcastMessage("Saving server in 1 minute.")
addEvent(save, 60 * 1000)
return true
end

function save()
doSaveServer()
doBroadcastMessage("Server saved. Cleaned ".. doCleanMap() .." items.")
end
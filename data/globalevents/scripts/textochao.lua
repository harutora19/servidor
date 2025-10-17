local config = {
    positions = {
        ["Kit Inicial"] = { x = 1023, y = 1013, z = 7 },   
    }
}

function onThink(cid, interval, lastExecution)
    for text, pos in pairs(config.positions) do
        doSendAnimatedText(pos, text, math.random(1, 255))
    end
    return TRUE
end  
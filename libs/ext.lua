if not term.isColor() then
    colors.red = colors.lightGray
    colors.green = colors.lightGray
    colors.brown = colors.lightGray
    colors.blue = colors.lightGray
    colors.cyan = colors.lightGray
    colors.pink = colors.white
    colors.lime = colors.lightGray
    colors.yellow = colors.white
    colors.lightBlue = colors.white
    colors.magenta = colors.white
    colors.orange = colors.lightGray
end
table.contains = function(t, e)
    for _, v in pairs(t) do
        if v == e then return true end
    end
    return false
end
table.containsKey = function(t, key)
    for k, _ in pairs(t) do
        if k == key then return true end
    end
    return false
end
string.split = function(s, sep)
    local t = {}
    local temp = ""
    for i = 1, #s do
        local c = s:sub(i,i)
        if c == sep then
            if #temp > 0 then table.insert(t, temp) end
            temp = ""
        else if temp then temp = temp .. c else temp = c end end
    end
    if #temp > 0 then table.insert(t, temp) end
    return t
end
string.splits = function(s, seps)
    local t = {}
    local temp = ""
    for i = 1, #s do
        local c = s:sub(i,i)
        if table.contains(seps, c) then
            if #temp > 0 then table.insert(t, temp) end
            temp = ""
        else if temp then temp = temp .. c else temp = c end end
    end
    if #temp > 0 then table.insert(t, temp) end
    return t
end
string.splitKeep = function(s, sep)
    local t = {}
    local temp = ""
    for i = 1, #s do
        local c = s:sub(i,i)
        if c == sep then
            if #temp > 0 then table.insert(t, temp); table.insert(t, c) end
            temp = ""
        else if temp then temp = temp .. c else temp = c end end
    end
    if #temp > 0 then table.insert(t, temp) end
    return t
end
string.splitsKeep = function(s, seps)
    local t = {}
    local temp = ""
    for i = 1, #s do
        local c = s:sub(i,i)
        if table.contains(seps, c) then
            if #temp > 0 then table.insert(t, temp); table.insert(t, c) end
            temp = ""
        else if temp then temp = temp .. c else temp = c end end
    end
    if #temp > 0 then table.insert(t, temp) end
    return t
end
os.pullEventsRaw = function(events)
    while true do
        local event, p1, p2, p3, p4, p5, p6 = os.pullEventRaw()
        if table.contains(events, event) then return event, p1, p2, p3, p4, p5, p6 end
    end
end
os.pullEvents = function(events)
    while true do
        local event, p1, p2, p3, p4, p5, p6 = os.pullEvent()
        if table.contains(events, event) then return event, p1, p2, p3, p4, p5, p6 end
    end
end
rednet.receiveFrom = function(sender, timeout, protocol)
    local id, msg, prot
    local receive = function()
        while not (id == sender) do
            id, msg, prot = rednet.receive(protocol)
        end
    end
    local time = function()
        sleep(timeout)
    end
    parallel.waitForAny(receive, time)
    return msg
end
term.reset = function()
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.clear()
    term.setCursorPos(1, 1)
end
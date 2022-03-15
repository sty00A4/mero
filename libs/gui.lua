return {
    ---@param tag string
    ---@param x number
    ---@param y number
    ---@param w number
    ---@param h number
    ---@param fg number
    ---@param bg number
    ---@param on_click function
    ---@param key_alias number
    button = function(tag, x, y, w, h, fg, bg, on_click, key_alias, on_init)
        if not (type(tag) == "string") then error("expected string, got "..type(tag)) end
        if not (type(x) == "number" or type(x) == "string") then error("expected number or string, got "..type(x)) end
        if not (type(y) == "number" or type(y) == "string") then error("expected number or string, got "..type(y)) end
        if w then if not (type(w) == "number") then error("expected number, got "..type(w)) end
        else w = #tag-1 end
        if h then if not (type(h) == "number") then error("expected number, got "..type(h)) end
        else h = 0 end
        local W, H = term.getSize()
        if type(x) == "string" then if x == "center" then x = W/2 - w/2
                                    elseif x == "right" then x = W
        else error("unrecognized position "..x) end end
        if type(y) == "string" then if y == "center" then y = H/2 - h/2
                                    elseif y == "bottom" then y = H
        else error("unrecognized position "..y) end end
        if fg then if not (type(fg) == "number") then error("expected number, got "..type(fg)) end
        else fg = colors.white end
        if bg then if not (type(bg) == "number") then error("expected number, got "..type(bg)) end
        else bg = colors.gray end
        if on_click then if not (type(on_click) == "function") then error("expected function, got "..type(on_click)) end end
        if key_alias then if not (type(key_alias) == "number") then error("expected number, got "..type(key_alias)) end end
        return { type = "button", tag = tag, x = math.floor(x), y = math.floor(y), w = math.floor(w), h = math.floor(h),
                 fg = fg, bg = bg, on_click = on_click, key_alias = key_alias, draw = function(self)
                     paintutils.drawFilledBox(self.x, self.y, self.x + self.w, self.y + self.h, self.bg)
                     local _cx, _cy = term.getCursorPos()
                     term.setCursorPos(self.x + math.ceil(self.w/2 - #self.tag/2), self.y + math.floor(self.h/2))
                     local _txtcolor = term.getTextColor()
                     term.setTextColor(self.fg)
                     write(self.tag)
                     term.setTextColor(_txtcolor)
                     term.setCursorPos(_cx, _cy)
                 end, }
    end,
    ---@param text string
    ---@param x number
    ---@param y number
    ---@param w number
    ---@param h number
    ---@param fg number
    ---@param bg number
    ---@param wrapping boolean
    text = function(text, x, y, w, h, fg, bg, wrapping)
        if not (type(text) == "string") then error("expected string, got "..type(text)) end
        if not (type(x) == "number" or type(x) == "string") then error("expected number, got "..type(x)) end
        if not (type(y) == "number" or type(y) == "string") then error("expected number, got "..type(y)) end
        if w then if not (type(w) == "number") then error("expected number, got "..type(w)) end
        else w = #text-1 end
        if h then if not (type(h) == "number") then error("expected number, got "..type(h)) end
        else h = 0 end
        local W, H = term.getSize()
        if type(x) == "string" then if x == "center" then x = W/2 - w/2
                                    elseif x == "right" then x = W
        else error("unrecognized position "..x) end end
        if type(y) == "string" then if y == "center" then y = H/2 - h/2
                                    elseif y == "bottom" then y = H
        else error("unrecognized position "..y) end end
        if fg then if not (type(fg) == "number") then error("expected number, got "..type(fg)) end
        else fg = colors.white end
        if bg then if not (type(bg) == "number") then error("expected number, got "..type(bg)) end
        else bg = colors.black end
        return { type = "text", text = text, x = math.floor(x), y = math.floor(y), w = math.floor(w), h = math.floor(h),
                 fg = fg, bg = bg, wrapping = (wrapping == true),
                 draw = function(self)
                     paintutils.drawFilledBox(self.x, self.y, self.x + self.w, self.y + self.h, self.bg)
                     local _cx, _cy = term.getCursorPos()
                     term.setCursorPos(self.x, self.y)
                     local _txtcolor = term.getTextColor()
                     term.setTextColor(self.fg)
                     write(self.text)
                     term.setTextColor(_txtcolor)
                     term.setCursorPos(_cx, _cy)
                 end,}
    end,
    ---@param path string
    ---@param x number
    ---@param y number
    ---@param xCenter string
    ---@param yCenter string
    image = function(path, x, y, xCenter, yCenter)
        if not (type(path) == "string") then error("expected string, got "..type(path)) end
        if not (type(x) == "number" or type(x) == "string") then error("expected number or string, got " .. type(x)) end
        if not (type(y) == "number" or type(y) == "string") then error("expected number or string, got " .. type(y)) end
        local image = paintutils.loadImage(path)
        local h = #image
        local w = 0
        for i = 1, #image do if #image[i] > w then w = #image[i] end end
        local W, H = term.getSize()
        if type(x) == "string" then if x == "center" then x = W/2 - w/2
                                    elseif x == "right" then x = W
        else error("unrecognized position "..x) end end
        if type(y) == "string" then if y == "center" then y = H/2 - h/2
                                    elseif y == "bottom" then y = H
        end end
        if not (type(xCenter) == "string") then error("expected string, got "..type(xCenter)) end
        if not (type(yCenter) == "string") then error("expected string, got "..type(yCenter)) end
        if not (xCenter == "left" or xCenter == "middle" or xCenter == "right") then error("invalid center") end
        if not (yCenter == "top" or yCenter == "middle" or yCenter == "bottom") then error("invalid center") end
        return { type = "image", image = image, x = math.floor(x), y = math.floor(y), w = math.floor(w),
                 h = math.floor(h), xCenter = xCenter, yCenter = yCenter,
                 draw = function(self) paintutils.drawImage(self.image, self.x, self.y) end}
    end,
    ---@param list table
    ---@param x number
    ---@param y number
    ---@param w number
    ---@param h number
    ---@param fg number
    ---@param bg number
    list = function(list, x, y, w, h, fg, bg, scroll, emptyMsg, emptyMsgColor)
        if not (type(list) == "table") then error("expected table, got "..type(tag)) end
        if not (type(x) == "number" or type(x) == "string") then error("expected number or string, got "..type(x)) end
        if not (type(y) == "number" or type(y) == "string") then error("expected number or string, got "..type(y)) end
        if h then if not (type(h) == "number") then error("expected number, got "..type(h)) end
        else h = #list end
        h = h - 1
        if w then if not (type(w) == "number") then error("expected number, got "..type(w)) end
        else
            w = 0
            for i = 1, #list do if #list[i] > w then w = #list[1] end end
        end
        w = w - 1
        local W, H = term.getSize()
        if type(x) == "string" then if x == "center" then x = W/2 - w/2
                                    elseif x == "right" then x = W
        else error("unrecognized position "..x) end end
        if type(y) == "string" then if y == "center" then y = H/2 - h/2
                                    elseif y == "bottom" then y = H
        else error("unrecognized position "..y) end end
        if fg then if not (type(fg) == "number") then error("expected number, got "..type(fg)) end
        else fg = colors.white end
        if bg then if not (type(bg) == "number") then error("expected number, got "..type(bg)) end
        else bg = colors.gray end
        if scroll then if not (type(scroll) == "number") then error("expected number, got "..type(scroll)) end
        else scroll = 0 end
        if emptyMsg then if not (type(emptyMsg) == "string") then error("expected string, got "..type(emptyMsg)) end
        else emptyMsg = "" end
        if emptyMsgColor then if not (type(emptyMsgColor) == "number") then error("expected number, got "..type(emptyMsgColor)) end
        else emptyMsg = colors.gray end
        return { type = "list", list = list, x = math.floor(x), y = math.floor(y), w = math.floor(w), h = math.floor(h),
                 fg = fg, bg = bg, scroll = scroll, emptyMsg = emptyMsg, emptyMsgColor = emptyMsgColor,
                 draw = function(self)
                     paintutils.drawFilledBox(self.x, self.y, self.x + self.w, self.y + self.h, self.bg)
                     local _cx, _cy = term.getCursorPos()
                     local _txtcolor = term.getTextColor()
                     term.setTextColor(self.fg)
                     if self.list then
                         for i = 1, self.h+1 do
                             term.setCursorPos(self.x, self.y + i - 1)
                             if self.list[i + self.scroll] then
                                 if #tostring(self.list[i + self.scroll]) <= self.w then
                                     write(tostring(self.list[i + self.scroll]))
                                 else
                                     write(tostring(self.list[i + self.scroll]):sub(1, self.w+1))
                                 end
                             end
                         end
                     else
                         term.setTextColor(self.emptyMsgColor)
                         term.setCursorPos(self.x, self.y)
                         write(self.emptyMsg)
                         term.setTextColor(self.fg)
                     end
                     term.setCursorPos(self.x, self.y + self.h)
                     term.setTextColor(_txtcolor)
                     term.setCursorPos(_cx, _cy)
                 end, }
    end,
    ---@param x number
    ---@param y number
    ---@param w number
    ---@param h number
    ---@param fg number
    ---@param bg number
    ---@param selected boolean
    ---@param standard string
    textInput = function(x, y, w, h, fg, bg, selected, standard)
        if not (type(x) == "number" or type(x) == "string") then error("expected number or string, got "..type(x)) end
        if not (type(y) == "number" or type(y) == "string") then error("expected number or string, got "..type(y)) end
        if w then if not (type(w) == "number") then error("expected number, got "..type(w)) end
        else w = 10 end
        h = 0 --- maybe change later
        local W, H = term.getSize()
        if type(x) == "string" then if x == "center" then x = W/2 - w/2
                                    elseif x == "right" then x = W
        else error("unrecognized position "..x) end end
        if type(y) == "string" then if y == "center" then y = H/2 - h/2
                                    elseif y == "bottom" then y = H
        else error("unrecognized position "..y) end end
        if fg then if not (type(fg) == "number") then error("expected number, got "..type(fg)) end
        else fg = colors.white end
        if bg then if not (type(bg) == "number") then error("expected number, got "..type(bg)) end
        else bg = colors.gray end
        selected = (selected == true)
        if not standard then standard = "" end
        return { type = "textInput", x = math.floor(x), y = math.floor(y), w = math.floor(w), h = math.floor(h),
                 fg = fg, bg = bg, input = standard, selected = selected,
                 draw = function(self, elements)
                     paintutils.drawFilledBox(self.x, self.y, self.x + self.w, self.y + self.h, self.bg)
                     local _cx, _cy = term.getCursorPos()
                     term.setCursorPos(self.x, self.y)
                     local _txtcolor = term.getTextColor()
                     term.setTextColor(self.fg)
                     if #self.input > self.w then
                         write(self.input:sub(#self.input-self.w+1))
                     else
                         write(self.input)
                     end
                     term.setTextColor(_txtcolor)
                     term.setCursorPos(_cx, _cy)
                 end}
    end,
    ---@param elements table
    ---@param pages table
    drawElements = function(elements, pages) for label, e in pairs(elements) do e.draw(e, elements, pages) end end,
    ---@param elements table
    cursorBlinking = function(elements)
        for label, e in pairs(elements) do
            if e.type == "textInput" then
                if e.selected then
                    if #e.input > e.w then
                        term.setCursorPos(e.x + e.w, e.y)
                    else
                        term.setCursorPos(e.x + #e.input, e.y)
                    end
                    term.setCursorBlink(true)
                end
            end
        end
    end,
    ---@param elements table
    ---@param pages table
    ---@param char string
    charEvent = function(elements, pages, char)
        for label, e in pairs(elements) do
            if e.type == "textInput" then
                if e.selected then
                    e.input = e.input .. char
                end
            end
        end
        return elements, pages
    end,
    ---@param elements table
    ---@param pages table
    ---@param key number
    keyEvent = function(elements, pages, key)
        for label, e in pairs(elements) do
            if e.type == "textInput" then
                if key == keys.backspace then
                    if e.selected then if #e.input > 0 then e.input = e.input:sub(1, #e.input-1) end end
                end
                if key == keys.enter then
                    e.selected = false
                end
            end
            if e.type == "button" then
                if e.key_alias == key then elements, pages = e.on_click(e, elements, pages) end
            end
        end
        return elements, pages
    end,
    ---@param elements table
    ---@param pages table
    ---@param mb number
    ---@param mx number
    ---@param my number
    mouseClick = function(elements, pages, mb, mx, my)
        for label, e in pairs(elements) do
            if e.type == "button" then
                if (mx >= e.x and mx <= e.x + e.w) and (my >= e.y and my <= e.y + e.h) then
                    if mb == 1 then elements, pages = e.on_click(e, elements, pages) end
                end
            end
            if e.type == "textInput" then
                if (mx >= e.x and mx <= e.x + e.w) and (my >= e.y and my <= e.y + e.h) then
                    if mb == 1 then e.selected = true end
                else
                    if mb == 1 then e.selected = false end
                end
            end
        end
        return elements, pages
    end,
    ---@param elements table
    ---@param pages table
    ---@param dir number
    ---@param mx number
    ---@param my number
    mouseScroll = function(elements, pages, dir, mx, my)
        for label, e in pairs(elements) do
            if e.type == "list" then
                if (mx >= e.x and mx <= e.x + e.w) and (my >= e.y and my <= e.y + e.h) then
                    e.scroll = e.scroll + dir
                    if e.scroll > #e.list - e.h - 1 then e.scroll = #e.list - e.h - 1 end
                    if e.scroll < 0 then e.scroll = 0 end
                end
            end
        end
        return elements, pages
    end,
    ---@param start string
    ---@param pages table
    run = function(start, pages)
        if start and pages then
            local elements = pages[start]
            while true do
                -- reset
                term.setBackgroundColor(colors.black)
                term.clear()
                term.setCursorPos(1, 1)
                -- draw elements
                gui.drawElements(elements, pages)
                -- input
                gui.cursorBlinking(elements)
                local event, p1, p2, p3 = os.pullEventsRaw({ "terminate", "key", "char", "mouse_click", "mouse_scroll", "rednet_message" })
                term.setCursorBlink(false)
                -- input handling
                if event == "terminate" then error("terminated") end
                if event == "mouse_click" then elements, pages = gui.mouseClick(elements, pages, p1, p2, p3) end
                if event == "mouse_scroll" then elements, pages = gui.mouseScroll(elements, pages, p1, p2, p3) end
                if event == "key" then elements, pages = gui.keyEvent(elements, pages, p1) end
                if event == "char" then elements, pages = gui.charEvent(elements, pages, p1) end
            end
            return true
        else
            pages = {
                ["main"] = {
                    ["error"] = gui.text("no page found :/", "center", "center", nil, nil, colors.red, colors.black)
                }
            }
            gui.drawElements("main", pages)
            os.pullEventsRaw({"mouse_click", "key"})
            return false
        end
    end
}
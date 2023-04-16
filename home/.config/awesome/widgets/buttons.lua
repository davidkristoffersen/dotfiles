-- Global
local awful = require('awful')

-- Config
local join_keys = require('helpers.keycode.funcs').join_keys
local S = require('helpers.keycode.combinations.strings')


local taglist_buttons = join_keys{
    [S._.b_left] = function (t) t:view_only() end,
    [S.m.b_left] = function (t) if client.focus then client.focus:move_to_tag(t) end end,
    [S._.b_right] = awful.tag.viewtoggle,
    [S.m.b_right] = function (t) if client.focus then client.focus:toggle_tag(t) end end,
    [S._.b_up] = function (t) awful.tag.viewnext(t.screen) end,
    [S._.b_down] = function (t) awful.tag.viewprev(t.screen) end,
}

local tasklist_buttons = join_keys{
    [S._.b_left] = function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal('request::activate', 'tasklist', {raise = true})
        end
    end,
    [S._.b_right] = function () awful.menu.client_list{theme = {width = 250}} end,
    [S._.b_up] = function () awful.client.focus.byidx(1) end,
    [S._.b_down] = function () awful.client.focus.byidx(-1) end,
}


return {
    taglist_buttons = taglist_buttons,
    tasklist_buttons = tasklist_buttons,
}

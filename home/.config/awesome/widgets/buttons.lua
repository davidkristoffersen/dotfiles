-- Global
local awful = require('awful')

-- Config
local join_keys = require('helpers.keycode.funcs').join_keys
local S = require('helpers.keycode.combinations.strings')
local emit = require('helpers.signal.emitters.client')


--- @type { [string]: KeyCb<Tag> }
local taglist_table = {
    [S._.b_left] = function (t) t:view_only() end,
    [S.m.b_left] = function (t) if client.focus then client.focus:move_to_tag(t) end end,
    [S._.b_right] = awful.tag.viewtoggle,
    [S.m.b_right] = function (t) if client.focus then client.focus:toggle_tag(t) end end,
    [S._.b_up] = function (t) awful.tag.viewnext(t.screen) end,
    [S._.b_down] = function (t) awful.tag.viewprev(t.screen) end,
}

--- @type { [string]: KeyCb<Client?> }
local tasklist_table = {
    [S._.b_left] = function (c)
        if c == client.focus then
            c.minimized = true
        else
            emit.request.activate(c, 'tasklist', {raise = true})
        end
    end,
    [S._.b_right] = function () awful.menu.client_list{theme = {width = 250}} end,
    [S._.b_up] = function () awful.client.focus.byidx(1) end,
    [S._.b_down] = function () awful.client.focus.byidx(-1) end,
}

local taglist_buttons = join_keys(taglist_table)
local tasklist_buttons = join_keys(tasklist_table)

return {
    taglist_buttons = taglist_buttons,
    tasklist_buttons = tasklist_buttons,
}
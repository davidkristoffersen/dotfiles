-- Global
local awful = require('awful')

-- Config
local menus = require('shared_state.init').menus


--- @type { [string]: KeyCb }
local _root = {
    toggle = {
        function () menus.main:toggle() end,
        {description = 'Toggle main menu', group = 'mouse'},
    },
    next = {awful.tag.viewnext, {description = 'View next tag', group = 'mouse'}},
    prev = {awful.tag.viewprev, {description = 'View previous tag', group = 'mouse'}},
}

--- @type { [string]: KeyCb<Client> }
local _client = {
    focus = {
        f = function (c) c:emit_signal('request::activate', 'mouse_click', {raise = true}) end,
        {description = 'Focus', group = 'mouse'},
    },
    move = {
        f = function (c)
            c:emit_signal('request::activate', 'mouse_click', {raise = true})
            awful.mouse.client.move(c)
        end,
        {description = 'Move', group = 'mouse'},
    },
    resize = {
        f = function (c)
            c:emit_signal('request::activate', 'mouse_click', {raise = true})
            awful.mouse.client.resize(c)
        end,
        {description = 'Resize', group = 'mouse'},
    },
}


return {
    root = _root,
    client = _client,
}

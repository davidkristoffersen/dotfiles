local awful = require('awful')

local main = require('menus.init').main

local _root = {
    toggle = {
        function () main:toggle() end,
        {description = 'Toggle main menu', group = 'mouse'},
    },
    next = {awful.tag.viewnext, {description = 'View next tag', group = 'mouse'}},
    prev = {awful.tag.viewprev, {description = 'View previous tag', group = 'mouse'}},
}

local _client = {
    focus = {
        function (c) c:emit_signal('request::activate', 'mouse_click', {raise = true}) end,
        {description = 'Focus', group = 'mouse'},
    },
    move = {
        function (c)
            c:emit_signal('request::activate', 'mouse_click', {raise = true})
            awful.mouse.client.move(c)
        end,
        {description = 'Move', group = 'mouse'},
    },
    resize = {
        function (c)
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

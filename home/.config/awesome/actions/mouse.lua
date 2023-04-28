-- Global
local awful = require('awful')

-- Config
local menus = require('shared_state.init').menus
local emit = require('helpers.signal.emitters.client')


--- @type { [string]: InnerKeyCb }
local _root = {
    toggle = {
        function () menus.main:toggle() end,
        {description = 'Toggle main menu', group = 'mouse'},
    },
    next = {awful.tag.viewnext, {description = 'View next tag', group = 'mouse'}},
    prev = {awful.tag.viewprev, {description = 'View previous tag', group = 'mouse'}},
}

--- @type { [string]: InnerKeyCb<Client> }
local _client = {
    focus = {
        f = function (c) emit.request.activate(c, 'mouse_click', {raise = true}) end,
        {description = 'Focus', group = 'mouse'},
    },
    move = {
        f = function (c)
            emit.request.activate(c, 'mouse_click', {raise = true})
            awful.mouse.client.move(c)
        end,
        {description = 'Move', group = 'mouse'},
    },
    resize = {
        f = function (c)
            emit.request.activate(c, 'mouse_click', {raise = true})
            awful.mouse.client.resize(c)
        end,
        {description = 'Resize', group = 'mouse'},
    },
}


return {
    root = _root,
    client = _client,
}

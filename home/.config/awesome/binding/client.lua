local awful   = require('awful')
local gears   = require('gears')

local binding = require('util.binding.init')
local M, K, B = binding.mod, binding.key, binding.bind
local key     = binding.funcs.set_key

local modkey  = M.m[1]


local keys = gears.table.join(
    key(B.m.f, function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, 'toggle fullscreen', 'client'),
    key(B.ms.c, function (c) c:kill() end, 'close', 'client'),
    key(B.mc.space, awful.client.floating.toggle,
        'toggle floating', 'client'),
    key(B.mc.return_, function (c) c:swap(awful.client.getmaster()) end,
        'move to master', 'client'),
    key(B.m.o, function (c) c:move_to_screen() end,
        'move to screen', 'client'), -- Move to next/previous screen
    awful.key(
        {modkey, 'Mod1'}, 'Right',
        function (c) c:move_to_screen(c.screen.index + 1) end, {
            description = 'move to next screen',
            group = 'client',
        }
    ), awful.key(
        {modkey, 'Mod1'}, 'Left',
        function (c) c:move_to_screen(c.screen.index - 1) end, {
            description = 'move to previous screen',
            group = 'client',
        }
    ), awful.key(
        {modkey}, 't', function (c) c.ontop = not c.ontop end, {
            description = 'toggle keep on top',
            group = 'client',
        }
    ), awful.key(
        {modkey}, 'n', function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end, {description = 'minimize', group = 'client'}
    ), awful.key(
        {modkey}, 'm', function (c)
            c.maximized = not c.maximized
            c:raise()
        end, {description = '(un)maximize', group = 'client'}
    ), awful.key(
        {modkey, 'Control'}, 'm', function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, {description = '(un)maximize vertically', group = 'client'}
    ), awful.key(
        {modkey, 'Shift'}, 'm', function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, {description = '(un)maximize horizontally', group = 'client'}
    )
)

return {
    keys = keys,
}

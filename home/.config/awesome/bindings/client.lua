local awful   = require('awful')
local gears   = require('gears')

local binding = require('helpers.binding.init')
local B, key  = binding.bind, binding.funcs.set_key

local cc      = require('awful.client')
local tt      = require('awful.tag')


print(client.size_hints)

-- local show_tag_by_numrow_index = awful.key{
--     modifiers = {'Mod4'},
--     keygroup = awful.key.keygroup.NUMROW,
--     description = 'only view tag',
--     group = 'tag',
--     on_press = function (index)
--         local screen = awful.screen.focused()
--         local tag = screen.tags[index]
--         if tag then
--             tag:view_only()
--         end
--     end,
-- }



-- ---@param c client
-- ff = function (c)
--     c.fullscreen = not c.fullscreen
--     local t = c:struts()
--     t.bottom
-- end


local keys = gears.table.join(
-- Toggling
    key(B.m.f, function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, 'toggle fullscreen', 'client'),
    key(B.mc.space, awful.client.floating.toggle,
        'toggle floating', 'client'),
    key(B.ms.c, function (c) c:kill() end, 'close', 'client'),
    key(B.m.t, function (c) c.ontop = not c.ontop end,
        'toggle keep on top', 'client'),

    -- Moving
    key(B.mc.return_, function (c) c:swap(awful.client.getmaster()) end,
        'move to master', 'client'),
    key(B.m.o, function (c) c:move_to_screen() end,
        'move to screen', 'client'), -- Move to next/previous screen
    key(B.ma.right, function (c) c:move_to_screen(c.screen.index + 1) end,
        'move to next screen', 'client'),
    key(B.ma.left, function (c) c:move_to_screen(c.screen.index - 1) end,
        'move to previous screen', 'client'),

    -- Resizing
    key(B.m.n, function (c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end, 'minimize', 'client'),
    key(B.m.m, function (c)
        c.maximized = not c.maximized
        c:raise()
    end, '(un)maximize', 'client'),
    key(B.mc.m, function (c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end, '(un)maximize vertically', 'client'),
    key(B.ms.m, function (c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end, '(un)maximize horizontally', 'client')
)

return {
    keys = keys,
}

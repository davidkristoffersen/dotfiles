-- Global
local awful = require('awful')


-- Toggling
--- @type { [string]: InnerKeyCb<Client> }
local toggle = {
    fullscreen = {
        f = function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {'toggle fullscreen', 'client'},
    },
    floating = {awful.client.floating.toggle, {'toggle floating', 'client'}},
    close = {f = function (c) c:kill() end, {'close', 'client'}},
    keep_on_top = {
        f = function (c) c.ontop = not c.ontop end,
        {'toggle keep on top', 'client'},
    },
}

-- Moving
--- @type { [string]: InnerKeyCb<Client> }
local move = {
    to_master = {
        f = function (c) c:swap(awful.client.getmaster()) end,
        {'move to master', 'client'},
    },
    -- Move to next/previous screen
    to_screen = {
        f = function (c) c:move_to_screen() end,
        {'move to screen', 'client'},
    },
    to_next_screen = {
        f = function (c) c:move_to_screen(c.screen.index + 1) end,
        {'move to next screen', 'client'},
    },
    to_previous_screen = {
        f = function (c) c:move_to_screen(c.screen.index - 1) end,
        {'move to previous screen', 'client'},
    },
}

-- Resizing
--- @type { [string]: InnerKeyCb<Client> }
local resize = {
    minimize = {
        f = function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {'minimize', 'client'},
    },
    maximize = {
        f = function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {'(un)maximize', 'client'},
    },
    maximize_vertically = {
        f = function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        {'(un)maximize vertically', 'client'},
    },
    maximize_horizontally = {
        f = function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        {'(un)maximize horizontally', 'client'},
    },
}


return {
    toggle = toggle,
    move = move,
    resize = resize,
}

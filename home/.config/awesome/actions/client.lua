local awful = require("awful")

-- Toggling
local toggle = {
    fullscreen = {
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { "toggle fullscreen", "client" },
    },
    floating = { awful.client.floating.toggle, { "toggle floating", "client" } },
    close = {
        function(c)
            c:kill()
        end,
        { "close", "client" },
    },

    keep_on_top = {
        function(c)
            c.ontop = not c.ontop
        end,
        { "toggle keep on top", "client" },
    },
}

-- Moving
local move = {
    to_master = {
        function(c)
            c:swap(awful.client.getmaster())
        end,
        { "move to master", "client" },
    },
    -- Move to next/previous screen
    to_screen = {
        function(c)
            c:move_to_screen()
        end,
        { "move to screen", "client" },
    },
    to_next_screen = {
        function(c)
            c:move_to_screen(c.screen.index + 1)
        end,
        { "move to next screen", "client" },
    },
    to_previous_screen = {
        function(c)
            c:move_to_screen(c.screen.index - 1)
        end,
        { "move to previous screen", "client" },
    },
}

-- Resizing
local resize = {
    minimize = {
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        { "minimize", "client" },
    },
    maximize = {
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { "(un)maximize", "client" },
    },
    maximize_vertically = {
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        { "(un)maximize vertically", "client" },
    },
    maximize_horizontally = {
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        { "(un)maximize horizontally", "client" },
    },
}

return {
    toggle = toggle,
    move = move,
    resize = resize,
}

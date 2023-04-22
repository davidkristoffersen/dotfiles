local awful = require('awful')


--- Handles the appearance of a new client.
--- Ensures that new clients are visible on screen and not maximized (if not during startup).
--- @param c Client
local function client_appears(c)
    -- If the client appears during the awesome startup, ensure it is not placed offscreen.
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end

    -- If the client appears after startup, set it to not be maximized.
    if not awesome.startup then
        c.maximized = false
    end
end

client.connect_signal('manage', client_appears)

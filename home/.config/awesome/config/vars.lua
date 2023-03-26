local l = require('awful.layout.suit')

-- Tag names
local names = {'1', '2', '3', '4', '5', '6', '7', '8', '9'}

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts = {
    l.tile,
    l.floating,
    l.tile.left,
    l.tile.bottom,
    l.tile.top,
    l.fair,
    l.fair.horizontal,
    l.spiral,
    l.spiral.dwindle,
    l.max,
    l.max.fullscreen,
    l.magnifier,
    l.corner.nw,
    -- l.corner.ne,
    -- l.corner.sw,
    -- l.corner.se,
}

-- Default theme
local theme = 'default'

-- Default modkey
local mod = 'Mod4'

return {
    names = names,     -- Tag names
    layouts = layouts, -- Table of layouts to cover with awful.layout.inc
    theme = theme,     -- Default theme
    mod = mod,         -- Default modkey
}

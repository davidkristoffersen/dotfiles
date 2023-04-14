-- Global
local awful = require('awful')
local naughty = require('naughty')
local l = require('awful.layout.suit')


--[[
    Laouts
--]]
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

-- Set awesome layouts
awful.layout.layouts = layouts

--[[
    Theme
--]]
-- Default theme
local theme = 'default'

-- Set the default font size for notifications
naughty.config.defaults.font = 'sans 20'

--- Hotkeys popup styling
local hotkeys_style = {
    font = 'sans 18',
    description_font = 'sans 14',
    screen_ratio = 0.8,
}

--[[
    Modifier keys
--]]
local M = 'Mod4' -- Default modkey

local C = 'Control'
local S = 'Shift'
local A = 'Mod1'
local N = ''

--- ### Description
--- Modifier names
--- ### Combinations
--- - One: `m`, `c`, `s`, `a`
--- - Two: `mc`, `ms`, `ma`, `cs`, `ca`, `sa`
--- - Three: `mcs`, `mca`, `msa`, `csa`
--- - All: `mcsa`
--- @class Modifiers
local Modifiers = {
    m = M, -- Modkey
    c = C, -- Control
    s = S, -- Shift
    a = A, -- Alt
    n = N, -- No mod
}


return {
    names = names,                 -- Tag names
    layouts = layouts,             -- Table of layouts to cover with awful.layout.inc
    theme = theme,                 -- Default theme
    hotkeys_style = hotkeys_style, -- Hotkeys popup styling
    mods = Modifiers,
}

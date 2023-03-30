local beautiful = require('beautiful')

local paths = require('config.paths')
local theme = require('config.vars').theme


--- Initialize a theme
local function init(name)
    -- Themes define colours, icons, font and wallpapers.
    beautiful.init(paths.themes .. '/' .. name .. '/theme.lua')
end

init(theme)

local paths = require('config.paths')

-- Theme handling library
local beautiful = require('beautiful')


--- Initialize a theme
---@param name string
local function init(name)
    -- Themes define colours, icons, font and wallpapers.
    beautiful.init(paths.themes .. '/' .. name .. '/theme.lua')
end


return {
    init = init,
}

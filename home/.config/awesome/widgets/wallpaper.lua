-- Global
local gears = require('gears')
local beautiful = require('beautiful')

-- Config
local signal = require('helpers.signal.constants.screen')
local connect = require('helpers.signal.connecters').screen


--- Set wallpaper
---
--- @param s Screen
local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == 'function' then wallpaper = wallpaper(s) end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

connect(signal.property.geometry, set_wallpaper)


return {
    set_wallpaper = set_wallpaper,
}

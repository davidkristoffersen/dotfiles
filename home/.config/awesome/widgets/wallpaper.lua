-- Global
local gears = require('gears')
local beautiful = require('beautiful')

-- Local
local connect = require('signals.connecters').screen


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

connect('property::geometry', set_wallpaper)


return {
    set_wallpaper = set_wallpaper,
}

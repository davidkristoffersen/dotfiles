-- Local
require('themes.default.vars')
local parts = require('themes.default.parts')


--- ### Description
--- The Theme class combines various theme-related components to create a complete theme for AwesomeWM.
--- @class Theme: ThemeStyle, ThemeTags, ThemeNotification, ThemeMenu, ThemeTitlebar, ThemeIcons, ThemeWallpaper
---
--- ---
--- @see ThemeParts
local theme = {}
for _, part in pairs(parts) do
    for k, v in pairs(part) do
        theme[k] = v
    end
end


return theme

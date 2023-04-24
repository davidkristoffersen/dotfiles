-- Global
local t_assets = require('beautiful.theme_assets')

-- Local
local menu = require('themes.default.menu')
local style = require('themes.default.style')
local assets = require('themes.default.vars').assets


--- @class ThemeIcons
local icons = {}

local layout_p = assets .. '/layouts/'
local layout_icon_names = {
    'fairh',
    'fairv',
    'floating',
    'magnifier',
    'max',
    'fullscreen',
    'tilebottom',
    'tileleft',
    'tile',
    'tiletop',
    'spiral',
    'dwindle',
    'cornernw',
    'cornerne',
    'cornersw',
    'cornerse',
}

for _, layout in ipairs(layout_icon_names) do
    icons['layout_' .. layout] = layout_p .. layout .. 'w.png'
end

--- Generate Awesome icon:
icons.awesome_icon = t_assets.awesome_icon(
    menu.menu_height, style.bg_focus, style.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
icons.icon_theme = nil


return icons

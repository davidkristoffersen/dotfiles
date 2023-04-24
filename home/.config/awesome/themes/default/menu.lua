-- Global
local xres = require('beautiful.xresources')

-- Local
local assets = require('themes.default.vars').assets


--- @class ThemeMenu
local menu = {}
local dpi = xres.apply_dpi

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
menu.menu_submenu_icon = assets .. '/submenu.png'
menu.menu_height = dpi(15)
menu.menu_width = dpi(100)


return menu

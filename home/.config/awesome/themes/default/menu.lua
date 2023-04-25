-- Global
local xres = require('beautiful.xresources')

-- Local
local assets = require('themes.default.vars').assets


--- @type BeautifulConfigMenuPart
local t = {__part_prefix = 'menu_'}
local dpi = xres.apply_dpi

t.submenu_icon = assets .. '/submenu.png'
t.height = dpi(15)
t.width = dpi(100)


return t

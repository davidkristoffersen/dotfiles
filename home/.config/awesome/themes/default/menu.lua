-- Global
local xres = require('beautiful.xresources')

-- Local
local assets = require('themes.default.vars').assets


--- @type BeautifulConfigMenuPart
local t = {__part_prefix = 'menu_'}
local dpi = xres.apply_dpi

t.submenu_icon = assets .. '/submenu.png'
t.height = dpi(30)
t.width = dpi(250)


return t

-- Global
local xres = require('beautiful.xresources')
local t_assets = require('beautiful.theme_assets')

-- Local
local assets = require('themes.default.vars').assets
local menu = require('themes.default.menu')


--- @type BeautifulConfigGeneral
local t = {__part_prefix = ''}
local dpi = xres.apply_dpi

t.font = 'sans 14'

t.bg_normal = '#222222'
t.bg_focus = '#535d6c'
t.bg_urgent = '#ff0000'
t.bg_minimize = '#444444'
t.bg_systray = t.bg_normal

t.fg_normal = '#aaaaaa'
t.fg_focus = '#ffffff'
t.fg_urgent = '#ffffff'
t.fg_minimize = '#ffffff'

t.border_normal = '#303030'
t.border_focus = '#a64d00'
t.border_marked = '#a64d00'
t.useless_gap = dpi(5)
t.border_width = dpi(2)

t.wallpaper = assets .. '/background.png'

--- Generate Awesome icon:
t.awesome_icon = t_assets.awesome_icon(
    menu.height, t.bg_focus, t.fg_focus
)
-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
t.icon_theme = nil


return t

-- Global
local xres = require('beautiful.xresources')


--- @class ThemeStyle
local style = {}
local dpi = xres.apply_dpi

style.font = 'sans 14'

style.bg_normal = '#222222'
style.bg_focus = '#535d6c'
style.bg_urgent = '#ff0000'
style.bg_minimize = '#444444'
style.bg_systray = style.bg_normal

style.fg_normal = '#aaaaaa'
style.fg_focus = '#ffffff'
style.fg_urgent = '#ffffff'
style.fg_minimize = '#ffffff'

style.border_normal = '#303030'
style.border_focus = '#a64d00'
style.border_marked = '#a64d00'
style.useless_gap = dpi(5)
style.border_width = dpi(2)


return style

-- Global
local t_assets = require('beautiful.theme_assets')
local xres = require('beautiful.xresources')

-- Local
local general = require('themes.default.general')


--- @type BeautifulConfigTaglistPart
local t = {__part_prefix = 'taglist_'}
local dpi = xres.apply_dpi

-- Generate taglist squares:
local tl_square_size = dpi(4)

t.squares_sel = t_assets.taglist_squares_sel(tl_square_size, general.fg_normal)
t.squares_unsel = t_assets.taglist_squares_unsel(tl_square_size, general.fg_normal)


return t

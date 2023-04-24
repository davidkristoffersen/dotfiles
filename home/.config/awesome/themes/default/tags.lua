-- Global
local t_assets = require('beautiful.theme_assets')
local xres = require('beautiful.xresources')

-- Local
local style = require('themes.default.style')


--- @class ThemeTags
local tags = {}
local dpi = xres.apply_dpi

-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
-- theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local tl_square_size = dpi(4)

tags.taglist_squares_sel = t_assets.taglist_squares_sel(tl_square_size, style.fg_normal)
tags.taglist_squares_unsel = t_assets.taglist_squares_unsel(tl_square_size, style.fg_normal)


return tags

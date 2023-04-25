-- Local
local assets = require('themes.default.vars').assets


--- @type BeautifulConfigLayoutPart
local t = {__part_prefix = 'layout_'}

local layout_p = assets .. '/layouts/'
local icon_names = {
    'fairh', 'fairv',
    'floating',
    'magnifier',
    'max', 'fullscreen',
    'tilebottom', 'tileleft', 'tile', 'tiletop',
    'spiral', 'dwindle',
    'cornernw', 'cornerne', 'cornersw', 'cornerse',
}

for _, layout in ipairs(icon_names) do
    t[layout] = layout_p .. layout .. 'w.png'
end


return t

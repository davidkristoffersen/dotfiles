-- Local
require('themes.default.vars')
local parts = require('themes.default.parts')


--- @type BeautifulConfig
local theme = {}

for _, part in pairs(parts) do
    local prefix = part.__part_prefix
    for k, v in pairs(part) do
        theme[prefix .. k] = v
    end
end


return theme

-- Global
local screen = require('awful.screen')

-- Config
local popup_ratio = require('config.vars').popup_ratio


local function getGeometry(ratio)
    --- @type Screen
    local s = screen.focused()
    local g = s.geometry
    local out = {
        width = g.width * ratio,
        height = g.height * ratio,
        x = g.x + (g.width - (g.width * ratio)) / 2,
        y = g.y + (g.height - (g.height * ratio)) / 2,
    }

    out.size = tostring(out.width) .. 'x' .. tostring(out.height)
    out.pos = '+' .. tostring(out.x) .. '+' .. tostring(out.y)
    out.string = out.size .. out.pos
    return out
end

local geometry = {
    max = function () return getGeometry(popup_ratio.max) end,
    large = function () return getGeometry(popup_ratio.large) end,
    medium = function () return getGeometry(popup_ratio.medium) end,
    small = function () return getGeometry(popup_ratio.small) end,
}

return {
    geometry = geometry,
}

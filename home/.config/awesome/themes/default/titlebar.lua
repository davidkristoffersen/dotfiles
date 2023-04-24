-- Local
local assets = require('themes.default.vars').assets

--- @class ThemeTitlebar
local titlebar = {}
local titlebar_p = assets .. '/titlebar/'

local function setTitlebarImg(state, focus)
    return titlebar_p .. state .. (focus and '_focus' or '_normal') .. '.png'
end

titlebar.titlebar_close_button_normal = setTitlebarImg('close', false)
titlebar.titlebar_close_button_focus = setTitlebarImg('close', true)
titlebar.titlebar_minimize_button_normal = setTitlebarImg('minimize', false)
titlebar.titlebar_minimize_button_focus = setTitlebarImg('minimize', true)

local titlebar_states = {'ontop', 'sticky', 'floating', 'maximized'}
for _, state in ipairs(titlebar_states) do
    titlebar['titlebar_' .. state .. '_button_normal_inactive'] =
        setTitlebarImg(state .. '_normal_inactive', false)
    titlebar['titlebar_' .. state .. '_button_focus_inactive'] =
        setTitlebarImg(state .. '_focus_inactive', false)
    titlebar['titlebar_' .. state .. '_button_normal_active'] =
        setTitlebarImg(state .. '_normal_active', false)
    titlebar['titlebar_' .. state .. '_button_focus_active'] =
        setTitlebarImg(state .. '_focus_active', false)
end


return titlebar

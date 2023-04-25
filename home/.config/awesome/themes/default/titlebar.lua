-- Local
local assets = require('themes.default.vars').assets


--- @type BeautifulConfigTitlebarPart
local t = {__part_prefix = 'titlebar_'}
local titlebar_p = assets .. '/titlebar/'

local function setImg(state, focus)
    return titlebar_p .. state .. (focus and '_focus' or '_normal') .. '.png'
end

t.close_button_normal = setImg('close', false)
t.close_button_focus = setImg('close', true)
t.minimize_button_normal = setImg('minimize', false)
t.minimize_button_focus = setImg('minimize', true)

local titlebar_states = {'ontop', 'sticky', 'floating', 'maximized'}
for _, state in ipairs(titlebar_states) do
    t[state .. '_button_normal_inactive'] = setImg(state .. '_normal_inactive', false)
    t[state .. '_button_focus_inactive'] = setImg(state .. '_focus_inactive', false)
    t[state .. '_button_normal_active'] = setImg(state .. '_normal_active', false)
    t[state .. '_button_focus_active'] = setImg(state .. '_focus_active', false)
end


return t

local awful = require('awful')
local gears = require('gears')
local screen = require('awful.screen')
local _hotkeys_popup = require('awful.hotkeys_popup')
local hotkeys_style = require('config.vars').hotkeys_style


local function get_keybindings()
    local keybindings = {}
    for _, data in ipairs(awful.key.hotkeys) do
        local mod, key, action = data[1], data[2], data[3]
        table.insert(keybindings, {mod, key, action.description, action.group})
    end
    for _, data in ipairs(awful.button.hotkeys) do
        local mod, button, action = data[1], data[2], data[3]
        table.insert(keybindings,
            {mod, 'Button ' .. tostring(button), action.description, action.group})
    end
    return keybindings
end

local function get_options()
    local f = screen.focused()
    local width = f.geometry.width * hotkeys_style.screen_ratio
    local height = f.geometry.height * hotkeys_style.screen_ratio
    return {
        width = width,
        height = height,
    }
end

local widget = gears.table.join(hotkeys_style, {
    keybindings_fn = get_keybindings,
})

-- hotkeys_popup:set_widget(hotkeys_widget)
local new_popup = _hotkeys_popup.widget.new(widget)

--- @param options table?
function new_popup:show(options)
    local style = gears.table.join(hotkeys_style, options, get_options())
    local popup = _hotkeys_popup.widget.new(style)
    popup:show_help()
    -- new_popup:set_widget(widget)
    -- new_popup:set_hotkeys(get_keybindings(), style)
end

return new_popup

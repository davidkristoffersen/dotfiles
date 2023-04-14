-- Global
local awful = require('awful')
local gears = require('gears')
local screen = require('awful.screen')
local _hotkeys_popup = require('awful.hotkeys_popup')

-- Config
local hotkeys_style = require('config.vars').hotkeys_style
local buttons = require('bindings.buttons.init')


local function get_keybindings()
    local keybindings = {}
    for _, data in ipairs(awful.key.hotkeys) do
        local mod, key, action = data[1], data[2], data[3]
        table.insert(keybindings, {mod, key, action.description, action.group})
    end
    local button_bindings = gears.table.join(buttons.global, buttons.client)
    for _, data in ipairs(button_bindings) do
        local mod, button, action = data[1], data[2], data[3]
        table.insert(keybindings,
            {mod, 'Button ' .. tostring(button), action.description, action.group})
    end
    for _, button in ipairs(button_bindings) do
        local button_modifiers = ''
        for _, mod in ipairs(button.modifiers) do
            button_modifiers = button_modifiers .. mod .. '-'
        end
        warn('Button Keybinding: ' .. button_modifiers .. 'button ' .. button.button)
    end
    return keybindings
end

-- -- Create a new table for the hotkeys_popup format
-- local button_bindings = {}

-- --- @type AButton
-- local buttons_client = buttons.client

-- -- Iterate through buttons_client and populate the button_bindings table
-- for _, button in ipairs(buttons.client) do
--     local button_modifiers = ''
--     for _, mod in ipairs(button.modifiers) do
--         button_modifiers = button_modifiers .. mod .. '-'
--     end

--     -- Add the keybinding to the button_bindings table
--     local group_name = 'My Button Bindings'
--     if not button_bindings[group_name] then
--         button_bindings[group_name] = {}
--     end

--     table.insert(button_bindings[group_name], {
--         modifiers = button_modifiers,
--         keys = {
--             ['button ' .. button.button] = 'description'
--         },
--     })
-- end

-- -- Print the button_bindings table to verify its structure
-- for group_name, group_data in pairs(button_bindings) do
--     print('Group Name: ' .. group_name)
--     for _, binding in ipairs(group_data) do
--         for key, description in pairs(binding.keys) do
--             print('  Keybinding: ' ..
--                 table.concat(binding.modifiers, '+') .. '+' .. key .. ' - ' .. description)
--         end
--     end
-- end

local function get_options()
    local f = screen.focused()
    local width = f.geometry.width * hotkeys_style.screen_ratio
    local height = f.geometry.height * hotkeys_style.screen_ratio
    return {
        width = width,
        height = height,
    }
end

-- hotkeys_popup:set_widget(hotkeys_widget)
local new_popup = _hotkeys_popup.widget.new(hotkeys_style)
-- new_popup.add_hotkeys(buttons.client)

--- @param options table?
function new_popup:show(options)
    local style = gears.table.join(hotkeys_style, options, get_options())
    local popup = _hotkeys_popup.widget.new(style)
    popup:show_help()
    -- new_popup:set_widget(widget)
    -- new_popup:set_hotkeys(get_keybindings(), style)
end

return new_popup

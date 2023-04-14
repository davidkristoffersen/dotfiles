-- Global
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require('awful.hotkeys_popup.keys')

-- Local
local keys = require('bindings.keys.init')
local buttons = require('bindings.buttons.init')


-- Set keys
root.keys(keys.global)

-- Set buttons
root.buttons(buttons.global)


return {
    keys = keys,
    buttons = buttons,
}

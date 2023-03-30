-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require('awful.hotkeys_popup.keys')

local global = require('bindings.global')
local client = require('bindings.client')
local mouse = require('bindings.mouse').buttons

return {
    global = global,
    client = client,
    mouse = mouse,
}

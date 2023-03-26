local global = require('bindings.global').keys
local client = require('bindings.client').keys
local mouse = require('bindings.mouse').buttons

return {
    global = global,
    client = client,
    mouse = mouse,
}

local global = require('binding.global').keys
local client = require('binding.client').keys
local mouse = require('binding.mouse').buttons

return {
    global = global,
    client = client,
    mouse = mouse,
}

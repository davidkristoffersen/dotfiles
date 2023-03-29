local global = require("bindings.global").keys
local client = require("bindings.client")
local mouse = require("bindings.mouse").buttons

return {
    global = global,
    client = client,
    mouse = mouse,
}

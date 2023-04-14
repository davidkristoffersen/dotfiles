-- Local
local debug = require('helpers.debug')
local error = require('helpers.error')
local module = require('helpers.module')
local keycodes = require('helpers.keycode.init')


-- Initialize error handling
error.init()


--- Utility functions
return {
    debug = debug,
    error = error,
    module = module,
    keycodes = keycodes,
    table = table,
}

-- Local
local debug = require('helpers.debug')
local error = require('helpers.error')
local module = require('helpers.module')
local keycodes = require('helpers.keycode.init')
local signal = require('helpers.signal.init')
local spawn = require('helpers.spawn')
local widget = require('helpers.widget')


-- Initialize error handling
error.init()


--- Utility functions
return {
    debug = debug,
    error = error,
    module = module,
    keycodes = keycodes,
    table = table,
    signal = signal,
    spawn = spawn,
    widget = widget,
}

-- Global
local naughty = require('naughty')


--- Send a warning notification to the user
---@param msg string | nil
---@param title string | nil
local function warn(title, msg)
    naughty.notify{
        preset = naughty.config.presets.warning,
        title = title or 'Debug Warning',
        text = msg or 'No message provided',
        timeout = 10,
    }
end


--- Debugging utilities
return {
    warn = warn,
}

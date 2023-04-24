-- Global
local naughty = require('naughty')

-- Local
local connect = require('helpers.signal.connecters').awesome
local signal = require('helpers.signal.constants.awesome')


--- Initialize error handling
local function init()
    -- Check if awesome encountered an error during startup and fallback to
    -- another config (This code will only ever execute for the fallback config)
    if awesome.startup_errors then
        naughty.notify{
            preset = naughty.config.presets.critical,
            title = 'Oops, there were errors during startup!',
            text = awesome.startup_errors,
        }
    end

    -- Handle runtime errors after startup
    do
        local in_error = false
        connect(signal.debug.error, function (err)
            -- Make sure we don't go into an endless error loop
            if in_error then
                return
            end
            in_error = true

            naughty.notify{
                preset = naughty.config.presets.critical,
                title = 'Oops, an error happened!',
                text = tostring(err),
            }

            in_error = false
        end)
    end
end


--- Error handling
return {
    init = init,
}

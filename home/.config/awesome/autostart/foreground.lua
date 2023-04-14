-- Global
local awful = require('awful')

-- Config
local apps = require('config.apps')


-- Terminal
awful.spawn(apps.terminal)

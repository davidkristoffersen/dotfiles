local awful = require('awful')

local apps = require('config.apps')

--[[
    Autostart: Applications
--]]
--
-- Terminal
awful.spawn(apps.terminal)

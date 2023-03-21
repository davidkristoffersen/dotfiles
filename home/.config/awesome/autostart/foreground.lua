local awful = require('awful')
local app = require('config.app')

--[[
    Autostart: Applications
--]]
--
-- Terminal
awful.spawn(app.terminal)

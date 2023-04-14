-- Global
local beautiful = require('beautiful')

-- Config
local apps = require('config.apps')

-- Local
local _awesome = require('menus.awesome')


local menu = {
    {'awesome',       _awesome,     beautiful.awesome_icon},
    {'open terminal', apps.terminal},
}


return menu

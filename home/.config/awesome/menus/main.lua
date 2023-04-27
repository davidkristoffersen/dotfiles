-- Global
local beautiful = require('beautiful')

-- Config
local terminal = require('helpers.spawn').terminal

-- Local
local _awesome = require('menus.awesome')


local menu = {
    {'awesome',       _awesome, beautiful.awesome_icon},
    {'open terminal', terminal},
}


return menu

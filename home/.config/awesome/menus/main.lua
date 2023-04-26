-- Global
local beautiful = require('beautiful')

-- Config
local term = require('helpers.spawn').terminal

-- Local
local _awesome = require('menus.awesome')


local menu = {
    {'awesome',       _awesome, beautiful.awesome_icon},
    {'open terminal', term},
}


return menu

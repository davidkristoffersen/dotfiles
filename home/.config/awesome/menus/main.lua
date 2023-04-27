-- Global
local beautiful = require('beautiful')

-- Config
local spawn = require('helpers.spawn')

-- Local
local _awesome = require('menus.awesome')
local test = require('menus.test')


local menu = {
    {'awesome',       _awesome,      beautiful.awesome_icon},
    {'test',          test},
    {'open terminal', spawn.terminal},
}


return menu

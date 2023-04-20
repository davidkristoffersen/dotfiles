-- Global
local awful        = require('awful')
local beautiful    = require('beautiful')

-- Config
local shared_state = require('shared_state.init')


local launcher = awful.widget.launcher.new{
    image = beautiful.awesome_icon,
    menu = shared_state.menus.main,
}


return launcher

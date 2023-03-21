-- Config variables
local app = require('config.app')

-- Standard awesome library
local awful = require('awful')
require('awful.autofocus')

-- Theme handling library
local beautiful     = require('beautiful')

-- Notification library
local menubar       = require('menubar')
local hotkeys_popup = require('awful.hotkeys_popup')


-- Create a launcher widget and a main menu
local awesome = {
    {'hotkeys',     function () hotkeys_popup.show_help(nil, awful.screen.focused()) end},
    {'manual',      app.terminal .. ' -e "man awesome"'},
    {'edit config', app.editor_cmd .. ' ' .. awesome.conffile .. '"'},
    {'restart',     awesome.restart},
    {'quit',        function () awesome.quit() end},
    {'lock',        function () awful.spawn.with_shell('xlock.sh') end},
}

local main = awful.menu{
    items = {
        {'awesome',       awesome,     beautiful.awesome_icon},
        {'open terminal', app.terminal},
    },
}

local launcher = awful.widget.launcher{
    image = beautiful.awesome_icon,
    menu = main,
}


-- Menubar configuration
-- Set the terminal for applications that require it
menubar.utils.terminal = app.terminal

return {
    awesome = awesome,
    launcher = launcher,
    main = main,
}

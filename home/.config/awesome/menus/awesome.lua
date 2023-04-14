-- Global
local awful = require('awful')

-- Config
local apps = require('config.apps')
local widgets = require('shared_state.init').widgets


local menu = {
    {'hotkeys',     function () widgets.hotkeys_popup:show() end},
    {'manual',      apps.terminal .. ' -e "man awesome"'},
    {'edit config', apps.editor_cmd .. ' ' .. awesome.conffile .. '"'},
    {'restart',     awesome.restart},
    {'quit',        function () awesome.quit() end},
    {'lock',        function () awful.spawn.with_shell('xlock.sh') end},
}


return menu

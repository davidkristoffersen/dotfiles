-- Config
local apps = require('config.apps')
local widgets = require('shared_state.init').widgets
local root = require('config.paths').root
local cb = require('helpers.spawn').cb


local menu = {
    {'hotkeys',              function () widgets.hotkeys_popup:show() end},
    {'manual',               cb.terminal('man awesome')},
    {'edit config (vim)',    cb.terminal(apps.editor .. ' ' .. root)},
    {'edit config (vscode)', cb.terminal('code ' .. root)},
    {'restart',              awesome.restart},
    {'lock',                 cb.background('xlock.sh')},
    {'quit',                 function () awesome.quit() end},
}


return menu

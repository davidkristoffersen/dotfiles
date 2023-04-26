-- Config
local apps = require('config.apps')
local widgets = require('shared_state.init').widgets
local root = require('config.paths').root
local spawn = require('helpers.spawn')


local termCb, backCb = spawn.terminalCb, spawn.backgroundCb

local menu = {
    {'hotkeys',              function () widgets.hotkeys_popup:show() end},
    {'manual',               termCb('man awesome')},
    {'edit config (vim)',    termCb(apps.editor .. ' ' .. root)},
    {'edit config (vscode)', termCb('code ' .. root)},
    {'restart',              awesome.restart},
    {'lock',                 backCb('xlock.sh')},
    {'quit',                 function () awesome.quit() end},
}


return menu

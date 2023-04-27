-- Config
local spawn = require('helpers.spawn')


local menu = {
    {'()',          function () spawn('arandr') end},
    {'spawn',       function () spawn.spawn('arandr') end},
    {'shell',       function () spawn.shell('arandr') end},
    {'terminal',    function () spawn.terminal('vim') end},
    {'cb()',        spawn.cb('arandr')},
    {'cb.spawn',    spawn.cb.spawn('arandr')},
    {'cb.shell',    spawn.cb.shell('arandr')},
    {'cb.terminal', spawn.cb.terminal('vim')},
}


return menu

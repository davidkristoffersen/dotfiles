-- Global
local awful = require('awful')

-- Config
local apps = require('config.apps')

-- Local
local func = require('helpers.func')


--- @alias SpawnFunc fun (cmd: string): nil

--- ### Description
--- Launches terminal with varargs
--- ### Parameters
--- @param cmd string | nil Variable number of string arguments
local function terminal(cmd)
    if cmd == nil or cmd == '' or type(cmd) == 'table' then
        awful.spawn(apps.terminal)
    else
        awful.spawn(apps.terminal .. ' -e "' .. cmd .. '"')
    end
end

--- ### Description
--- Returns a function that launches a command in the background
--- ### Parameters
--- @type { [string]: fun (cmd: string): SpawnFunc }
local cb = {
    spawn = func.cb(awful.spawn.spawn),
    shell = func.cb(awful.spawn.with_shell),
    terminal = func.cb(terminal),
}

local spawn = {
    cb = cb,
    spawn = awful.spawn.spawn,
    shell = awful.spawn.with_shell,
    terminal = terminal,
}

spawn = setmetatable(spawn, {__call = func.noSelf(awful.spawn.spawn)})
spawn.cb = setmetatable(spawn.cb, {__call = func.noSelfCb(awful.spawn.spawn)})


return spawn

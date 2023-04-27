-- Global
local awful = require('awful')

-- Config
local apps = require('config.apps')
local warn = require('helpers.debug').warn


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
--- Launches a command in the background
--- ### Parameters
--- @param cmd string Variable number of string arguments
local function background(cmd)
    awful.spawn.with_shell(cmd)
end

--- ### Description
--- Launches a command in the foreground
--- ### Parameters
--- @param cmd string Variable number of string arguments
local function foreground(cmd)
    awful.spawn(cmd)
end

local function genCb(func)
    return function (cmd) return function () func(cmd) end end
end

--- ### Description
--- Returns a function that launches a command in the background
--- ### Parameters
--- @type { [string]: fun (cmd: string): SpawnFunc }
local cb = {
    terminal = genCb(terminal),
    background = genCb(background),
    foreground = genCb(foreground),
}


return {
    terminal = terminal,
    background = background,
    foreground = foreground,
    cb = cb,
}

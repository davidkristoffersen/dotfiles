-- Global
local awful = require('awful')

-- Config
local apps = require('config.apps')


--- ### Description
--- Launches terminal with varargs
--- ### Parameters
--- @param ... string Variable number of string arguments
local function terminal(...)
    if select('#', ...) == 0 or type(select(1, ...)) ~= 'string' then
        awful.spawn(apps.terminal)
    else
        awful.spawn(apps.terminal .. ' -e "' .. table.concat({...}, ' ') .. '"')
    end
end

--- ### Description
--- Returns a function that launches terminal with varargs
--- ### Parameters
--- @param ... string Variable number of string arguments
local function terminalCb(...)
    local args = ...
    return function () terminal(args) end
end

--- ### Description
--- Launches a command in the background
--- ### Parameters
--- @param ... string Variable number of string arguments
local function background(...)
    awful.spawn.with_shell(table.concat({...}, ' '))
end

--- ### Description
--- Returns a function that launches a command in the background
--- ### Parameters
--- @param ... string Variable number of string arguments
local function backgroundCb(...)
    local args = ...
    return function () background(args) end
end


return {
    terminal = terminal,
    terminalCb = terminalCb,
    background = background,
    backgroundCb = backgroundCb,
}

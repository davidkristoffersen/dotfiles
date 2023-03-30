local awful = require('awful')
local gears = require('gears')

local warn = require('helpers.debug').warn
local T = require('helpers.keycode.combinations.tables')
local S = require('helpers.keycode.combinations.strings')
local S_to_T = require('helpers.keycode.combinations.strings_to_tables')

--- Create a key binding
---@param binding table Table where: [1] = 'mod' string[], [2] = 'key' string
---@param func function Function to be called when key is pressed
---@param desc string Description of key binding
---@param group string Group of key binding
---@return AKey[]: A table with key objects.
local set_key = function (binding, func, desc, group)
    if desc == nil then desc = 'no description' end
    if group == nil then group = 'no group' end
    local t =
        awful.key.new(binding[1], binding[2], func, nil, {description = desc, group = group})
    return t
end

--- Map keytable keys to actions
---
--- ### Parameters
--- @param keytable table -- Dictionary of List[Modifier[], string] -> function
--- ### Returns
--- @return table -- List of key objects
local function join_keys(keytable)
    local keys = {}
    for key, action in pairs(keytable) do
        -- warn('String', key)
        local comb = S_to_T[key]
        --- @type Modifier[]
        local mod_table = comb[1]
        --- @type string|nil
        local key_name = comb[2]
        -- Enumerate list of modifiers
        for i, mod in ipairs(mod_table) do
            -- warn('Mod[' .. i .. ']', mod --[[@as string --]])
        end
        -- warn('Keyname', key_name)

        --- @type function, table, table
        local func, data, args
        if type(action) == 'table' then
            if type(action[1]) == 'table' then
                args = action
                action = table.remove(args, 1)

                local info = debug.getinfo(action[1])
                if info.nparams ~= #args then
                    local s = info.source
                    local l = info.linedefined
                    local title = 'Incorrect number of arguments'
                    local desc1 = 'Expected ' .. info.nparams .. ' arguments, got ' .. #args
                    local desc2 = 'Source:' .. s .. ', Line:' .. l
                    local desc = desc1 .. '\n' .. desc2
                    warn(title, desc)
                end
            else
                args = {}
            end

            func = action[1]
            if #args > 0 then
                func = function () action[1](table.unpack(args)) end
            end
            data = {description = action[2][1], group = action[2][2]}
        else
            func = action
        end

        table.insert(keys, awful.key.new(mod_table, key_name, func, data))
    end
    return gears.table.join(table.unpack(keys))
end

return {
    set_key = set_key,
    join_keys = join_keys,
}

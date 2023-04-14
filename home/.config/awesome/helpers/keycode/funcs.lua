-- Global
local awful = require('awful')
local gears = require('gears')

-- Local
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

--- Parse a key string into a mod table and a key name
---
--- ### Parameters
--- @param key string
--- ### Returns
--- @return KeyComb -- Table with [1] = mod table, [2] = key name
local function parse_key(key)
    local comb = S_to_T[key]
    local mod_table = comb[1]
    local key_name = comb[2]
    -- Enumerate list of modifiers
    -- for i, mod in ipairs(mod_table) do
    -- warn('Mod[' .. i .. ']', mod --[[@as string --]])
    -- end
    -- warn('Keyname', key_name)
    return {mod_table, key_name}
end

--- Create a function that calls a function with a table of arguments
---
--- ### Parameters
--- @param func function Function to be called
--- @param args table Table of arguments
--- ### Returns
--- @return function func Function that calls func with arg
local function func_with_args(func, args)
    return function () func(table.unpack(args)) end
end

--- @class KeyCbParsed
--- @field [1] function Callback function
--- @field [2] AKeyData Callback data

--- Parse a key callback into a function, data, and args
---
--- ### Parameters
--- @param keyCb KeyCb Callback object
--- ### Returns
--- @return KeyCbParsed keyCbParsed Parsed callback object
local function parse_key_cb(keyCb)
    local func, data

    -- Five keyCb variant cases:
    -- 1. keyCb = function
    -- 2. keyCb = {function, AKeyData?, args: table?}
    -- 3. keyCb = {{function, AKeyData?}, args: table}

    if type(keyCb) == 'function' then -- Case 1
        func = keyCb
        data = {}
    elseif type(keyCb) == 'table' then
        if type(keyCb[1]) == 'function' then -- Case 2
            func = keyCb[1]
            data = keyCb[2]
            if keyCb.args ~= nil then
                func = func_with_args(keyCb[1] --[[@as function --]], keyCb.args)
            end
        elseif type(keyCb[1]) == 'table' then -- Case 3
            data = keyCb[1][2]
            func = func_with_args(keyCb[1][1] --[[@as function --]], keyCb.args)
        end
    end

    if data ~= nil and #data == 2 then data = {description = data[1], group = data[2]} end

    return {func, data}
end

--- Check if keyname is a button (starts with 'B')
---
--- ### Parameters
--- @param key string? Key name
--- ### Returns
--- @return boolean # True if key is a button
local function is_key_button(key) return key ~= nil and key:sub(1, 1) == 'B' end

--- Parse a button key into a button name
---
--- ### Parameters
--- @param key string Key name
--- ### Returns
--- @return string button Button name
local function parse_button(key) return key:sub(2) end

--- Map keytable keys to actions
---
--- ### Parameters
--- @param keytable Keytable -- Dictionary of List[Modifier[], string] -> function
--- ### Returns
--- @return AKey[] -- List of key objects
local function join_keys(keytable)
    local keys = {}
    for key, keyCb in pairs(keytable) do
        local comb = parse_key(key)
        local mod_table, key_name = comb[1], comb[2]

        local keyCbParsed = parse_key_cb(keyCb)
        local func, data = keyCbParsed[1], keyCbParsed[2]

        --- @type AKey|AButton
        local binding
        if is_key_button(key_name) then
            key_name = parse_button(key_name --[[@as string --]])
            local button = tonumber(key_name) --[[ @as integer --]]
            -- warn('Button', key_name)
            -- warn('Data', data.description)
            binding = awful.button.new(mod_table, button, func)
        else
            binding = awful.key.new(mod_table, key_name, func, data)
        end

        table.insert(keys, binding)
    end
    return gears.table.join(table.unpack(keys))
end


return {
    set_key = set_key,
    join_keys = join_keys,
}

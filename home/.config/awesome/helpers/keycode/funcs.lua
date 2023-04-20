-- Global
local awful = require('awful')
local gears = require('gears')

-- Local
local S_to_T = require('helpers.keycode.combinations.strings_to_tables')


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
--- @param func FunctionKeyCb Function to be called
--- @param args table Table of arguments
--- ### Returns
--- @return FunctionKeyCb func Function that calls func with arg
local function set_func(func, args)
    if args == nil then return func end
    return function () func(table.unpack(args)) end
end

local function set_data(data)
    if #data > 0 then data.description = data[1] end
    if #data > 1 then data.group = data[2] end
    return data
end


--- @class KeyCbParsed
--- @field [1] FunctionKeyCb Callback function
--- @field [2] AKeyData Callback data

--- Parse a key callback into a function, data, and args
---
--- ### Parameters
--- @param cb InnerKeyCb
--- ### Returns
--- @return KeyCbParsed keyCbParsed Parsed callback object
local function parse_inner_key_cb(cb)
    local func, data

    if type(cb.f) == 'function' and type(cb.d) == 'table' then
        func, data = cb.f, cb.d
    elseif type(cb.f) == 'function' and type(cb[1]) == 'table' then
        func, data = cb.f, cb[1]
    elseif type(cb[1]) == 'function' and type(cb.d) == 'table' then
        func, data = cb[1], cb.d
    elseif type(cb[1]) == 'function' and type(cb[2]) == 'table' then
        func, data = cb[1], cb[2]
    else
        error('Invalid inner key callback:' .. tostring(cb))
    end

    return {func, data}
end

--- Parse a key callback into a function, data, and args
---
--- ### Parameters
--- @param keyCb KeyCb
--- ### Returns
--- @return KeyCbParsed keyCbParsed Parsed callback object
local function parse_key_cb(keyCb)
    local func, data, parsed

    if type(keyCb) == 'function' then
        func, data = keyCb, {}
    elseif type(keyCb) == 'table' then
        if type(keyCb.inner) == 'table' then
            parsed = parse_inner_key_cb(keyCb.inner --[[@as InnerKeyCb --]])
        else
            parsed = parse_inner_key_cb(keyCb --[[@as InnerKeyCb --]])
        end
        func, data = parsed[1], parsed[2]
        func = set_func(func, keyCb.args)
    else
        error('Invalid key callback:' .. tostring(keyCb))
    end

    data = set_data(data)

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
--- @param keytable Keytable Keytable object
--- ### Returns
--- @return AwfulKey[] keybindings Key bindings list
local function join_keys(keytable)
    local keys = {}
    for key, keyCb in pairs(keytable) do
        local comb = parse_key(key)
        local mod_table, key_name = comb[1], comb[2]

        local keyCbParsed = parse_key_cb(keyCb)
        local func, data = keyCbParsed[1], keyCbParsed[2]

        --- @type AwfulKey|AwfulButton
        local binding
        if is_key_button(key_name) then
            key_name = parse_button(key_name --[[@as string --]])
            local button = tonumber(key_name) --[[@as integer --]]
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
    join_keys = join_keys,
}

local awful = require('awful')

---@constructor
---@param mod Modifier[] A table with modifier keys.
---@param _key string A key name.
---@param press function A function to call when the key is pressed.
---@param release function? A function to call when the key is released.
---@param data table? A table with extra data.
---@diagnostic disable-next-line: undefined-doc-name
---@return awful.key[]: A table with key objects.
local function _set_key(mod, _key, press, release, data)
    local t = awful.key(mod, _key, press, release, data)
    return t
end

--- Create a key binding
---@param binding table Table where: [1] = 'mod' string[], [2] = 'key' string
---@param func function Function to be called when key is pressed
---@param desc string Description of key binding
---@param group string Group of key binding
local set_key = function (binding, func, desc, group)
    if desc == nil then desc = 'no description' end
    if group == nil then group = 'no group' end
    return _set_key(binding[1], binding[2], func, nil, {description = desc, group = group})
end

local t = awful.key({'Mod1'}, 'Tab', function ()
end, nil, {description = 'next window', group = 'client'})

return {
    set_key = set_key,
}

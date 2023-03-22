local awful = require('awful')

--- Create a key binding
---@param binding table Table where: [1] = 'mod': table<string>, [2] = 'key': string
---@param func function Function to be called when key is pressed
---@param desc string Description of key binding
---@param group string Group of key binding
local set_key = function (binding, func, desc, group)
    if desc == nil then desc = 'no description' end
    if group == nil then group = 'no group' end
    return awful.key(binding[1], binding[2], func, {description = desc, group = group})
end

return {
    set_key = set_key,
}

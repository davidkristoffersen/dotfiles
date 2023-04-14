--- Shared state between modules
---
--- @class SharedState
--- @field menus Menus
--- @field widgets Widgets
--- @field set function @Set a key value pair in the shared state
--- @field fill function @Set all key values of a table to a shared state root key
local shared_state = {
    menus = {},
    widgets = {},
}

-- Create a metatable for the shared state
local mt = {
    __newindex = function (t, k, v)
        if k == 'menus' or k == 'widgets' then
            shared_state[k] = v
        else
            error('Attempt to set invalid key in shared state: ' .. k)
        end
    end,
}

-- Create a proxy table that wraps the shared state table with the metatable
local proxy = setmetatable(shared_state, mt)


-- Return the proxy table instead of the shared_state table
return proxy

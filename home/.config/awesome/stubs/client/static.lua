---@diagnostic disable: missing-return

--- Get the number of instances.
---@return integer: Number of client objects alive.
--- ## Usage
--- ```lua
--- local count = client.instances()
--- ```
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#instances)
function client.instances()
end

--- Get all clients into a table.
---
--- TODO Fix type after screen.lua is typed
---@param screen integer|screen?: A screen number to filter clients on (optional).
---@param stacked boolean?: Return clients in stacking order? (ordered from top to bottom) (optional).
---@return table: A table with clients.
--- ## Usage
--- ```lua
--- for _, c in ipairs(client.get()) do
---     -- do something
--- end
--- ```
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#get)
function client.get(screen, stacked)
end

--- Disconnect from a signal.
---@param name string: The name of the signal.
---@param func function: The callback that should be disconnected.
--- ## Usage
--- ```lua
--- client.disconnect_signal("some_signal", function_to_disconnect)
--- ```
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#disconnect_signal)
function client.disconnect_signal(name, func)
end

--- Emit a signal.
---@param name string: The name of the signal.
---@param ... any: Extra arguments for the callback functions.
--- ## Usage
--- ```lua
--- client.emit_signal("some_signal", arg1, arg2, ...)
--- ```
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#emit_signal)
function client.emit_signal(name, ...)
end

--- Connect to a signal.
---@param name string: The name of the signal.
---@param func function: The callback to call when the signal is emitted.
--- ## Usage
--- ```lua
--- client.connect_signal("some_signal", function_to_connect)
--- ```
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#connect_signal)
function client.connect_signal(name, func)
end

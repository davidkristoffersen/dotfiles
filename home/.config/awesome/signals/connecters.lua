--- ### Description
--- Connects a signal to a function.
---
--- ---
--- @see Client.connect_signal
local function client_connector(signal, func)
    client.connect_signal(signal, func)
end

--- ### Description
--- Connects a signal to a function.
---
--- ---
--- @see Screen.connect_signal
local function screen_connector(signal, func)
    screen.connect_signal(signal, func)
end

return {
    client = client_connector,
    screen = screen_connector,
}

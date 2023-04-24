--- ### Description
--- Connects a signal to a function.
---
--- ---
--- @see Client.connect_signal
local function client_connecter(signal, func)
    client.connect_signal(signal, func)
end

--- ### Description
--- Connects a signal to a function.
---
--- ---
--- @see Screen.connect_signal
local function screen_connecter(signal, func)
    screen.connect_signal(signal, func)
end

--- ### Description
--- Connects a signal to a function.
---
--- ---
--- @see awesome.connect_signal
local function awesome_connecter(signal, func)
    awesome.connect_signal(signal, func)
end


return {
    awesome = awesome_connecter,
    client = client_connecter,
    screen = screen_connecter,
}

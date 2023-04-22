-- Global
local beautiful = require('beautiful')


--- Change the client focus when the mouse enters its area.
--- @param c Client
local function mouse_enter(c)
    c:emit_signal('request::activate', 'mouse_enter', {raise = false})
end

--- Set the border color for the focused client.
--- @param c Client
local function focus(c) c.border_color = beautiful.border_focus end

--- Set the border color for the unfocused client.
--- @param c Client
local function unfocus(c) c.border_color = beautiful.border_normal end

client.connect_signal('mouse::enter', mouse_enter)
client.connect_signal('focus', focus)
client.connect_signal('unfocus', unfocus)

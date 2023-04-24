-- Global
local beautiful = require('beautiful')

-- Config
local signal = require('helpers.signal.constants.client')
local emitter = require('helpers.signal.emitters.client')
local connect = require('helpers.signal.connecters').client


--- Change the client focus when the mouse enters its area.
--- @param c Client
local function mouse_enter(c)
    emitter.request.activate(c, 'mouse_enter', {raise = false})
end

--- Set the border color for the focused client.
--- @param c Client
local function focus(c) c.border_color = beautiful.border_focus end

--- Set the border color for the unfocused client.
--- @param c Client
local function unfocus(c) c.border_color = beautiful.border_normal end

connect(signal.mouse.enter, mouse_enter)
connect(signal.focus, focus)
connect(signal.unfocus, unfocus)

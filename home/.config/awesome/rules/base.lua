-- Global
local awful = require('awful')
local beautiful = require('beautiful')

-- Config
local bindings = require('bindings.init')


-- All clients will match this rule.
--- @type RuledClientRule
local rules = {
    rule = {},
    properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter --[[@as boolean --]],
        raise = true,
        keys = bindings.keys.client,
        buttons = bindings.buttons.client,
        screen = awful.screen.preferred --[[@as Screen --]],
        placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
}


return rules

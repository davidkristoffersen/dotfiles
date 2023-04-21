-- Global
local awful = require('awful')
local beautiful = require('beautiful')

-- Config
local bindings = require('bindings.init')


--- @type RuledClientRule
local rules = {
    -- All clients will match this rule.
    rule = {},
    properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = bindings.keys.client,
        buttons = bindings.buttons.client,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
}

-- TODO: Figure out what client properties is the same in ruledClientCriteria

return rules

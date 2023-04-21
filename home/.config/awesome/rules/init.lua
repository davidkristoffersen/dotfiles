-- Global
local awful = require('awful')

-- Local
local base = require('rules.base')
local floating = require('rules.floating')
local titlebar = require('rules.titlebar')
local apps = require('rules.apps')


local rules = {
    base, floating, titlebar,
    -- apps
}

-- Rules to apply to new clients (through the "manage" signal).
--- @type RuledClientRule[]
awful.rules.rules = {}
for _, rule in ipairs(rules) do
    table.insert(awful.rules.rules, rule)
end


-- awful.rules.rules = {
--     -- All clients will match this rule.
--     {
--         rule = {},
--         properties = {
--             border_width = beautiful.border_width,
--             border_color = beautiful.border_normal,
--             focus = awful.client.focus.filter,
--             raise = true,
--             keys = bindings.keys.client,
--             buttons = bindings.buttons.client,
--             screen = awful.screen.preferred,
--             placement = awful.placement.no_overlap + awful.placement
--                 .no_offscreen,
--         },
--     }, -- Floating clients.
--     {
--         rule_any = {
--             instance = {
--                 'DTA',   -- Firefox addon DownThemAll.
--                 'copyq', -- Includes session name in class.
--                 'pinentry'
--             },
--             class = {
--                 'Arandr',
--                 'Blueman-manager',
--                 'Gpick',
--                 'Kruler',
--                 'MessageWin',  -- kalarm.
--                 'Sxiv',
--                 'Tor Browser', -- Needs a fixed window size to avoid fingerprinting by screen size.
--                 'Wpa_gui',
--                 'veromix',
--                 'xtightvncviewer'
--             },
--             -- Note that the name property shown in xprop might be set slightly after creation of the client
--             -- and the name shown there might not match defined rules here.
--             name = {'Event Tester' -- xev.
--             },
--             role = {
--                 'AlarmWindow',   -- Thunderbird's calendar.
--                 'ConfigManager', -- Thunderbird's about:config.
--                 'pop-up'         -- e.g. Google Chrome's (detached) Developer Tools.
--             },
--         },
--         properties = {floating = true},
--     }, -- Add titlebars to normal clients and dialogs
--     {
--         rule_any = {type = {'normal', 'dialog'}},
--         properties = {titlebars_enabled = true},
--     }, -- Set Firefox to always map on the tag named "2" on screen 1.
--     -- { rule = { class = "Firefox" },
--     --   properties = { screen = 1, tag = "2" } },
-- }

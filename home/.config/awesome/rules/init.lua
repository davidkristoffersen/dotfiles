-- Global
local awful = require('awful')

-- Local
local base = require('rules.base')
local floating = require('rules.floating')
local titlebar = require('rules.titlebar')
local apps = require('rules.apps')


local rules = {
    base,
    floating,
    titlebar,
    -- apps
}

--- @type RuledClientRule[]
awful.rules.rules = {}
for _, rule in ipairs(rules) do
    table.insert(awful.rules.rules, rule)
end

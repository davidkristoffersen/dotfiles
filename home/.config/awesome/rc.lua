---@diagnostic disable: lowercase-global
-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local awful = require("awful")

-- local gears = require("gears")

-- local f = client.foo
-- local ac = client.active

-- local a = awesome

-- GEARS
-- local g = gears
-- local t = g.table
-- local j = t.join
-- local jr = j({})

-- -- AWFUL
-- local a = awful
-- local k = a.key
-- local r = k.new
-- local rr = r({ "Mod4" }, "l", function() end)
-- local ri = rr[1]

--[[
    Libraries
--]]
--
-- Standard awesome library
-- local awful = require('awful')
require("awful.autofocus")

--[[
    Local libraries
--]]
--
-- Global declarations
local conf = require("config.init")

-- Helpers
local helpers = require("helpers.init")
-- Error handling
helpers.error.init()

-- Theme handling library
require("themes.init").init(conf.vars.theme)

-- Menu
require("menus.init")

-- Set awesome layouts
awful.layout.layouts = conf.vars.layouts

-- Wibar
require("widgets.init")

-- Key bindings
local bindings = require("bindings.init")
-- Set keys
root.keys(bindings.global)

-- Rules
require("rules.init")

-- Signals
require("signals.init")

-- Autostart
require("autostart.init")

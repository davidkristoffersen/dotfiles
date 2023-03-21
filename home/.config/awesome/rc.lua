---@diagnostic disable: lowercase-global
-- awesome_mode: api-level=4:screen=on
-- @diagnostic disable: lowercase-global
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, 'luarocks.loader')

--[[
    Libraries
--]]
--
-- Standard awesome library
local awful = require('awful')
require('awful.autofocus')

--[[
    Local libraries
--]]
--
-- Global declarations
local conf = require('config.init')

-- Utilities
local util = require('util.init')
-- Error handling
util.error.init()

-- Theme handling library
require('themes.init').init('default')

-- Menu
require('menu.init')

-- Set awesome layouts
awful.layout.layouts = conf.layout.layouts

-- Wibar
require('widget.init')

-- Mouse bindings
require('binding.init')

-- Key bindings
local binding = require('binding.init')
-- Set keys
root.keys(binding.global)

-- Rules
require('rule.init')

-- Signals
require('signal.init')

-- Autostart
require('autostart.init')

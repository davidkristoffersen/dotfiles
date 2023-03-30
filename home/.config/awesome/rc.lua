-- awesome_mode: api-level=4:screen=on

--------------------------------
-- Configuration and Helpers
--------------------------------

-- Global configuration variables and settings
require('config.init')

-- Helper functions and utilities
require('helpers.init')


--------------------------------
-- LuaRocks and Core Libraries
--------------------------------

-- Load LuaRocks loader to support external packages
pcall(require, 'luarocks.loader')

-- Import and initialize the standard AwesomeWM library
require('awful.autofocus')


--------------------------------
-- Interface, Bindings, and Runtime Configuration
--------------------------------

-- Load and apply the selected theme
require('themes.init')

-- Create main and context menus
require('menus.init')

-- Initialize wibar and widgets
require('widgets.init')

-- Define and set key and mouse bindings
require('bindings.init')

-- Set rules for clients (windows)
require('rules.init')

-- Set up AwesomeWM signals and event handling
require('signals.init')

-- Launch autostart programs
require('autostart.init')

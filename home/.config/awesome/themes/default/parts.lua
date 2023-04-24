-- Global
local gears = require('gears')

-- Local
local style = require('themes.default.style')
local tags = require('themes.default.tags')
local notification = require('themes.default.notification')
local menu = require('themes.default.menu')
local titlebar = require('themes.default.titlebar')
local icons = require('themes.default.icons')
local wallpaper = require('themes.default.wallpaper')


--- ### Description
--- The ThemeParts class contains various theme-related components.
--- @class ThemeParts
--- @field style ThemeStyle Theme styling properties such as colors, fonts, and borders.
--- @field tags ThemeTags Configuration for tags, including layouts and tag names.
--- @field notification ThemeNotification Configuration for notifications, including appearance and behavior.
--- @field menu ThemeMenu Configuration for menus, including appearance, menu entries, and behavior.
--- @field titlebar ThemeTitlebar Configuration for titlebars, including appearance, buttons, and behavior.
--- @field icons ThemeIcons Theme icons for various AwesomeWM components.
--- @field wallpaper ThemeWallpaper Configuration for wallpaper, including image sources and scaling options.
local theme = {}

theme.style = style
theme.tags = tags
theme.notification = notification
theme.menu = menu
theme.titlebar = titlebar
theme.icons = icons
theme.wallpaper = wallpaper


return theme

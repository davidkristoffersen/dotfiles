-- Global
local gears = require('gears')

-- Local
--- @type BeautifulConfigSplitPart
local theme = {
    general = require('themes.default.general'),
    menu = require('themes.default.menu'),
    tasklist = require('themes.default.tasklist'),
    taglist = require('themes.default.taglist'),
    titlebar = require('themes.default.titlebar'),
    tooltip = require('themes.default.tooltip'),
    mouse_finder = require('themes.default.mouse_finder'),
    prompt = require('themes.default.prompt'),
    hotkeys = require('themes.default.hotkeys'),
    notification = require('themes.default.notification'),
    layout = require('themes.default.layout'),
}


return theme

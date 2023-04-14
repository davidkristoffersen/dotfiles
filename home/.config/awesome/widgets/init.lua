-- Config
local shared_state = require('shared_state.init')
local table = require('helpers.table')

-- Local
require('widgets.main')
local hotkeys_popup = require('widgets.hotkeys_popup')
local launcher = require('widgets.launcher')


--- Widgets
---
--- @class Widgets
local widgets = {
    hotkeys_popup = hotkeys_popup,
    launcher = launcher,
}

table.update(shared_state.widgets, widgets)

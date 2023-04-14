-- Global
local awful = require('awful')

-- Config
local shared_state = require('shared_state.init')
local table = require('helpers.table')

-- Local
local main = require('menus.main')


--- Menus
---
--- @class Menus
--- @field main table
local menus = {
    main = awful.menu{items = main},
}

table.update(shared_state.menus, menus)

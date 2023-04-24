-- Global
local gfs = require('gears.filesystem')


--- @type string
local assets = gfs.get_configuration_dir() .. 'themes/default/assets'

local vars = {
    assets = assets,
}


return vars

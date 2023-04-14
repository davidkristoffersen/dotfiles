-- Global
local gears = require('gears')


--- Path to awesome configuration directory
local root = gears.filesystem.get_configuration_dir():gsub('/$', '')

--- Original package path
local pack = package.path

--- Path to awesome themes directory
local themes = root .. '/themes'


return {
    root = root,
    package = pack,
    themes = themes,
}

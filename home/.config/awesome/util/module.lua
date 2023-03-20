--- Get current script path, returns
---@param level integer | nil
---@return string path
---@return integer count
local function current_path(level)
    level = level or 2
    local path = debug.getinfo(level, 'S').source:sub(2)
    return path:gsub('^@', ''):gsub('//', '/')
end

--- Get path relative to client script
---@param path string
---@return string relative_path
---@return integer count
local function relative_path(path)
    return path:gsub(config_path, '')
end

--- Get directory name from path
---@param path string
---@return string
local function dirname(path)
    return path:match('(.*/)'):gsub('/$', '')
end


--- Get current script file path relative to awesomewm config path
---@param level integer | nil
---@return string
local function script_path(level)
    level = level or 3
    local cur = current_path(level)
    local rel = relative_path(cur)
    return rel
end

--- Get current script dir path relative to awesomewm config path
---@param level integer | nil
---@return string
local function script_dir(level)
    level = level or 4
    local rel = script_path(level)
    return dirname(rel)
end

--- Initialize module path
---
--- Warning:
--- - This function will modify package.path
--- - Data required using this function is dynamic and looses code completion
---@param path string | nil
local function init(path)
    path = path or script_dir(5)
    local autostart_path = config_path .. path .. '/?.lua;'
    package.path = package.path .. ';' .. autostart_path
end

--- Restore original package path
---
--- Warning:
--- - Must be called after init()
local function cleanup()
    package.path = org_path
end

return {
    init = init,
    cleanup = cleanup,
    script_path = script_path,
    script_dir = script_dir,
}

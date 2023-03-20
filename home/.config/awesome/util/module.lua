local function init_module(path)
    local autostart_path = config_path .. path .. '/?.lua;'
    package.path = package.path .. ';' .. autostart_path
end

local function deinit_module()
    package.path = org_path
end

-- local function script_path()
--     local str = debug.getinfo(2, 'S').source:sub(2)
--     return str:match('(.*/)') or './'
-- end

-- return {script_path = script_path}

return {
    init_module = init_module,
    deinit_module = deinit_module,
}

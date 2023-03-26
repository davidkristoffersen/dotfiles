---@diagnostic disable: missing-return

---@alias Modifier
---| '"Any"' # Any modifier key.
---| '"Mod1"' # Alt key.
---| '"Mod2"' # Num Lock key.
---| '"Mod3"' # Scroll Lock key.
---| '"Mod4"' # Super key.
---| '"Mod5"' # Mode Switch key.
---| '"Shift"' # Shift key.
---| '"Lock"' # Caps Lock key.
---| '"Control"' # Control key.

---@constructor
---@param mod Modifier[] A table with modifier keys.
---@param _key string A key name.
---@param press function A function to call when the key is pressed.
---@param release function? A function to call when the key is released.
---@param data table? A table with extra data.
---@diagnostic disable-next-line: undefined-doc-name
---@return awful.key[]: A table with key objects.
function awful.key(mod, _key, press, release, data)
end

-- local t = awful.key({'Mod1'}, 'Tab', function ()
-- end, nil, {description = 'next window', group = 'client'})
-- TODO It was because awful was local that other files could not detect the annotations.
---TODO Cont. Making it global in rc.lua Works! But it might not be the best solution.

---TODO Project files and dir naming: Plural or singular. Use drawer with boxes analogy.

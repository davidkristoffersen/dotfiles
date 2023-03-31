local join_keys = require('helpers.keycode.funcs').join_keys
local n = require('helpers.keycode.combinations.strings').n
local r = require('actions.mouse').root


local buttons = join_keys{
    [n.b_right] = r.toggle,
    [n.b_up]    = r.next,
    [n.b_down]  = r.prev,
}


return buttons

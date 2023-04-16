-- Config
local join_keys = require('helpers.keycode.funcs').join_keys
local _ = require('helpers.keycode.combinations.strings')._
local r = require('actions.mouse').root


local buttons = join_keys{
    [_.b_right] = r.toggle,
    [_.b_up]    = r.next,
    [_.b_down]  = r.prev,
}


return buttons

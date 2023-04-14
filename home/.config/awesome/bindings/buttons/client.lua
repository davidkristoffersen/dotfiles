-- Config
local join_keys = require('helpers.keycode.funcs').join_keys
local S = require('helpers.keycode.combinations.strings')
local m, n = S.m, S.n
local c = require('actions.mouse').client


--- @class AButton
local buttons = join_keys{
    [n.b_left]  = c.focus,
    [m.b_left]  = c.move,
    [m.b_right] = c.resize,
}


return buttons

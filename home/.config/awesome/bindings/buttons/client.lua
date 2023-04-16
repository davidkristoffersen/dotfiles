-- Config
local join_keys = require('helpers.keycode.funcs').join_keys
local S = require('helpers.keycode.combinations.strings')
local m, _ = S.m, S._
local c = require('actions.mouse').client


--- @class AButton
local buttons = join_keys{
    [_.b_left]  = c.focus,
    [m.b_left]  = c.move,
    [m.b_right] = c.resize,
}


return buttons

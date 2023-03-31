local keycode = require('helpers.keycode.init')
local join_keys = keycode.funcs.join_keys
local S = keycode.combinations.strings

local client = require('actions.client')
local t, m, r = client.toggle, client.move, client.resize

local keys = join_keys{
    -- Toggling
    [S.m.f]        = t.fullscreen,
    [S.mc.space]   = t.floating,
    [S.ms.c]       = t.close,
    [S.m.t]        = t.keep_on_top,

    -- Moving
    [S.mc.return_] = m.to_master,
    [S.m.o]        = m.to_screen,
    [S.ma.right]   = m.to_next_screen,
    [S.ma.left]    = m.to_previous_screen,

    -- Resizing
    [S.m.n]        = r.minimize,
    [S.m.m]        = r.maximize,
    [S.mc.m]       = r.maximize_vertically,
    [S.ms.m]       = r.maximize_horizontally,
}

return keys

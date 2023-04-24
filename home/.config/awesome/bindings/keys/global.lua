-- Global
local gears = require('gears')

-- Config
local keycode = require('helpers.keycode.init')
local global = require('actions.global')


local join_keys = keycode.funcs.join_keys
local S = keycode.combinations.strings
local ga, gt, gta, gc, gs, gw, gy, gu =
    global.awesome,
    global.tag,
    global.tag_actions,
    global.client,
    global.screen,
    global.client_swap,
    global.layout,
    global.launcher

local keys = join_keys{
    -- Awesome
    [S.m.s]       = ga.help,
    [S.mc.r]      = ga.restart,
    [S.mcsa.q]    = ga.quit,
    [S.mca.r]     = ga.test,
    [S.m.x]       = ga.lua_prompt,
    [S.m.w]       = ga.main,

    -- Tag
    [S.m.left]    = gt.view_previous,
    [S.m.right]   = gt.view_next,
    [S.m.escape]  = gt.history_restore,

    -- Client
    [S.m.j]       = gc.focus_next,
    [S.m.k]       = gc.focus_previous,
    [S.m.u]       = gc.urgent_jumpto,
    [S.m.tab]     = gc.focus_history_previous,
    [S.mc.n]      = gc.restore_minimized,

    -- Screen
    [S.mc.j]      = gs.focus_next,
    [S.mc.k]      = gs.focus_previous,
    [S.mc.right]  = gs.focus_next,
    [S.mc.left]   = gs.focus_previous,

    -- Client swap
    [S.ms.j]      = gw.next,
    [S.ms.k]      = gw.previous,
    [S.ms.right]  = gw.next,
    [S.ms.left]   = gw.previous,

    -- Layout
    [S.m.l]       = gy.increase_master_width,
    [S.m.h]       = gy.decrease_master_width,
    [S.ms.h]      = gy.increase_master_clients,
    [S.ms.l]      = gy.decrease_master_clients,
    [S.mc.h]      = gy.increase_columns,
    [S.mc.l]      = gy.decrease_columns,
    [S.m.space]   = gy.select_next,
    [S.ms.space]  = gy.select_previous,

    -- Launcher
    [S.m.return_] = gu.terminal,
    [S.m.b]       = gu.browser,
    [S.ms.s]      = gu.screenshot,
    [S.mcsa.l]    = gu.lock,
    [S.mcsa.s]    = gu.suspend,
    [S.mcsa.h]    = gu.hibernate,
    [S.mcsa.p]    = gu.poweroff,
    [S.m.r]       = gu.prompt,
    [S.m.d]       = gu.rofi,
    [S.m.p]       = gu.menubar,
}

-- Bind all key numbers to tags.
for i = 1, 9 do
    keys = gears.table.join(keys, join_keys{
        [S.m._ .. '-' .. i]   = gta.view[i],
        [S.mc._ .. '-' .. i]  = gta.toggle[i],
        [S.ms._ .. '-' .. i]  = {inner = gta.move_client[i], args = {client}},
        [S.mcs._ .. '-' .. i] = {inner = gta.toggle_client[i], args = {client}},
    })
end


return keys

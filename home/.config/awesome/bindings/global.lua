local awful = require('awful')
local gears = require('gears')

local keycode = require('helpers.keycode.init')
local modkey = require('config.vars').mods.m
local join_keys = keycode.funcs.join_keys
local S = keycode.combinations.strings
local global = require('actions.global')
local ga, gt, gc, gs, gw, gy, gu =
    global.awesome,
    global.tag,
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
    [S.m.r]       = gu.prompt,
    [S.m.d]       = gu.rofi,
    [S.m.p]       = gu.menubar,
}

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    keys = gears.table.join(
        keys, -- View tag only.
        awful.key({modkey}, '#' .. i + 9, function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then tag:view_only() end
        end, {description = 'view tag #' .. i, group = 'tag'}), -- Toggle tag display.
        awful.key({modkey, 'Control'}, '#' .. i + 9, function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then awful.tag.viewtoggle(tag) end
        end, {description = 'toggle tag #' .. i, group = 'tag'}), -- Move client to tag.
        awful.key({modkey, 'Shift'}, '#' .. i + 9, function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:move_to_tag(tag) end
            end
        end, {description = 'move focused client to tag #' .. i, group = 'tag'}), -- Toggle tag on focused client.
        awful.key({modkey, 'Control', 'Shift'}, '#' .. i + 9, function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:toggle_tag(tag) end
            end
        end, {description = 'toggle focused client on tag #' .. i, group = 'tag'})
    )
end

return {
    keys = keys,
}

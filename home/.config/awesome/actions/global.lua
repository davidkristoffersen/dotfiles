local awful = require('awful')
local screen = require('awful.screen')
local menubar = require('menubar')
local hotkeys_popup = require('widgets.hotkeys_popup')

local main = require('menus.init').main
local apps = require('config.apps')

local awesome = {
    help = {function () hotkeys_popup:show() end, {'show help', 'awesome'}},
    restart = {awesome.restart, {'reload awesome', 'awesome'}},
    quit = {awesome.quit, {'quit awesome', 'awesome'}},
    test = {
        function ()
            awful.spawn.with_shell(
                'Xephyr -ac -br -noreset -screen 1920x1080 :5 & sleep 1 ; DISPLAY=:5 awesome'
            )
        end,
        {'test awesome in a new session', 'launcher'},
    },
    lua_prompt = {
        function ()
            awful.prompt.run{
                prompt = 'Run Lua code: ',
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. '/history_eval',
            }
        end,
        {'lua execute prompt', 'awesome'},
    },
    main = {
        function () main:show() end,
        {'show main menu', 'awesome'},
    },
}
local tag = {
    view_previous = {awful.tag.viewprev, {'view previous', 'tag'}},
    view_next = {awful.tag.viewnext, {'view next', 'tag'}},
    history_restore = {
        awful.tag.history.restore,
        {'go back', 'tag'},
    },
}
local client = {
    focus_next = {
        function () awful.client.focus.byidx(1) end,
        {'focus next by index', 'client'},
    },
    focus_previous = {
        function () awful.client.focus.byidx(-1) end,
        {'focus previous by index', 'client'},
    },
    urgent_jumpto = {
        awful.client.urgent.jumpto,
        {'jump to urgent client', 'client'},
    },
    focus_history_previous = {
        function ()
            awful.client.focus.history.previous()
            if client.focus then client.focus:raise() end
        end,
        {'go back', 'client'},
    },
    restore_minimized = {
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then c:emit_signal('request::activate', 'key.unminimize', {raise = true}) end
        end,
        {'restore minimized', 'client'},
    }, -- Prompt
}
local screen = {
    focus_next = {
        function () awful.screen.focus_relative(1) end,
        {'focus the next screen', 'screen'},
    },
    focus_previous = {
        function () awful.screen.focus_relative(-1) end,
        {'focus the previous screen', 'screen'},
    },
}
local client_swap = {
    -- Layout manipulation
    -- The same for arrow left and right
    next = {
        function () awful.client.swap.byidx(1) end,
        {'swap with next client by index', 'client'},
    },
    previous = {
        function () awful.client.swap.byidx(-1) end,
        {'swap with previous client by index', 'client'},
    },
}

local layout = {
    increase_master_width = {
        function () awful.tag.incmwfact(0.05) end,
        {'increase master width factor', 'layout'},
    },
    decrease_master_width = {
        function () awful.tag.incmwfact(-0.05) end,
        {'decrease master width factor', 'layout'},
    },
    increase_master_clients = {
        function () awful.tag.incnmaster(1, nil, true) end,
        {'increase the number of master clients', 'layout'},
    },
    decrease_master_clients = {
        function () awful.tag.incnmaster(-1, nil, true) end,
        {'decrease the number of master clients', 'layout'},
    },
    increase_columns = {
        function () awful.tag.incncol(1, nil, true) end,
        {'increase the number of columns', 'layout'},
    },
    decrease_columns = {
        function () awful.tag.incncol(-1, nil, true) end,
        {'decrease the number of columns', 'layout'},
    },
    select_next = {
        function () awful.layout.inc(1) end,
        {'select next', 'layout'},
    },
    select_previous = {
        function () awful.layout.inc(-1) end,
        {'select previous', 'layout'},
    },
}
local launcher = {
    terminal = {
        function () awful.spawn(apps.terminal) end,
        {'open a terminal', 'launcher'},
    },
    browser = {
        function () awful.spawn('google-chrome-stable') end,
        {'open google-chrome-stable', 'launcher'},
    }, -- Take a screenshot
    screenshot = {
        function () awful.spawn('flameshot gui') end,
        {'take a screenshot', 'launcher'},
    },
    lock = {
        function () awful.spawn('xlock.sh') end,
        {'lock screen', 'launcher'},
    },
    suspend = {
        function ()
            awful.spawn('xlock.sh')
            awful.spawn.with_shell('sleep 3 && systemctl suspend')
        end,
        {'Sleep the system', 'launcher'},
    },
    hibernate = {
        function () awful.spawn('systemctl hibernate') end,
        {'Hybernate the system', 'launcher'},
    },
    prompt = {
        function () awful.screen.focused().mypromptbox:run() end,
        {'run prompt', 'launcher'},
    },
    rofi = {
        function () awful.util.spawn('rofi -show drun') end,
        {'show rofi', 'launcher'},
    },
    menubar = {
        function () menubar.show() end,
        {'show the menubar', 'launcher'},
    },
}

-- Tag-related actions
local tag_actions = {
    view = {},          -- Keybindings for viewing tags
    toggle = {},        -- Keybindings for toggling tags
    move_client = {},   -- Keybindings for moving clients to tags
    toggle_client = {}, -- Keybindings for toggling clients on tags
}


local _screen
local _tag
for i = 1, 9 do
    -- View tag
    tag_actions.view[i] = {
        function ()
            _screen = awful.screen.focused()
            _tag = _screen.tags[i]
            if _tag then _tag:view_only() end
        end,
        {'view tag #' .. i, 'tag'},
    }

    -- Toggle tag display
    tag_actions.toggle[i] = {
        function ()
            _screen = awful.screen.focused()
            _tag = _screen.tags[i]
            if _tag then awful.tag.viewtoggle(_tag) end
        end,
        {'toggle tag #' .. i, 'tag'},
    }

    -- Move client to tag
    tag_actions.move_client[i] = {
        --- @param c client
        function (c)
            if c.focus then
                _tag = c.focus.screen.tags[i]
                if _tag then c.focus:move_to_tag(_tag) end
            end
        end,
        {'move focused client to tag #' .. i, 'tag'},
    }

    -- Toggle tag on focused client
    tag_actions.toggle_client[i] = {
        --- @param c client
        function (c)
            if c.focus then
                _tag = c.focus.screen.tags[i]
                if _tag then c.focus:toggle_tag(_tag) end
            end
        end,
        {'toggle focused client on tag #' .. i, 'tag'},
    }
end

return {
    awesome = awesome,
    tag = tag,
    tag_actions = tag_actions,
    client = client,
    screen = screen,
    client_swap = client_swap,
    layout = layout,
    launcher = launcher,
}

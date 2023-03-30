local awful = require('awful')
local menubar = require('menubar')
local hotkeys_popup = require('awful.hotkeys_popup').widget

local main = require('menus.init').main
local apps = require('config.apps')

local awesome = {
    help = { hotkeys_popup.show_help, { 'show help', 'awesome' } },
    restart = { awesome.restart, { 'reload awesome', 'awesome' } },
    quit = { awesome.quit, { 'quit awesome', 'awesome' } },
    test = {
        function()
            awful.spawn.with_shell(
                'Xephyr -ac -br -noreset -screen 1920x1080 :5 & sleep 1 ; DISPLAY=:5 awesome'
            )
        end,
        { 'test awesome in a new session', 'launcher' },
    },
    lua_prompt = {
        function()
            awful.prompt.run {
                prompt = 'Run Lua code: ',
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. '/history_eval',
            }
        end,
        { 'lua execute prompt', 'awesome' },
    },
    main = {
        function() main:show() end,
        { 'show main menu', 'awesome' },
    },
}
local tag = {
    view_previous = { awful.tag.viewprev, { 'view previous', 'tag' } },
    view_next = { awful.tag.viewnext, { 'view next', 'tag' } },
    history_restore = {
        awful.tag.history.restore,
        { 'go back', 'tag' },
    },
}
local client = {
    focus_next = {
        function() awful.client.focus.byidx(1) end,
        { 'focus next by index', 'client' },
    },
    focus_previous = {
        function() awful.client.focus.byidx(-1) end,
        { 'focus previous by index', 'client' },
    },
    urgent_jumpto = {
        awful.client.urgent.jumpto,
        { 'jump to urgent client', 'client' },
    },
    focus_history_previous = {
        function()
            awful.client.focus.history.previous()
            if client.focus then client.focus:raise() end
        end,
        { 'go back', 'client' },
    },
    restore_minimized = {
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then c:emit_signal('request::activate', 'key.unminimize', { raise = true }) end
        end,
        { 'restore minimized', 'client' },
    }, -- Prompt
}
local screen = {
    focus_next = {
        function() awful.screen.focus_relative(1) end,
        { 'focus the next screen', 'screen' },
    },
    focus_previous = {
        function() awful.screen.focus_relative(-1) end,
        { 'focus the previous screen', 'screen' },
    },
}
local client_swap = {
    -- Layout manipulation
    -- The same for arrow left and right
    next = {
        function() awful.client.swap.byidx(1) end,
        { 'swap with next client by index', 'client' },
    },
    previous = {
        function() awful.client.swap.byidx(-1) end,
        { 'swap with previous client by index', 'client' },
    },
}

local layout = {
    increase_master_width = {
        function() awful.tag.incmwfact(0.05) end,
        { 'increase master width factor', 'layout' },
    },
    decrease_master_width = {
        function() awful.tag.incmwfact(-0.05) end,
        { 'decrease master width factor', 'layout' },
    },
    increase_master_clients = {
        function() awful.tag.incnmaster(1, nil, true) end,
        { 'increase the number of master clients', 'layout' },
    },
    decrease_master_clients = {
        function() awful.tag.incnmaster(-1, nil, true) end,
        { 'decrease the number of master clients', 'layout' },
    },
    increase_columns = {
        function() awful.tag.incncol(1, nil, true) end,
        { 'increase the number of columns', 'layout' },
    },
    decrease_columns = {
        function() awful.tag.incncol(-1, nil, true) end,
        { 'decrease the number of columns', 'layout' },
    },
    select_next = {
        function() awful.layout.inc(1) end,
        { 'select next', 'layout' },
    },
    select_previous = {
        function() awful.layout.inc(-1) end,
        { 'select previous', 'layout' },
    },
}
local launcher = {
    terminal = {
        function() awful.spawn(apps.terminal) end,
        { 'open a terminal', 'launcher' },
    },
    browser = {
        function() awful.spawn('google-chrome-stable') end,
        { 'open google-chrome-stable', 'launcher' },
    }, -- Take a screenshot
    screenshot = {
        function() awful.spawn('flameshot gui') end,
        { 'take a screenshot', 'launcher' },
    },
    lock = {
        function() awful.spawn('xlock.sh') end,
        { 'lock screen', 'launcher' },
    },
    suspend = {
        function() awful.spawn('systemctl suspend') end,
        { 'Sleep the system', 'launcher' },
    },
    hibernate = {
        function() awful.spawn('systemctl hibernate') end,
        { 'Hybernate the system', 'launcher' },
    },
    prompt = {
        function() awful.screen.focused().mypromptbox:run() end,
        { 'run prompt', 'launcher' },
    },
    rofi = {
        function() awful.util.spawn('rofi -show drun') end,
        { 'show rofi', 'launcher' },
    },
    menubar = {
        function() menubar.show() end,
        { 'show the menubar', 'launcher' },
    },
}

return {
    awesome = awesome,
    tag = tag,
    client = client,
    screen = screen,
    client_swap = client_swap,
    layout = layout,
    launcher = launcher,
}

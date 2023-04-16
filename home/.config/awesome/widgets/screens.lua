-- Global
local awful = require('awful')
local wibox = require('wibox.init')

-- Config
local conf = require('config.init')
local vars = conf.vars
local join_keys = require('helpers.keycode.funcs').join_keys
local S = require('helpers.keycode.combinations.strings')

-- Local
local set_wallpaper = require('widgets.wallpaper').set_wallpaper
local taglist_buttons = require('widgets.buttons').taglist_buttons
local tasklist_buttons = require('widgets.buttons').tasklist_buttons
local launcher = require('widgets.launcher')


-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- Textclock widget
local mytextclock = wibox.widget.textclock()

--- Call function for specified screen
---
--- @param s table
local function connect_screen(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag(vars.names, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(join_keys{
        [S._.b_left] = function () awful.layout.inc(1) end,
        [S._.b_right] = function () awful.layout.inc(-1) end,
        [S._.b_up] = function () awful.layout.inc(1) end,
        [S._.b_down] = function () awful.layout.inc(-1) end,
    })

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist{
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist{
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
    }

    -- Create the wibox
    s.mywibox = awful.wibar{
        position = 'top',
        screen = s,
    }


    -- Add widgets to the wibox
    s.mywibox:setup{
        layout = wibox.layout.align.horizontal,
        {
            -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            launcher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        {
            -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end

awful.screen.connect_for_each_screen(connect_screen)

-- Global
local awful = require('awful')
local wibox = require('wibox.init')

-- Config
local S = require('helpers.keycode.combinations.strings')
local signal = require('helpers.signal.constants.client')
local emit = require('helpers.signal.emitters.client')
local join_keys = require('helpers.keycode.funcs').join_keys
local connect = require('helpers.signal.connecters').client


--- Adds a titlebar to the client if titlebars_enabled is true in the rules.
--- @param c Client
local function add_titlebar(c)
    -- Define buttons for the titlebar.
    local buttons = join_keys{
        [S._.b_left] = function ()
            emit.request.activate(c, 'titlebar', {raise = true})
            awful.mouse.client.move(c)
        end,
        [S._.b_right] = function ()
            emit.request.activate(c, 'titlebar', {raise = true})
            awful.mouse.client.resize(c)
        end,
    }

    -- Set up the titlebar layout.
    awful.titlebar(c):setup{
        {
            -- Left side: icon widget and buttons.
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal,
        },
        {
            -- Middle: title widget and buttons.
            {
                align = 'center',
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal,
        },
        {
            -- Right side: titlebar buttons.
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal(),
        },
        layout = wibox.layout.align.horizontal,
    }
end

connect(signal.request.titlebars, add_titlebar)

--- @type RuledClientRule
local rules = {
    -- Floating clients.
    rule_any = {
        instance = {
            'DTA',   -- Firefox addon DownThemAll.
            'copyq', -- Includes session name in class.
            'pinentry'
        },
        class = {
            'Arandr',
            'Blueman-manager',
            'Gpick',
            'Kruler',
            'MessageWin',  -- kalarm.
            'Sxiv',
            'Tor Browser', -- Needs a fixed window size to avoid fingerprinting by screen size.
            'Wpa_gui',
            'veromix',
            'xtightvncviewer'
        },
        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {'Event Tester' -- xev.
        },
        role = {
            'AlarmWindow',   -- Thunderbird's calendar.
            'ConfigManager', -- Thunderbird's about:config.
            'pop-up'         -- e.g. Google Chrome's (detached) Developer Tools.
        },
    },
    properties = {floating = true},
}


return rules

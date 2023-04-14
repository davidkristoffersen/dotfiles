-- Global
local awful = require('awful')


-- Polkit authentication agent
awful.spawn.with_shell('/usr/lib/polkit-kde-authentication-agent-1 &')

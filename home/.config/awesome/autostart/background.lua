local awful = require('awful')

--[[
	Autostart: Background programs
--]]
--
-- Polkit authentication agent
awful.spawn.with_shell('/usr/lib/polkit-kde-authentication-agent-1 &')

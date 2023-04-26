-- Config
local background = require('helpers.spawn').background


-- Polkit authentication agent
background('/usr/lib/polkit-kde-authentication-agent-1 &')

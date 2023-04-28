-- Config
local spawn = require('helpers.spawn')


-- Polkit authentication agent
spawn('/usr/lib/polkit-kde-authentication-agent-1')

-- Set keyboard layout
spawn('setxkbmap no -variant nodeadkeys')

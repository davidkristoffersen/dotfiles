-- Local
local awesome_emitters = require('helpers.signal.emitters.awesome')
local client_emitters = require('helpers.signal.emitters.client')
local screen_emitters = require('helpers.signal.emitters.screen')


return {
    awesome_emitters = awesome_emitters,
    client_emitters = client_emitters,
    screen_emitters = screen_emitters,
}

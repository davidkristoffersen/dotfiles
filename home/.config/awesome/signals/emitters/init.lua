-- Local
local awesome_emitters = require('signals.emitters.awesome')
local client_emitters = require('signals.emitters.client')
local screen_emitters = require('signals.emitters.screen')


return {
    awesome_emitters = awesome_emitters,
    client_emitters = client_emitters,
    screen_emitters = screen_emitters,
}

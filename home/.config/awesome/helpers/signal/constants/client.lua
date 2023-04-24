--- ### Description
--- This module contains the constants for the client signals.
--- ### Constraints
--- - Access: read-only
--- ### Usage
--- Connecting to a signal:
--- ```lua
--- local signals = require('signals.constants.client')
--- client.connect_signal(signals.manage, function(c) end)
--- ```
--- Emitting a signal:
--- ```lua
--- local signals = require('signals.constants.client')
--- client.emit_signal(signals.manage, client)
--- ```
--- @class ClientSignals
local signals = {
    --- Emitted when AwesomeWM is about to scan for existing clients.
    scanning = 'scanning',
    --- Emitted when AwesomeWM is done scanning for clients.
    scanned = 'scanned',
    --- Emitted when a client gains focus.
    focus = 'focus',
    --- Emitted before request::manage, after request::unmanage, and when clients swap.
    list = 'list',
    --- Emitted when 2 clients are swapped.
    swapped = 'swapped',
    --- Emitted when a client gets tagged.
    tagged = 'tagged',
    --- Emitted when a client gets unfocused.
    unfocus = 'unfocus',
    --- Emitted when a client gets untagged.
    untagged = 'untagged',
    --- Emitted when the client is raised within its layer.
    raised = 'raised',
    --- Emitted when the client is lowered within its layer.
    lowered = 'lowered'
}

--- ### Description
--- Constants for the `Client` `request` signals.
--- @class ClientSignalsRequest
signals.request = {
    --- Emitted when a new client appears and gets managed by Awesome.
    manage = 'request::manage',
    --- Emitted when a client is going away.
    unmanage = 'request::unmanage',
    --- Emitted when a client should get activated (focused and/or raised).
    activate = 'request::activate',
    --- Emitted when an event could lead to the client being activated.
    autoactivate = 'request::autoactivate',
    --- Emitted when something requests a client's geometry to be modified.
    geometry = 'request::geometry',
    --- Emitted when a client requests to be moved to a tag or needs a new tag.
    tag = 'request::tag',
    --- Emitted when any client's urgent property changes.
    urgent = 'request::urgent',
    --- Emitted once to request default client mousebindings during the initial startup sequence.
    default_mousebindings = 'request::default_mousebindings',
    --- Emitted once to request default client keybindings during the initial startup sequence.
    default_keybindings = 'request::default_keybindings',
    --- Emitted when a client needs to get a titlebar.
    titlebars = 'request::titlebars',
    --- Emitted when the border client might need to be updated.
    border = 'request::border'
}

--- ### Description
--- Constants for the `Client` `button` signals.
--- @class ClientSignalsButton
signals.button = {
    --- Emitted when a mouse button is pressed in a client.
    press = 'button::press',
    --- Emitted when a mouse button is released in a client.
    release = 'button::release'
}

--- ### Description
--- Constants for the `Client` `mouse` signals.
--- @class ClientSignalsMouse
signals.mouse = {
    --- Emitted when the mouse enters a client.
    enter = 'mouse::enter',
    --- Emitted when the mouse leaves a client.
    leave = 'mouse::leave',
    --- Emitted when the mouse moves within a client.
    move = 'mouse::move'
}

--- ### Description
--- Constants for the `Client` `property` signals.
--- @class ClientSignalsProperty
signals.property = {
    --- The last geometry when the client was floating.
    floating_geometry = 'property::floating_geometry'
}


return signals

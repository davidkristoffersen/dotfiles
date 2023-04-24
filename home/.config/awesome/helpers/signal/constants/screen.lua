--- ### Description
--- This module contains the constants for the screen signals.
--- ### Constraints
--- - Access: read-only
--- ### Usage
--- Connecting to a signal:
--- ```lua
--- local signals = require('constants.screen')
--- screen.connect_signal(signals.added, function(s) end)
--- ```
--- Emitting a signal:
--- ```lua
--- local signals = require('constants.screen')
--- screen.emit_signal(signals.added, screen)
--- ```
--- @class ScreenSignals
local signals = {
    --- Emitted when AwesomeWM is about to scan for existing screens.
    scanning = 'scanning',
    --- Emitted when AwesomeWM is done scanning for screens.
    scanned = 'scanned',
    --- Emitted when the primary screen changes.
    primary_changed = 'primary_changed',
    --- Emitted when a new screen is added to the current setup.
    added = 'added',
    --- Emitted when a screen is removed from the setup.
    removed = 'removed',
    --- Emitted when the list of available screens changes.
    list = 'list',
    --- Emitted when 2 screens are swapped.
    swapped = 'swapped'
}

--- ### Description
--- Constants for the `Screen` `request` signals.
--- @class ScreenSignalsRequest
signals.request = {
    --- Emitted when a new screen is added.
    desktop_decoration = 'request::desktop_decoration',
    --- Emitted when a new screen needs a wallpaper.
    wallpaper = 'request::wallpaper',
    --- Emitted when a new (physical) screen area has been added.
    create = 'request::create',
    --- Emitted when a physical monitor viewport has been removed.
    remove = 'request::remove',
    --- Emitted when a physical viewport resolution has changed or it has been replaced.
    resize = 'request::resize'
}

--- ### Description
--- Constants for the `Screen` `tag` signals.
--- @class ScreenSignalsTag
signals.tag = {}

--- ### Description
--- Constants for the `Screen` `tag` `history` signals.
--- @class ScreenSignalsTagHistory
signals.tag.history = {
    --- Emitted when the tag history changed.
    update = 'tag::history::update'
}

--- ### Description
--- Constants for the `Screen` `property` signals.
--- @class ScreenSignalsProperty
signals.property = {
    --- Emitted when the list of physical screen viewport changes.
    viewports = 'property::viewports',
    --- Emitted when the list of physical screen geometry changes.
    geometry = 'property::geometry'
}


return signals

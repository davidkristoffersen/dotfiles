--- ### Description
--- This module contains the constants for the awesome object signals.
--- ### Constraints
--- - Access: read-only
--- ### Usage
--- Connecting to a signal:
--- ```lua
--- local signals = require('signals.constants.awesome')
--- awesome.connect_signal(signals.quit, function() end)
--- ```
--- Emitting a signal:
--- ```lua
--- local signals = require('signals.constants.awesome')
--- awesome.emit_signal(signals.quit)
--- ```
--- @class AwesomeSignals
local signals = {
    --- Emitted when the wallpaper has changed.
    wallpaper_changed = 'wallpaper_changed',
    --- Emitted when a refresh occurs.
    refresh = 'refresh',
    --- Emitted when AwesomeWM is about to enter the event loop.
    startup = 'startup',
    --- Emitted when AwesomeWM is exiting or about to restart.
    exit = 'exit',
}

--- ### Description
--- Constants for the `Debug` signals.
--- @class AwesomeSignalsDebug
signals.debug = {
    --- Emitted when a call into the Lua code aborted with an error.
    error = 'debug::error',
    --- Emitted when a deprecated Lua function was called.
    deprecation = 'debug::deprecation',
    --- Emitted when an invalid key was read from an object.
    index_miss = 'debug::index::miss',
    --- Emitted when an invalid key was written to an object.
    newindex_miss = 'debug::newindex::miss',
}

--- ### Description
--- Constants for the `Systray` signals.
--- @class AwesomeSignalsSystray
signals.systray = {
    --- Emitted when the systray should be updated.
    update = 'systray::update',
}

--- ### Description
--- Constants for the `Xkb` signals.
--- @class AwesomeSignalsXkb
signals.xkb = {
    --- Emitted when the keyboard map has changed.
    map_changed = 'xkb::map_changed',
    --- Emitted when the keyboard group has changed.
    group_changed = 'xkb::group_changed',
}

--- ### Description
--- Constants for the `Screen` signals.
--- @class AwesomeSignalsScreen
signals.screen = {
    --- Emitted when the output status of a screen has changed.
    change = 'screen::change',
}

--- ### Description
--- Constants for the `Spawn` signals.
--- @class AwesomeSignalsSpawn
signals.spawn = {
    --- Emitted when, for some reason, the application aborted startup.
    canceled = 'spawn::canceled',
    --- Emitted when one of the fields from the spawn::initiated table changes.
    change = 'spawn::change',
    --- Emitted when an application finished starting.
    completed = 'spawn::completed',
    --- Emitted when a new client is beginning to start.
    initiated = 'spawn::initiated',
    --- Emitted when an application started a spawn event but didn't start in time.
    timeout = 'spawn::timeout',
}


return signals

-- Local
local signals = require('helpers.signal.constants.awesome')

--- ### Description
--- This module contains emitters for the AwesomeWM signals.
--- ### Constraints
--- - Access: read-only
--- ### Usage
--- Emitting a signal:
--- ```lua
--- local emit = require('signals.emitters.awesome')
--- emit.wallpaper_changed()
--- ```
--- Emitting a signal with arguments:
--- ```lua
--- local emit = require('signals.emitters.awesome')
--- emit.refresh()
--- ```
--- @class AwesomeEmitter
local emitter = {}

--- ### Description
--- Emit the `wallpaper_changed` signal.
---
--- ---
--- @see AwesomeSignals.wallpaper_changed
function emitter.wallpaper_changed()
    awesome:emit_signal(signals.wallpaper_changed)
end

--- ### Description
--- Emit the `refresh` signal.
---
--- ---
--- @see AwesomeSignals.refresh
function emitter.refresh()
    awesome:emit_signal(signals.refresh)
end

--- ### Description
--- Emit the `startup` signal.
---
--- ---
--- @see AwesomeSignals.startup
function emitter.startup()
    awesome:emit_signal(signals.startup)
end

--- ### Description
--- Emit the `exit` signal.
--- ### Parameters
--- @param reason_restart boolean True if the signal was sent because of a restart.
--- ---
--- @see AwesomeSignals.exit
function emitter.exit(reason_restart)
    awesome:emit_signal(signals.exit, reason_restart)
end

--- ### Description
--- Awesome `debug` namespace emitters.
emitter.debug = {}

--- ### Description
--- Emit the `debug::error` signal.
--- ### Parameters
--- @param err table The error object.
--- ---
--- @see AwesomeSignalsDebug.error
function emitter.debug.error(err)
    awesome:emit_signal(signals.debug.error, err)
end

--- ### Description
--- Emit the `debug::deprecation` signal.
--- ### Parameters
--- @param hint string A hint on what to use instead of the deprecated functionality.
--- @param see string|nil The name of the newer API.
--- @param args table|nil The name of the newer API.
--- ---
--- @see AwesomeSignalsDebug.deprecation
function emitter.debug.deprecation(hint, see, args)
    awesome:emit_signal(signals.debug.deprecation, hint, see, args)
end

--- ### Description
--- Emit the `debug::index::miss` signal.
--- ### Parameters
--- @param unknown1 Class The unknown class.
--- @param unknown2 Key The unknown key.
--- ---
--- @see AwesomeSignalsDebug.index_miss
function emitter.debug.index_miss(unknown1, unknown2)
    awesome:emit_signal(signals.debug.index_miss, unknown1, unknown2)
end

--- ### Description
--- Emit the `debug::newindex::miss` signal.
--- ### Parameters
--- @param unknown1 Class The unknown class.
--- @param unknown2 Key The unknown key.
--- @param unknown3 Value The unknown value.
--- ---
--- @see AwesomeSignalsDebug.newindex_miss
function emitter.debug.newindex_miss(unknown1, unknown2, unknown3)
    awesome:emit_signal(signals.debug.newindex_miss, unknown1, unknown2, unknown3)
end

--- ### Description
--- Awesome `systray` namespace emitters.
emitter.systray = {}

--- ### Description
--- Emit the `systray::update` signal.
---
--- ---
--- @see AwesomeSignalsSystray.update
function emitter.systray.update()
    awesome:emit_signal(signals.systray.update)
end

--- ### Description
--- Awesome `xkb` namespace emitters.
emitter.xkb = {}

--- ### Description
--- Emit the `xkb::map_changed` signal.
---
--- ---
--- @see AwesomeSignalsXkb.map_changed
function emitter.xkb.map_changed()
    awesome:emit_signal(signals.xkb.map_changed)
end

--- ### Description
--- Emit the `xkb::group_changed` signal.
--- ### Parameters
--- @param group number Integer containing the changed group.
--- ---
--- @see AwesomeSignalsXkb.group_changed
function emitter.xkb.group_changed(group)
    awesome:emit_signal(signals.xkb.group_changed, group)
end

--- ### Description
--- Awesome `screen` namespace emitters.
emitter.screen = {}

--- ### Description
--- Emit the `screen::change` signal.
--- ### Parameters
--- @param output string The output that has changed.
--- @param connection_state string The connection status of the output.
--- ---
--- @see AwesomeSignalsScreen.change
function emitter.screen.change(output, connection_state)
    awesome:emit_signal(signals.screen.change, output, connection_state)
end

--- ### Description
--- Awesome `spawn` namespace emitters.
emitter.spawn = {}

--- ### Description
--- Emit the `spawn::canceled` signal.
--- ### Parameters
--- @param arg table Table which only got the "id" key set.
--- ---
--- @see AwesomeSignalsSpawn.canceled
function emitter.spawn.canceled(arg)
    awesome:emit_signal(signals.spawn.canceled, arg)
end

--- ### Description
--- Emit the `spawn::change` signal.
--- ### Parameters
--- @param arg table Table which describes the spawn event.
--- ---
--- @see AwesomeSignalsSpawn.change
function emitter.spawn.change(arg)
    awesome:emit_signal(signals.spawn.change, arg)
end

--- ### Description
--- Emit the `spawn::completed` signal.
--- ### Parameters
--- @param arg table Table which only got the "id" key set.
--- ---
--- @see AwesomeSignalsSpawn.completed
function emitter.spawn.completed(arg)
    awesome:emit_signal(signals.spawn.completed, arg)
end

--- ### Description
--- Emit the `spawn::initiated` signal.
--- ### Parameters
--- @param arg table Table which describes the spawn event.
--- ---
--- @see AwesomeSignalsSpawn.initiated
function emitter.spawn.initiated(arg)
    awesome:emit_signal(signals.spawn.initiated, arg)
end

--- ### Description
--- Emit the `spawn::timeout` signal.
--- ### Parameters
--- @param arg table Table which only got the "id" key set.
--- ---
--- @see AwesomeSignalsSpawn.timeout
function emitter.spawn.timeout(arg)
    awesome:emit_signal(signals.spawn.timeout, arg)
end

return emitter

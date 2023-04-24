-- Local
local signals = require('helpers.signal.constants.screen')


--- ### Description
--- This module contains emitters for the screen signals.
--- ### Constraints
--- - Access: read-only
--- ### Usage
--- Emitting a signal:
--- ```lua
--- local emit = require('signals.emitters.screen')
--- emit.scanning(s)
--- ```
--- Emitting a signal with arguments:
--- ```lua
--- local emit = require('signals.emitters.screen')
--- emit.added(s)
--- ```
--- @class ScreenEmitter
local emitter = {}

--- ### Description
--- Emit the `scanning` signal.
--- ### Parameters
--- @param s Screen The screen that is about to be scanned for existing screens.
--- ---
--- @see ScreenSignals.scanning
function emitter.scanning(s)
    s:emit_signal(signals.scanning)
end

--- ### Description
--- Emit the `scanned` signal.
--- ### Parameters
--- @param s Screen The screen that is done scanning for screens.
--- ---
--- @see ScreenSignals.scanned
function emitter.scanned(s)
    s:emit_signal(signals.scanned)
end

--- ### Description
--- Emit the `primary_changed` signal.
--- ### Parameters
--- @param s Screen The screen whose primary property changed.
--- ---
--- @see ScreenSignals.primary_changed
function emitter.primary_changed(s)
    s:emit_signal(signals.primary_changed)
end

--- ### Description
--- Emit the `added` signal.
--- ### Parameters
--- @param s Screen The new screen that is added to the current setup.
--- ---
--- @see ScreenSignals.added
function emitter.added(s)
    s:emit_signal(signals.added)
end

--- ### Description
--- Emit the `removed` signal.
--- ### Parameters
--- @param s Screen The screen that is removed from the setup.
--- ---
--- @see ScreenSignals.removed
function emitter.removed(s)
    s:emit_signal(signals.removed)
end

--- ### Description
--- Emit the `list` signal.
--- ### Parameters
--- @param s Screen The screen whose list of available screens changed.
--- ---
--- @see ScreenSignals.list
function emitter.list(s)
    s:emit_signal(signals.list)
end

--- ### Description
--- Emit the `swapped` signal.
--- ### Parameters
--- @param s Screen The screen that is swapped with another screen.
--- @param other_screen Screen The other screen involved in the swap.
--- @param is_source boolean If self is the source or the destination of the swap.
--- ---
--- @see ScreenSignals.swapped
function emitter.swapped(s, other_screen, is_source)
    s:emit_signal(signals.swapped, other_screen, is_source)
end

--- ### Description
--- Screen `request` namespace emitters.
emitter.request = {}

--- ### Description
--- Emit the `request::desktop_decoration` signal.
--- ### Parameters
--- @param s Screen The new screen that is added.
--- @param context string The context.
--- ---
--- @see ScreenSignalsRequest.desktop_decoration
function emitter.request.desktop_decoration(s, context)
    s:emit_signal(signals.request.desktop_decoration, context)
end

--- ### Description
--- Emit the `request::wallpaper` signal.
--- ### Parameters
--- @param s Screen The screen that needs a new wallpaper.
--- @param context string The context.
--- ---
--- @see ScreenSignalsRequest.wallpaper
function emitter.request.wallpaper(s, context)
    s:emit_signal(signals.request.wallpaper, context)
end

--- ### Description
--- Emit the `request::create` signal.
--- ### Parameters
--- @param s Screen The new (physical) screen area that has been added.
--- @param viewport table The viewport information.
--- @param args table Additional arguments including context and geometry.
--- ---
--- @see ScreenSignalsRequest.create
function emitter.request.create(s, viewport, args)
    s:emit_signal(signals.request.create, viewport, args)
end

--- ### Description
--- Emit the `request::remove` signal.
--- ### Parameters
--- @param s Screen The physical monitor viewport that has been removed.
--- @param viewport table The viewport information.
--- @param args table Additional arguments including context and geometry.
--- ---
--- @see ScreenSignalsRequest.remove
function emitter.request.remove(s, viewport, args)
    s:emit_signal(signals.request.remove, viewport, args)
end

--- ### Description
--- Emit the `request::resize` signal.
--- ### Parameters
--- @param s Screen The screen whose physical viewport resolution has changed or has been replaced.
--- @param old_viewport table The old viewport information.
--- @param new_viewport table The new viewport information.
--- @param args table Additional arguments including context and geometry.
--- ---
--- @see ScreenSignalsRequest.resize
function emitter.request.resize(s, old_viewport, new_viewport, args)
    s:emit_signal(signals.request.resize, old_viewport, new_viewport, args)
end

--- ### Description
--- Screen `tag` namespace emitters.
emitter.tag = {}

--- ### Description
--- Screen `tag::history` namespace emitters.
emitter.tag.history = {}

--- ### Description
--- Emit the `tag::history::update` signal.
--- ### Parameters
--- @param s Screen The screen whose tag history has changed.
--- ---
--- @see ScreenSignalsTagHistory.update
function emitter.tag.history.update(s)
    s:emit_signal(signals.tag.history.update)
end

--- ### Description
--- Screen `property` namespace emitters.
emitter.property = {}

--- ### Description
--- Emit the `property::viewports` signal.
--- ### Parameters
--- @param s Screen The screen whose list of physical screen viewport changes.
--- @param viewports table A table containing all physical viewports.
--- ---
--- @see ScreenSignalsProperty.viewports
function emitter.property.viewports(s, viewports)
    s:emit_signal(signals.property.viewports, viewports)
end

return emitter

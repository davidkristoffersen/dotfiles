-- Local
local signals = require('signals.constants.client')

--- ### Description
--- This module contains emitters for the client signals.
--- ### Constraints
--- - Access: read-only
--- ### Usage
--- Emitting a signal:
--- ```lua
--- local emit = require('signals.emitters.client')
--- emit.scanning(c)
--- ```
--- Emitting a signal with arguments:
--- ```lua
--- local emit = require('signals.emitters.client')
--- emit.untagged(c, c.screen.selected_tag)
--- ```
--- @class ClientEmitter
local emitter = {}

--- ### Description
--- Emit the `scanning` signal.
--- ---
--- @see ClientSignals.scanning
function emitter.scanning()
    client.emit_signal(signals.scanning)
end

--- ### Description
--- Emit the `scanned` signal.
--- ---
--- @see ClientSignals.scanned
function emitter.scanned()
    client.emit_signal(signals.scanned)
end

--- ### Description
--- Emit the `focus` signal.
--- ### Parameters
--- @param self Client The client that gains focus.
--- ---
--- @see ClientSignals.focus
function emitter.focus(self)
    self:emit_signal(signals.focus)
end

--- ### Description
--- Emit the `list` signal.
--- ###
--- @param self Client The client involved in the list event.
--- ---
--- @see ClientSignals.list
function emitter.list(self)
    self:emit_signal(signals.list)
end

--- ### Description
--- Emit the `swapped` signal.
--- ### Parameters
--- @param self Client The client that is being swapped.
--- @param other_client Client The other client involved in the swap.
--- @param is_source boolean If self is the source or the destination of the swap.
--- ---
--- @see ClientSignals.swapped
function emitter.swapped(self, other_client, is_source)
    self:emit_signal(signals.swapped, other_client, is_source)
end

--- ### Description
--- Emit the `tagged` signal.
--- ### Parameters
--- @param self Client The client that gets tagged.
--- @param t Tag The tag object.
--- ---
--- @see ClientSignals.tagged
function emitter.tagged(self, t)
    self:emit_signal(signals.tagged, t)
end

--- ### Description
--- Emit the `unfocus` signal.
--- ### Parameters
--- @param self Client The client that gets unfocused.
--- ---
--- @see ClientSignals.unfocus
function emitter.unfocus(self)
    self:emit_signal(signals.unfocus)
end

--- ### Description
--- Emit the `untagged` signal.
--- ### Parameters
--- @param self Client The client that gets untagged.
--- @param t Tag The tag object.
--- ---
--- @see ClientSignals.untagged
function emitter.untagged(self, t)
    self:emit_signal(signals.untagged, t)
end

--- ### Description
--- Emit the `raised` signal.
--- ### Parameters
--- @param self Client The client that is raised within its layer.
--- ---
--- @see ClientSignals.raised
function emitter.raised(self)
    self:emit_signal(signals.raised)
end

--- ### Description
--- Emit the `lowered` signal.
--- ### Parameters
--- @param self Client The client that is lowered within its layer.
--- ---
--- @see ClientSignals.lowered
function emitter.lowered(self)
    self:emit_signal(signals.lowered)
end

--- ### Description
--- Client `request` namespace emitters.
emitter.request = {}

--- ### Description
--- Emit the `request::manage` signal.
--- ### Parameters
--- @param self Client The new client that appears and gets managed by Awesome.
--- @param context string What created the client. It is currently either "new" or "startup".
--- @param hints table More metadata (currently empty, it exists for compliance with the other request:: signals).
--- ---
--- @see ClientSignalsRequest.manage
function emitter.request.manage(self, context, hints)
    self:emit_signal(signals.request.manage, context, hints)
end

--- ### Description
--- Emit the `request::unmanage` signal.
--- ### Parameters
--- @param self Client The client that is going away.
--- @param context string Why was the client unmanaged.
--- @param hints table More metadata (currently empty, it exists for compliance with the other request:: signals).
--- ---
--- @see ClientSignalsRequest.unmanage
function emitter.request.unmanage(self, context, hints)
    self:emit_signal(signals.request.unmanage, context, hints)
end

--- ### Description
--- Emit the `request::activate` signal.
--- ### Parameters
--- @param self Client The client that should get activated (focused and/or raised).
--- @param context string The context where this signal was used.
--- @param hints table A table with additional hints.
--- ---
--- @see ClientSignalsRequest.activate
function emitter.request.activate(self, context, hints)
    self:emit_signal(signals.request.activate, context, hints)
end

--- ### Description
--- Emit the `request::autoactivate` signal.
--- ### Parameters
--- @param self Client The client.
--- @param context string The context where this signal was used.
--- @param hints table A table with additional hints.
--- ---
--- @see ClientSignalsRequest.autoactivate
function emitter.request.autoactivate(self, context, hints)
    self:emit_signal(signals.request.autoactivate, context, hints)
end

--- ### Description
--- Emit the `request::geometry` signal.
--- ### Parameters
--- @param self Client The client whose geometry is requested to be modified.
--- @param context string Why and what to resize.
--- @param hints table Additional arguments. Each context handler may interpret this differently.
--- ---
--- @see ClientSignalsRequest.geometry
function emitter.request.geometry(self, context, hints)
    self:emit_signal(signals.request.geometry, context, hints)
end

--- ### Description
--- Emit the `request::tag` signal.
--- ### Parameters
--- @param self Client The client requesting a new tag.
--- @param tag Tag A preferred tag.
--- @param hints table Additional hints.
--- ---
--- @see ClientSignalsRequest.tag
function emitter.request.tag(self, tag, hints)
    self:emit_signal(signals.request.tag, tag, hints)
end

--- ### Description
--- Emit the `request::urgent` signal.
--- ### Parameters
--- @param self Client The client whose urgent property changed.
--- ---
--- @see ClientSignalsRequest.urgent
function emitter.request.urgent(self)
    self:emit_signal(signals.request.urgent)
end

--- ### Description
--- Emit the `request::default_mousebindings` signal.
--- ### Parameters
--- @param self Client The client for which default mousebindings are requested.
--- @param context string The reason why the signal was sent (currently always startup).
--- ---
--- @see ClientSignalsRequest.default_mousebindings
function emitter.request.default_mousebindings(self, context)
    self:emit_signal(signals.request.default_mousebindings, context)
end

--- ### Description
--- Emit the `request::default_keybindings` signal.
--- ### Parameters
--- @param self Client The client for which default keybindings are requested.
--- @param context string The reason why the signal was sent (currently always startup).
--- ---
--- @see ClientSignalsRequest.default_keybindings
function emitter.request.default_keybindings(self, context)
    self:emit_signal(signals.request.default_keybindings, context)
end

--- ### Description
--- Emit the `request::titlebars` signal.
--- ### Parameters
--- @param self Client The client that needs a titlebar.
--- @param content string The context (like "rules").
--- @param hints table Some hints.
--- ---
--- @see ClientSignalsRequest.titlebars
function emitter.request.titlebars(self, content, hints)
    self:emit_signal(signals.request.titlebars, content, hints)
end

--- ### Description
--- Emit the `request::border` signal.
--- ### Parameters
--- @param self Client The client whose border might need to be updated.
--- @param context string The context.
--- @param hints table The hints.
--- ---
--- @see ClientSignalsRequest.border
function emitter.request.border(self, context, hints)
    self:emit_signal(signals.request.border, context, hints)
end

--- ### Description
--- Client `button` namespace emitters.
emitter.button = {}

--- ### Description
--- Emit the `button::press` signal.
--- ### Parameters
--- @param self Client The client where the mouse button is pressed.
--- ---
--- @see ClientSignals.button.press
function emitter.button.press(self)
    self:emit_signal(signals.button.press)
end

--- ### Description
--- Emit the `button::release` signal.
--- ### Parameters
--- @param self Client The client where the mouse button is released.
--- ---
--- @see ClientSignals.button.release
function emitter.button.release(self)
    self:emit_signal(signals.button.release)
end

--- ### Description
--- Client `mouse` namespace emitters.
emitter.mouse = {}

--- ### Description
--- Emit the `mouse::enter` signal.
--- ### Parameters
--- @param self Client The client where the mouse enters.
--- ---
--- @see ClientSignals.mouse.enter
function emitter.mouse.enter(self)
    self:emit_signal(signals.mouse.enter)
end

--- ### Description
--- Emit the `mouse::leave` signal.
--- ### Parameters
--- @param self Client The client where the mouse leaves.
--- ---
--- @see ClientSignals.mouse.leave
function emitter.mouse.leave(self)
    self:emit_signal(signals.mouse.leave)
end

--- ### Description
--- Emit the `mouse::move` signal.
--- ### Parameters
--- @param self Client The client where the mouse moves within.
--- ---
--- @see ClientSignals.mouse.move
function emitter.mouse.move(self)
    self:emit_signal(signals.mouse.move)
end

--- ### Description
--- Client `property` namespace emitters.
emitter.property = {}

--- ### Description
--- Emit the `property::floating_geometry` signal.
--- ### Parameters
--- @param self Client The client whose floating geometry property has changed.
function emitter.property.floating_geometry(self)
    self:emit_signal('property::floating_geometry')
end

return emitter

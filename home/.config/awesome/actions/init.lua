-- Local
local client = require('actions.client')


--- @class AKeyData : table
--- @field mod Modifier[] List of modifiers.
--- @field keys string[] List of keys.
--- @field on_press function Function to run when the keybinding is pressed.
--- @field on_release function Function to run when the keybinding is released.
--- @field description string Description of the keybinding.
--- @field group string Group of the keybinding.

--- @class InnerKeyCb Inner.
--- @field [1] function Callback function.
--- @field [2] AKeyData? Keybinding data.
--- @field args table? List of arguments.

--- @class OuterKeyCb Outer.
--- @field [1] InnerKeyCb Inner.
--- @field args table List of arguments.

--- @alias KeyCb InnerKeyCb | OuterKeyCb

--- @alias Keytable table<string, KeyCb>

--- @class KeyComb : table
--- @field [1] Modifier[] List of modifiers.
--- @field [2] string? Key name.


return {
    client = client,
}

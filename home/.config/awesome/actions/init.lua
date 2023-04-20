--- @diagnostic disable: duplicate-doc-alias

-- Local
local global = require('actions.global')
local client = require('actions.client')
local mouse = require('actions.mouse')


--#region Keytable

--- ### Description (Awful key binding data)
--- Awful key binding data
--- @class AKeyData : table
--- @field mod AwfulModifier[] List of modifiers.
--- @field keys string[] List of keys.
--- @field on_press function Function to run when the keybinding is pressed.
--- @field on_release function Function to run when the keybinding is released.
--- @field description string Description of the keybinding.
--- @field group string Group of the keybinding.


--- ### Description (Awful key binding action data)
--- Awful key binding data
--- @class AKeyDataCb : AKeyData
--- @field [1] string Description of the keybinding.
--- @field [2] string Group of the keybinding.

--- ### Description (Function key callback)
--- A function key callback:
--- - Vararg: `T`
--- - Returns: `nil`
--- ### Usage
--- ```lua
--- --- @type KeyCb<Client>
--- local var = function (c) c:kill() end
--- ```
--- @alias FunctionKeyCb<T> fun (...: T): nil

--- @alias FunctionKeyCb FunctionKeyCb<any>

--- ### Description (Inner key Callback)
--- An inner key callback is a table with the following fields:
--- - `f|[1]`: `FunctionKeyCb`
--- - `d|[1]|[2]`: `AKeyDataCb?`
--- ### Usage
--- ```lua
--- --- @type KeyCb<Client>
--- local var = {
---     f = function (c) c:kill() end,
---     d = {'close', 'client'},
--- }
--- ```
--- ### Type priority
--- __1.__ `f` and `d`
--- ```lua
--- {f: fun (...: T): (nil), d: AKeyDataCb}
--- ```
--- __2.__ `f` and `[1]`
--- ```lua
--- {f: fun (...: T): (nil), [1]: AKeyDataCb}
--- ```
--- __3.__ `[1]` and `d`
--- ```lua
--- {[1]: fun (...: T): (nil), d: AKeyDataCb}
--- ```
--- __4.__ `[1]` and `[2]`
--- ```lua
--- {[1]: fun (...: T): (nil), [2]: AKeyDataCb}
--- ```
--- @alias InnerKeyCb<T>
--- | {f: fun (...: T): (nil), d: AKeyDataCb, [1]: fun (...: T): (nil) | AKeyDataCb, [2]: AKeyDataCb}

--- @alias InnerKeyCb InnerKeyCb<any>

--- ### Description (Outer key Callback)
--- An outer key callback is a table with the following fields:
--- - `inner`: `InnerKeyCb`
--- - `args`: `table`
--- ### Usage
--- ```lua
--- --- @type KeyCb<Client>
--- local var = {
---     innerKeyCb,
---     args = {num = 42},
--- }
--- ```
--- @alias OuterKeyCb<T>
--- | {inner: {f: fun (...: T): (nil), d: AKeyDataCb, [1]: fun (...: T): (nil) | AKeyDataCb, [2]: AKeyDataCb}, args: table?}

--- @alias OuterKeyCb OuterKeyCb<any>

--- ### Description (Key Callback)
--- A key callback with the type: `FunctionKeyCb | InnerKeyCb | OuterKeyCb`
--- ### Type priority
--- __1.__ Function
--- ```lua
--- fun (...: T): (nil)
--- ```
--- __2.__ Inner key callback
--- ```lua
--- {(f|[1]): fun (...: T): (nil), (d|[1]|[2]): AKeyDataCb}
--- ```
--- __3.__ Outer key callback
--- ```lua
--- {inner: {(f|[1]): fun (...: T): (nil), (d|[1]|[2]): AKeyDataCb}, args: table?}
--- ```
--- ### Usage
--- `FunctionKeyCb`:
--- ```lua
--- --- @type KeyCb<Client>
--- local var = function (c) c:kill() end
--- ```
--- `InnerKeyCb`:
--- ```lua
--- --- @type KeyCb<Client>
--- local var = {
---     f = function (c) c:kill() end,
---     d = {'close', 'client'},
--- }
--- ```
--- `OuterKeyCb`:
--- ```lua
--- --- @type KeyCb<Client>
--- local var = {
---     inner = {
---         f = function (c) c:kill() end,
---         d = {'close', 'client'},
---     },
---     args = {num = 42},
--- }
--- ```
--- @alias KeyCb<T> fun (...: T): (nil) | {f: fun (...: T): (nil), d: AKeyDataCb, [1]: fun (...: T): (nil) | AKeyDataCb, [2]: AKeyDataCb} | {inner: {f: fun (...: T): (nil), d: AKeyDataCb, [1]: fun (...: T): (nil) | AKeyDataCb, [2]: AKeyDataCb}, args: table?} | {inner: KeyCb<T>}

--- @alias KeyCb KeyCb<any>

--- ### Description (Keytable)
--- A keytable is a dictionary mapping key string names to a key callback.
--- @alias Keytable { [string]: KeyCb }

--- ### Description (Key combination)
--- A key combination is an array of modifiers and a key name.
--- @class KeyComb
--- @field [1] AwfulModifier[] List of modifiers.
--- @field [2] string? Key name.

--#endregion


return {
    global = global,
    client = client,
    mouse = mouse,
}

---@meta
---@class client

---@module 'gears'
local gears

--- The X window id.
---@type integer
---## Constraints
--- - Access: read-only
--- - Default value: This is generated by X11.
--- - Negative allowed: false
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#window)
client.window = nil

--- The client title.
---@type string
---## Constraints
--- - Default value: This is provided by the application.
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#name)
client.name = nil

--- True if the client does not want to be in taskbar.
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#skip_taskbar)
client.skip_taskbar = false

--- The window type.
---@type string
---## Constraints
--- - Access: read-only
--- - Default value: This is provided by the application.
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#type)
client.type = nil

--- The client class.
---@type string
---## Constraints
--- - Access: read-only
--- - Default value: This is provided by the application.
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#class)
client.class = nil

--- The client instance.
---@type string
---## Constraints
--- - Access: read-only
--- - Default value: This is provided by the application.
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#instance)
client.instance = nil

--- The client PID, if available.
---@type integer
---## Constraints
--- - Access: read-only
--- - Default value: This is randomly assigned by the kernel.
--- - Negative allowed: false
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#pid)
client.pid = nil

--- The window role, if available.
---@type string
---## Constraints
--- - Access: read-only
--- - Default value: This is provided by the application.
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#role)
client.role = nil

--- The machine the client is running on.
---@type string
---## Constraints
--- - Access: read-only
--- - Default value: This is the hostname unless the client is from an SSH session or using the rarely used direct X11 network socket.
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#machine)
client.machine = nil

--- The client name when iconified.
---@type string
---## Constraints
--- - Default value: This is provided by the application.
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#icon_name)
client.icon_name = nil

---@alias image
---| 'string' # Interpreted as a path to an image file.
---| 'string' # A valid SVG content.
---| 'cairo.surface' # A cairo image surface: Directly used as-is.
---| 'librsvg' # A librsvg handle object: Directly used as-is.
---| 'nil' # Unset the image.

--- The client icon as a surface.
---@type image
---## Constraints
--- - Default value: This is provided by the application.
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#icon)
client.icon = nil

--- The available sizes of client icons.
---@type integer[][]
---## Constraints
--- - Access: read-only
--- - Default value: This is provided by the application.
--- - Table content: A list of tables. Each table has the following rows:
---   - __[1]__: The width value.
---   - __[2]__: The height value.
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#icon_sizes)
client.icon_sizes = nil

--- Client screen.
---
---# TODO Fix type after screen.lua is typed
---@type screen
---## Constraints
--- - Default value: This usually correspond to where the top-left (or other gravities) is placed. Then it is mapped to the screen `geometry`.
--- - Type description:
---   - screen: A valid screen object such as retured by `awful.screen.focused()` or mouse.screen.
---   - integer: A screen global id. Avoid using this since they are unsorted.
---   - string: The `"primary"` value is also valid.
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#screen)
client.screen = nil

--- Define if the client must be hidden (Never mapped, invisible in taskbar).
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#hidden)
client.hidden = false

--- Define if the client must be iconified (Only visible in taskbar).
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#minimized)
client.minimized = false

--- Honor size hints, e.g. respect size ratio.
---@type boolean
---## Constraints
--- - Default value: `true`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#size_hints_honor)
client.size_hints_honor = true

--- The client border width.
---@type integer|nil
---## Constraints
--- - Default value: `nil`
--- - Type description:
---   - nil: Let AwesomeWM manage it based on the client state.
--- - Unit: pixel
--- - Negative allowed: false
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#border_width)
client.border_width = nil

--- The client border color.
---@diagnostic disable-next-line: undefined-doc-name
---@alias border_color string|table|cairo.pattern
---@type border_color|nil
---## Constraints
--- - Default value: nil
--- - Type description: nil: Let AwesomeWM manage it based on the client state.
---   - string: An hexadecimal color code, such as `"#ff0000"` for red.
---   - string: A color name, such as `"red"`.
---   - table: A [gradient table](https://awesomewm.org/apidoc/theme_related_libraries/gears.color.html).
---   - cairo.pattern: Any valid [Cairo pattern](https://cairographics.org/manual/cairo-cairo-pattern-t.html).
---   - cairo.pattern: A texture build from an image by [gears.color.create_png_pattern](https://awesomewm.org/apidoc/theme_related_libraries/gears.color.html#create_png_pattern)
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#border_color)
client.border_color = nil

--- Set to `true` when the client ask for attention.
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#urgent)
client.urgent = false

--- A cairo surface for the client window content.
---@diagnostic disable-next-line: undefined-doc-name
---@alias raw_curface cairo.surface
---@type raw_curface
---## Constraints
--- - Access: read-only
--- - Default value: This is a live surface. Always use [gears.surface](https://awesomewm.org/apidoc/libraries/gears.surface.html) to take a snapshot.
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#content)
client.content = nil

--- The client opacity.
---@type number
---## Constraints
--- - Default value: `1.0`
--- - Minimum value: 0.0 Transparent.
--- - Maximum value: 1.0 Opaque.
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#opacity)
client.opacity = 1.0

--- The client is on top of every other windows.
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#ontop)
client.ontop = false

--- The client is above normal windows.
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#above)
client.above = false

--- The client is below normal windows.
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#below)
client.below = false

--- The client is fullscreen or not.
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#fullscreen)
client.fullscreen = false

--- The client is maximized (horizontally and vertically) or not.
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#maximized)
client.maximized = false

--- The client is maximized horizontally or not.
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#maximized_horizontal)
client.maximized_horizontal = false

--- The client is maximized vertically or not.
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#maximized_vertical)
client.maximized_vertical = false

--- The client the window is transient for.
---@type client|nil
---## Constraints
--- - Access: read-only
--- - Default value: `nil`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#transient_for)
client.transient_for = nil

--- Window identification unique to a group of windows.
---@type integer
---## Constraints
--- - Access: read-only
--- - Default value: auto-generated by X11
--- - Negative allowed: false
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#group_window)
client.group_window = nil

--- Identification unique to windows spawned by the same command.
---@type integer
---## Constraints
--- - Access: read-only
--- - Default value: auto-generated by X11
--- - Negative allowed: false
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#leader_window)
client.leader_window = nil

---@class size_hints
---@field user_position table|nil A table with `x` and `y` keys. It contains the preferred position of the client. This is set when the position has been modified by the user. See `program_position`
---@field program_position table|nil A table with `x` and `y` keys. It contains the preferred position of the client. This is set when the position has been modified by the program. See `user_position`
---@field user_size table|nil A table with `width` and `height` keys. It contains the preferred size of the client. This is set when the size has been modified by the user. See `program_size`
---@field program_size table|nil A table with `width` and `height`. This contains the preferred size as specified by the application.
---@field max_width integer|nil The maximum width (in pixels).
---@field max_height integer|nil The maximum height (in pixels).
---@field min_width integer|nil The minimum width (in pixels).
---@field min_height integer|nil The minimum height (in pixels).
---@field width_inc integer|nil The number of pixels by which the client width may be increased or decreased. For example, for terminals, the size has to be proportional with the monospace font size
---@field height_inc integer|nil The number of pixels by which the client height may be increased or decreased. For example, for terminals, the size has to be proportional with the monospace font size
---@field win_gravity string|nil The client `gravity` defines the corder from which the size is computed. For most clients, it is `north_west`, which corresponds to the top-left of the window. This will affect how the client is resized and other size related operations.
---@field min_aspect_num integer|nil
---@field min_aspect_den integer|nil
---@field max_aspect_num integer|nil
---@field max_aspect_den integer|nil
---@field base_width integer|nil
---@field base_height integer|nil

--- A table with size hints of the client.
---@type size_hints|nil
---## Constraints
--- - Access: read-only
--- - Default value: nil
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#size_hints)
client.size_hints = nil

---@class motif_wm_hints_funcs
---@field all boolean
---@field resize boolean
---@field move boolean
---@field minimize boolean
---@field maximize boolean
---@field close boolean

---@class motif_wm_hints_decs
---@field all boolean
---@field border boolean
---@field resizeh boolean
---@field title boolean
---@field menu boolean
---@field minimize boolean
---@field maximize boolean

---@class motif_wm_hints
---@field functions motif_wm_hints_funcs
---@field decorations motif_wm_hints_decs
---@field input_mode string This is either `modeless`, `primary_application_modal`, `system_modal`, `full_application_modal` or `unknown`.
---@field status table A table with the following keys:
---@field status.tearoff_window boolean

--- The motif WM hints of the client.
---@type motif_wm_hints
---## Constraints
--- - Access: read-only
--- - Default value: {}
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#motif_wm_hints)
client.motif_wm_hints = {}

--- Set the client sticky (available on all tags).
---@type boolean
---## Constraints
--- - Access: read-only
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#sticky)
client.sticky = false

--- Indicate if the client is modal.
---@type boolean
---## Constraints
--- - Access: read-only
--- - Default value: provided by the application
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#modal)
client.modal = nil

--- True if the client can receive the input focus.
---@type boolean
---## Constraints
--- - Access: read-only
--- - Default value: `true`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#focusable)
client.focusable = true

--- The client's bounding shape as set by awesome as a (native) cairo surface.
---@type image
---## Constraints
--- - Access: read-only
--- - Default value: An A1 surface where all pixels are white.
-- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#shape_bounding)
client.shape_bounding = nil

--- The client's clip shape as set by awesome as a (native) cairo surface.
---@type image
---## Constraints
--- - Access: read-only
--- - Default value: An A1 surface where all pixels are white.
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#shape_clip)
client.shape_clip = nil

--- The client's input shape as set by awesome as a (native) cairo surface.
---@type image
---## Constraints
--- - Access: read-only
--- - Default value: An A1 surface where all pixels are white.
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#shape_input)
client.shape_input = nil

--- The client's bounding shape as set by the program as a (native) cairo surface.
---@type image
---## Constraints
--- - Access: read-only
--- - Default value: An A1 surface where all pixels are white
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#client_shape_bounding)
client.client_shape_bounding = nil

--- The client's clip shape as set by the program as a (native) cairo surface.
---@type image
---## Constraints
--- - Access: read-only
--- - Default value: An A1 surface where all pixels are white
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#client_shape_clip)
client.client_shape_clip = nil

--- The FreeDesktop StartId.
---@type string
---## Constraints
--- - Default value: This is optionally provided by the application
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#startup_id)
client.startup_id = nil

--- If the client that this object refers to is still managed by awesome.
---@type boolean
---## Constraints
--- - Access: read-only
--- - Default value: `true`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#valid)
client.valid = true

--- The first tag of the client.
---
---# TODO Fix type after tag.lua is typed
---@type tag|nil
---## Constraints
--- - Access: read-only
--- - Default value: `nil`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#first_tag)
client.first_tag = nil

--- Get or set mouse buttons bindings for a client.
---@type table
---## Constraints
--- - Default value: `{}`
--- - Table content: A list of `awful.buttons` objects
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#buttons)
client.buttons = {}

--- Get or set keys bindings for a client.
---@type table
---## Constraints
--- - Default value: {}
--- - Table content: A list of `awful.keys` objects
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#keys)
client.keys = {}

--- If a client is marked or not.
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#marked)
client.marked = false

--- Return if a client has a fixed size or not.
---@type boolean
---## Constraints
--- - Access: read-only
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#is_fixed)
client.is_fixed = false

--- Is the client immobilized horizontally?
---@type boolean
---## Constraints
--- - Access: read-only
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#immobilized_horizontal)
client.immobilized_horizontal = false

--- Is the client immobilized vertically?
---@type boolean
---## Constraints
--- - Access: read-only
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#immobilized_vertical)
client.immobilized_vertical = false

--- The client floating state.
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#floating)
client.floating = false

--- The x coordinates.
---
---@type integer
---## Constraints
--- - Default value: `c:geometry().x`
--- - Negative allowed: true
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#x)
client.x = client:geometry().x

--- The y coordinates.
---
---@type integer
---## Constraints
--- - Default value: `c:geometry().y`
--- - Negative allowed: true
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#y)
client.y = client:geometry().y

--- The width of the client.
---
---@type integer
---## Constraints
--- - Default value: `c:geometry().width`
--- - Minimum value: 1
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#width)
client.width = client:geometry().width

--- The height of the client.
---
---@type integer
---## Constraints
--- - Default value: `c:geometry().height`
--- - Minimum value: 1
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#height)
client.height = client:geometry().height

--- If the client is dockable.
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: `true` or `false`
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#dockable)
client.dockable = false

--- If the client requests not to be decorated with a titlebar.
---@type boolean
---## Constraints
--- - Default value: `false`
--- - Valid values: Whether the client requests not to get a titlebar
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#requests_no_titlebar)
client.requests_no_titlebar = false

---@alias gears.shape function(cr:cairo.Context, width:integer, height: integer)

--- Set the client shape.
---@type gears.shape
---## Constraints
--- - Default value: `gears.shape.rectangle`
--- - Valid values: A gears.shape compatible function
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#shape)
client.shape = gears.shape.rectangle

--- Return true if the client is active (has focus).
---@type boolean
---## Constraints
--- - Access: read-only
--- - Default value: `true`
--- - Valid values: `true` or `false`
--- ---
--- [**View doc**](https://awesomewm.org/apidoc/core_components/client.html#active)
client.active = false
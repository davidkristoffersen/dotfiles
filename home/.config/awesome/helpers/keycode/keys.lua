--- Mouse buttons
--- @type { [string]: string }
local mouse = {
    b_left   = 'B1', -- Left mouse button
    b_middle = 'B2', -- Middle mouse button
    b_right  = 'B3', -- Right mouse button
    b_up     = 'B4', -- Scroll Up
    b_down   = 'B5', -- Scroll Down
}

--- Numeric keys 0-9
--- @type { [string]: string }
local number = {
    _0 = '0', -- 0
    _1 = '1', -- 1
    _2 = '2', -- 2
    _3 = '3', -- 3
    _4 = '4', -- 4
    _5 = '5', -- 5
    _6 = '6', -- 6
    _7 = '7', -- 7
    _8 = '8', -- 8
    _9 = '9', -- 9
}

--- Alphabet keys A-Z, a-z
--- @type { [string]: string }
local letter = {
    a      = 'a',      -- a
    b      = 'b',      -- b
    c      = 'c',      -- c
    d      = 'd',      -- d
    e      = 'e',      -- e
    f      = 'f',      -- f
    g      = 'g',      -- g
    h      = 'h',      -- h
    i      = 'i',      -- i
    j      = 'j',      -- j
    k      = 'k',      -- k
    l      = 'l',      -- l
    m      = 'm',      -- m
    n      = 'n',      -- n
    o      = 'o',      -- o
    p      = 'p',      -- p
    q      = 'q',      -- q
    r      = 'r',      -- r
    s      = 's',      -- s
    t      = 't',      -- t
    u      = 'u',      -- u
    v      = 'v',      -- v
    w      = 'w',      -- w
    x      = 'x',      -- x
    y      = 'y',      -- y
    z      = 'z',      -- z
    ae     = 'ae',     -- æ
    oslash = 'oslash', -- ø
    aring  = 'aring',  -- å
}

--- Punctuation keys and symbols
--- @type { [string]: string }
local punctuation = {
    apostrophe = 'apostrophe', -- '
    backslash  = 'backslash',  -- \
    bar        = 'bar',        -- |
    comma      = 'comma',      -- ,
    diaeresis  = 'diaeresis',  -- ¨
    less       = 'less',       -- <
    minus      = 'minus',      -- -
    parenleft  = 'parenleft',  -- (
    parenright = 'parenright', -- )
    period     = 'period',     -- .
    plus       = 'plus',       -- +
    plusminus  = 'plusminus',  -- ±
    space      = 'space',      -- (space)
    tab        = 'tab',        -- ⇥
}

--- Function keys F1-F12
--- @type { [string]: string }
local fn = {
    f1  = 'F1',  -- F1
    f2  = 'F2',  -- F2
    f3  = 'F3',  -- F3
    f4  = 'F4',  -- F4
    f5  = 'F5',  -- F5
    f6  = 'F6',  -- F6
    f7  = 'F7',  -- F7
    f8  = 'F8',  -- F8
    f9  = 'F9',  -- F9
    f10 = 'F10', -- F10
    f11 = 'F11', -- F11
    f12 = 'F12', -- F12
}

--- Modifier keys like Shift, Control, Alt
--- @type { [string]: string }
local modifier = {
    alt_l            = 'Alt_L',            -- Alt Left
    control_l        = 'Control_L',        -- Ctrl Left
    control_r        = 'Control_R',        -- Ctrl Right
    iso_level3_shift = 'ISO_Level3_Shift', -- AltGr
    iso_level5_shift = 'ISO_Level5_Shift', -- Level5 Shift
    shift_l          = 'Shift_L',          -- Shift Left
    shift_r          = 'Shift_R',          -- Shift Right
    super_l          = 'Super_L',          -- Super Left
    super_r          = 'Super_R',          -- Super Right
}

--- Navigation keys like arrows, Home, End
--- @type { [string]: string }
local navigation = {
    backspace   = 'BackSpace',   -- ⌫
    caps_lock   = 'Caps_Lock',   -- ⇪
    delete      = 'Delete',      -- ⌦
    down        = 'Down',        -- ↓
    end_        = 'End',         -- End
    escape      = 'Escape',      -- ⎋
    home        = 'Home',        -- Home
    insert      = 'Insert',      -- Insert
    left        = 'Left',        -- ←
    linefeed    = 'Linefeed',    -- ␊
    menu        = 'Menu',        -- Menu
    next        = 'Next',        -- PgDn
    num_lock    = 'Num_Lock',    -- Num Lock
    pause       = 'Pause',       -- Pause
    prior       = 'Prior',       -- PgUp
    redo        = 'Redo',        -- Redo
    return_     = 'Return',      -- ↵
    right       = 'Right',       -- →
    scroll_lock = 'Scroll_Lock', -- Scroll Lock
    up          = 'Up',          -- ↑
}

--- Numeric keypad and related keys
--- @type { [string]: string }
local keypad = {
    kp_add      = 'KP_Add',      -- +
    kp_begin    = 'KP_Begin',    -- Begin
    kp_decimal  = 'KP_Decimal',  -- .
    kp_delete   = 'KP_Delete',   -- Del
    kp_divide   = 'KP_Divide',   -- ÷
    kp_down     = 'KP_Down',     -- ↓
    kp_end      = 'KP_End',      -- End
    kp_enter    = 'KP_Enter',    -- ↵
    kp_equal    = 'KP_Equal',    -- =
    kp_home     = 'KP_Home',     -- Home
    kp_insert   = 'KP_Insert',   -- Ins
    kp_left     = 'KP_Left',     -- ←
    kp_multiply = 'KP_Multiply', -- ×
    kp_next     = 'KP_Next',     -- PgDn
    kp_prior    = 'KP_Prior',    -- PgUp
    kp_right    = 'KP_Right',    -- →
    kp_subtract = 'KP_Subtract', -- -
    kp_up       = 'KP_Up',       -- ↑
}

--- Miscellaneous keys like Esc, Enter, Tab
--- @type { [string]: string }
local misc = {
    find  = 'Find',  -- Find
    help  = 'Help',  -- Help
    print = 'Print', -- Print
    undo  = 'Undo',  -- Undo
}

--- Language input and character conversion keys
--- @type { [string]: string }
local language = {
    hangul            = 'Hangul',            -- 한글
    hangul_hanja      = 'Hangul_Hanja',      -- 한자
    henkan_mode       = 'Henkan_Mode',       -- 変換
    hiragana          = 'Hiragana',          -- ひらがな
    hiragana_katakana = 'Hiragana_Katakana', -- ひらがな/カタカナ
    katakana          = 'Katakana',          -- カタカナ
    muhenkan          = 'Muhenkan',          -- 無変換
}

--- Multimedia and system control keys
--- @type { [string]: string }
local xf86 = {
    xf86audioforward       = 'XF86AudioForward',       -- ⏩
    xf86audiolowervolume   = 'XF86AudioLowerVolume',   -- 🔉
    xf86audiomedia         = 'XF86AudioMedia',         -- 🎵
    xf86audiomicmute       = 'XF86AudioMicMute',       -- 🎤
    xf86audiomute          = 'XF86AudioMute',          -- 🔇
    xf86audionext          = 'XF86AudioNext',          -- ⏭️
    xf86audiopause         = 'XF86AudioPause',         -- ⏸️
    xf86audioplay          = 'XF86AudioPlay',          -- ▶️
    xf86audiopreset        = 'XF86AudioPreset',        -- 🎛️
    xf86audioprev          = 'XF86AudioPrev',          -- ⏮️
    xf86audioraisevolume   = 'XF86AudioRaiseVolume',   -- 🔊
    xf86audiorecord        = 'XF86AudioRecord',        -- ⏺️
    xf86audiorewind        = 'XF86AudioRewind',        -- ⏪
    xf86audiostop          = 'XF86AudioStop',          -- ⏹️
    xf86back               = 'XF86Back',               -- 🔙
    xf86battery            = 'XF86Battery',            -- 🔋
    xf86bluetooth          = 'XF86Bluetooth',          -- 📶
    xf86brightnessauto     = 'XF86BrightnessAuto',     -- 💡
    xf86calculator         = 'XF86Calculator',         -- 🧮
    xf86close              = 'XF86Close',              -- ❌
    xf86copy               = 'XF86Copy',               -- 📋
    xf86cut                = 'XF86Cut',                -- ✂️
    xf86display            = 'XF86Display',            -- 🖥️
    xf86displayoff         = 'XF86DisplayOff',         -- 🌙
    xf86documents          = 'XF86Documents',          -- 📄
    xf86dos                = 'XF86DOS',                -- 💾
    xf86eject              = 'XF86Eject',              -- ⏏️
    xf86explorer           = 'XF86Explorer',           -- 🗺️
    xf86favorites          = 'XF86Favorites',          -- 🌟
    xf86finance            = 'XF86Finance',            -- 💰
    xf86forward            = 'XF86Forward',            -- 🔜
    xf86game               = 'XF86Game',               -- 🎮
    xf86go                 = 'XF86Go',                 -- 🎯
    xf86homepage           = 'XF86HomePage',           -- 🏠
    xf86kbdbrightnessdown  = 'XF86KbdBrightnessDown',  -- 🌒
    xf86kbdbrightnessup    = 'XF86KbdBrightnessUp',    -- 🌔
    xf86kbdlightonoff      = 'XF86KbdLightOnOff',      -- 💡
    xf86launch1            = 'XF86Launch1',            -- 🚀1️⃣
    xf86launch2            = 'XF86Launch2',            -- 🚀2️⃣
    xf86launch3            = 'XF86Launch3',            -- 🚀3️⃣
    xf86launch4            = 'XF86Launch4',            -- 🚀4️⃣
    xf86launch5            = 'XF86Launch5',            -- 🚀5️⃣
    xf86launch6            = 'XF86Launch6',            -- 🚀6️⃣
    xf86launch7            = 'XF86Launch7',            -- 🚀7️⃣
    xf86launch8            = 'XF86Launch8',            -- 🚀8️⃣
    xf86launch9            = 'XF86Launch9',            -- 🚀9️⃣
    xf86launcha            = 'XF86LaunchA',            -- 🚀A️
    xf86launchb            = 'XF86LaunchB',            -- 🚀B️
    xf86mail               = 'XF86Mail',               -- ✉️
    xf86mailforward        = 'XF86MailForward',        -- 📩
    xf86menuekb            = 'XF86MenuKB',             -- 📚
    xf86messenger          = 'XF86Messenger',          -- 💬
    xf86monbrightnesscycle = 'XF86MonBrightnessCycle', -- ☀️
    xf86monbrightnessdown  = 'XF86MonBrightnessDown',  -- 🌘
    xf86monbrightnessup    = 'XF86MonBrightnessUp',    -- 🌖
    xf86mycomputer         = 'XF86MyComputer',         -- 🖥️
    xf86new                = 'XF86New',                -- 🆕
    xf86nextvmode          = 'XF86Next_VMode',         -- 🔁
    xf86open               = 'XF86Open',               -- 📂
    xf86paste              = 'XF86Paste',              -- 📄
    xf86phone              = 'XF86Phone',              -- 📞
    xf86poweroff           = 'XF86PowerOff',           -- ⏻
    xf86prevvmode          = 'XF86Prev_VMode',         -- ↩️
    xf86reload             = 'XF86Reload',             -- 🔃
    xf86reply              = 'XF86Reply',              -- ↩️
    xf86rfkill             = 'XF86RFKill',             -- 📡
    xf86rotatewindows      = 'XF86RotateWindows',      -- 🔄
    xf86save               = 'XF86Save',               -- 💾
    xf86screensaver        = 'XF86ScreenSaver',        -- 🛡️
    xf86scrolldown         = 'XF86ScrollDown',         -- ⏬
    xf86scrollup           = 'XF86ScrollUp',           -- ⏫
    xf86search             = 'XF86Search',             -- 🔍
    xf86send               = 'XF86Send',               -- 📤
    xf86shop               = 'XF86Shop',               -- 🛍️
    xf86sleep              = 'XF86Sleep',              -- 💤
    xf86suspend            = 'XF86Suspend',            -- ⏸️
    xf86taskpane           = 'XF86TaskPane',           -- 📑
    xf86tools              = 'XF86Tools',              -- 🔧
    xf86touchpadoff        = 'XF86TouchpadOff',        -- 🚫
    xf86touchpadon         = 'XF86TouchpadOn',         -- ✅
    xf86touchpadtoggle     = 'XF86TouchpadToggle',     -- ↔️
    xf86uwb                = 'XF86UWB',                -- 📡
    xf86wakeup             = 'XF86WakeUp',             -- ⏰
    xf86webcam             = 'XF86WebCam',             -- 📷
    xf86wlan               = 'XF86WLAN',               -- 📶
    xf86wwan               = 'XF86WWAN',               -- 🌐
    xf86www                = 'XF86WWW',                -- 🌐
    xf86xfer               = 'XF86Xfer',               -- 💼
}


return {
    mouse       = mouse,       -- Mouse buttons
    number      = number,      -- Numeric keys 0-9
    letter      = letter,      -- Alphabet keys A-Z, a-z
    punctuation = punctuation, -- Punctuation keys and symbols
    fn          = fn,          -- Function keys F1-F12
    modifier    = modifier,    -- Modifier keys like Shift, Control, Alt
    navigation  = navigation,  -- Navigation keys like arrows, Home, End
    keypad      = keypad,      -- Numeric keypad and related keys
    misc        = misc,        -- Miscellaneous keys like Esc, Enter, Tab
    language    = language,    -- Language input and character conversion keys
    xf86        = xf86,        -- Multimedia and system control keys
}

import itertools
from typing import Dict, List, OrderedDict, Tuple, cast

from attr import dataclass

_mouse = [
    ("b_left", "B1", "Left mouse button(1)"),
    ("b_middle", "B2", "Middle mouse button(2)"),
    ("b_right", "B3", "Right mouse button(3)"),
    ("b_up", "B4", "Scroll Up(4)"),
    ("b_down", "B5", "Scroll Down(5)"),
]

_number = [
    ("_0", "0", "0"),
    ("_1", "1", "1"),
    ("_2", "2", "2"),
    ("_3", "3", "3"),
    ("_4", "4", "4"),
    ("_5", "5", "5"),
    ("_6", "6", "6"),
    ("_7", "7", "7"),
    ("_8", "8", "8"),
    ("_9", "9", "9"),
]

_letter = [
    ("a", "a", "a"),
    ("b", "b", "b"),
    ("c", "c", "c"),
    ("d", "d", "d"),
    ("e", "e", "e"),
    ("f", "f", "f"),
    ("g", "g", "g"),
    ("h", "h", "h"),
    ("i", "i", "i"),
    ("j", "j", "j"),
    ("k", "k", "k"),
    ("l", "l", "l"),
    ("m", "m", "m"),
    ("n", "n", "n"),
    ("o", "o", "o"),
    ("p", "p", "p"),
    ("q", "q", "q"),
    ("r", "r", "r"),
    ("s", "s", "s"),
    ("t", "t", "t"),
    ("u", "u", "u"),
    ("v", "v", "v"),
    ("w", "w", "w"),
    ("x", "x", "x"),
    ("y", "y", "y"),
    ("z", "z", "z"),
    ("ae", "ae", "æ"),
    ("oslash", "oslash", "ø"),
    ("aring", "aring", "å"),
]

_punctuation = [
    ("apostrophe", "apostrophe", "'"),
    ("backslash", "backslash", "\\"),
    ("bar", "bar", "|"),
    ("comma", "comma", ","),
    ("diaeresis", "diaeresis", "¨"),
    ("less", "less", "<"),
    ("minus", "minus", "-"),
    ("parenleft", "parenleft", "("),
    ("parenright", "parenright", ")"),
    ("period", "period", "."),
    ("plus", "plus", "+"),
    ("plusminus", "plusminus", "±"),
    ("space", "space", "(space)"),
    ("tab", "tab", "⇥"),
]

_modifier = [
    ("alt_l", "Alt_L", "Alt Left"),
    ("control_l", "Control_L", "Ctrl Left"),
    ("control_r", "Control_R", "Ctrl Right"),
    ("iso_level3_shift", "ISO_Level3_Shift", "AltGr"),
    ("iso_level5_shift", "ISO_Level5_Shift", "Level5 Shift"),
    ("shift_l", "Shift_L", "Shift Left"),
    ("shift_r", "Shift_R", "Shift Right"),
    ("super_l", "Super_L", "Super Left"),
    ("super_r", "Super_R", "Super Right"),
]

_navigation = [
    ("backspace", "BackSpace", "⌫"),
    ("caps_lock", "Caps_Lock", "⇪"),
    ("delete", "Delete", "⌦"),
    ("down", "Down", "↓"),
    ("end_", "End", "End"),
    ("escape", "Escape", "⎋"),
    ("home", "Home", "Home"),
    ("insert", "Insert", "Insert"),
    ("left", "Left", "←"),
    ("linefeed", "Linefeed", "␊"),
    ("menu", "Menu", "Menu"),
    ("next", "Next", "PgDn"),
    ("num_lock", "Num_Lock", "Num Lock"),
    ("pause", "Pause", "Pause"),
    ("prior", "Prior", "PgUp"),
    ("redo", "Redo", "Redo"),
    ("return_", "Return", "↵"),
    ("right", "Right", "→"),
    ("scroll_lock", "Scroll_Lock", "Scroll Lock"),
    ("up", "Up", "↑"),
]

_fn = [
    ("f1", "F1", "F1"),
    ("f2", "F2", "F2"),
    ("f3", "F3", "F3"),
    ("f4", "F4", "F4"),
    ("f5", "F5", "F5"),
    ("f6", "F6", "F6"),
    ("f7", "F7", "F7"),
    ("f8", "F8", "F8"),
    ("f9", "F9", "F9"),
    ("f10", "F10", "F10"),
    ("f11", "F11", "F11"),
    ("f12", "F12", "F12"),
]

_keypad = [
    ("kp_add", "KP_Add", "+"),
    ("kp_begin", "KP_Begin", "Begin"),
    ("kp_decimal", "KP_Decimal", "."),
    ("kp_delete", "KP_Delete", "Del"),
    ("kp_divide", "KP_Divide", "÷"),
    ("kp_down", "KP_Down", "↓"),
    ("kp_end", "KP_End", "End"),
    ("kp_enter", "KP_Enter", "↵"),
    ("kp_equal", "KP_Equal", "="),
    ("kp_home", "KP_Home", "Home"),
    ("kp_insert", "KP_Insert", "Ins"),
    ("kp_left", "KP_Left", "←"),
    ("kp_multiply", "KP_Multiply", "×"),
    ("kp_next", "KP_Next", "PgDn"),
    ("kp_prior", "KP_Prior", "PgUp"),
    ("kp_right", "KP_Right", "→"),
    ("kp_subtract", "KP_Subtract", "-"),
    ("kp_up", "KP_Up", "↑"),
]

_misc = [
    ("find", "Find", "Find"),
    ("help", "Help", "Help"),
    ("print", "Print", "Print"),
    ("undo", "Undo", "Undo"),
]

_language = [
    ("hangul", "Hangul", "한글"),
    ("hangul_hanja", "Hangul_Hanja", "한자"),
    ("henkan_mode", "Henkan_Mode", "変換"),
    ("hiragana", "Hiragana", "ひらがな"),
    ("hiragana_katakana", "Hiragana_Katakana", "ひらがな/カタカナ"),
    ("katakana", "Katakana", "カタカナ"),
    ("muhenkan", "Muhenkan", "無変換"),
]

_xf86 = [
    ("xf86audioforward", "XF86AudioForward", "⏩"),
    ("xf86audiolowervolume", "XF86AudioLowerVolume", "🔉"),
    ("xf86audiomedia", "XF86AudioMedia", "🎵"),
    ("xf86audiomicmute", "XF86AudioMicMute", "🎤"),
    ("xf86audiomute", "XF86AudioMute", "🔇"),
    ("xf86audionext", "XF86AudioNext", "⏭️"),
    ("xf86audiopause", "XF86AudioPause", "⏸️"),
    ("xf86audioplay", "XF86AudioPlay", "▶️"),
    ("xf86audiopreset", "XF86AudioPreset", "🎛️"),
    ("xf86audioprev", "XF86AudioPrev", "⏮️"),
    ("xf86audioraisevolume", "XF86AudioRaiseVolume", "🔊"),
    ("xf86audiorecord", "XF86AudioRecord", "⏺️"),
    ("xf86audiorewind", "XF86AudioRewind", "⏪"),
    ("xf86audiostop", "XF86AudioStop", "⏹️"),
    ("xf86back", "XF86Back", "🔙"),
    ("xf86battery", "XF86Battery", "🔋"),
    ("xf86bluetooth", "XF86Bluetooth", "📶"),
    ("xf86brightnessauto", "XF86BrightnessAuto", "💡"),
    ("xf86calculator", "XF86Calculator", "🧮"),
    ("xf86close", "XF86Close", "❌"),
    ("xf86copy", "XF86Copy", "📋"),
    ("xf86cut", "XF86Cut", "✂️"),
    ("xf86display", "XF86Display", "🖥️"),
    ("xf86displayoff", "XF86DisplayOff", "🌙"),
    ("xf86documents", "XF86Documents", "📄"),
    ("xf86dos", "XF86DOS", "💾"),
    ("xf86eject", "XF86Eject", "⏏️"),
    ("xf86explorer", "XF86Explorer", "🗺️"),
    ("xf86favorites", "XF86Favorites", "🌟"),
    ("xf86finance", "XF86Finance", "💰"),
    ("xf86forward", "XF86Forward", "🔜"),
    ("xf86game", "XF86Game", "🎮"),
    ("xf86go", "XF86Go", "🎯"),
    ("xf86homepage", "XF86HomePage", "🏠"),
    ("xf86kbdbrightnessdown", "XF86KbdBrightnessDown", "🌒"),
    ("xf86kbdbrightnessup", "XF86KbdBrightnessUp", "🌔"),
    ("xf86kbdlightonoff", "XF86KbdLightOnOff", "💡"),
    ("xf86launch1", "XF86Launch1", "🚀1️⃣"),
    ("xf86launch2", "XF86Launch2", "🚀2️⃣"),
    ("xf86launch3", "XF86Launch3", "🚀3️⃣"),
    ("xf86launch4", "XF86Launch4", "🚀4️⃣"),
    ("xf86launch5", "XF86Launch5", "🚀5️⃣"),
    ("xf86launch6", "XF86Launch6", "🚀6️⃣"),
    ("xf86launch7", "XF86Launch7", "🚀7️⃣"),
    ("xf86launch8", "XF86Launch8", "🚀8️⃣"),
    ("xf86launch9", "XF86Launch9", "🚀9️⃣"),
    ("xf86launcha", "XF86LaunchA", "🚀A️"),
    ("xf86launchb", "XF86LaunchB", "🚀B️"),
    ("xf86mail", "XF86Mail", "✉️"),
    ("xf86mailforward", "XF86MailForward", "📩"),
    ("xf86menuekb", "XF86MenuKB", "📚"),
    ("xf86messenger", "XF86Messenger", "💬"),
    ("xf86monbrightnesscycle", "XF86MonBrightnessCycle", "☀️"),
    ("xf86monbrightnessdown", "XF86MonBrightnessDown", "🌘"),
    ("xf86monbrightnessup", "XF86MonBrightnessUp", "🌖"),
    ("xf86mycomputer", "XF86MyComputer", "🖥️"),
    ("xf86new", "XF86New", "🆕"),
    ("xf86nextvmode", "XF86Next_VMode", "🔁"),
    ("xf86open", "XF86Open", "📂"),
    ("xf86paste", "XF86Paste", "📄"),
    ("xf86phone", "XF86Phone", "📞"),
    ("xf86poweroff", "XF86PowerOff", "⏻"),
    ("xf86prevvmode", "XF86Prev_VMode", "↩️"),
    ("xf86reload", "XF86Reload", "🔃"),
    ("xf86reply", "XF86Reply", "↩️"),
    ("xf86rfkill", "XF86RFKill", "📡"),
    ("xf86rotatewindows", "XF86RotateWindows", "🔄"),
    ("xf86save", "XF86Save", "💾"),
    ("xf86screensaver", "XF86ScreenSaver", "🛡️"),
    ("xf86scrolldown", "XF86ScrollDown", "⏬"),
    ("xf86scrollup", "XF86ScrollUp", "⏫"),
    ("xf86search", "XF86Search", "🔍"),
    ("xf86send", "XF86Send", "📤"),
    ("xf86shop", "XF86Shop", "🛍️"),
    ("xf86sleep", "XF86Sleep", "💤"),
    ("xf86suspend", "XF86Suspend", "⏸️"),
    ("xf86taskpane", "XF86TaskPane", "📑"),
    ("xf86tools", "XF86Tools", "🔧"),
    ("xf86touchpadoff", "XF86TouchpadOff", "🚫"),
    ("xf86touchpadon", "XF86TouchpadOn", "✅"),
    ("xf86touchpadtoggle", "XF86TouchpadToggle", "↔️"),
    ("xf86uwb", "XF86UWB", "📡"),
    ("xf86wakeup", "XF86WakeUp", "⏰"),
    ("xf86webcam", "XF86WebCam", "📷"),
    ("xf86wlan", "XF86WLAN", "📶"),
    ("xf86wwan", "XF86WWAN", "🌐"),
    ("xf86www", "XF86WWW", "🌐"),
    ("xf86xfer", "XF86Xfer", "💼"),
]

KeyT = Tuple[str, str, str]
KeyListT = List[KeyT]
KeyGroupT = Dict[str, Dict[str, KeyListT | str]]

keycode_groups: KeyGroupT = {
    "mouse": {'k': _mouse, 'd': 'Mouse buttons'},
    "number": {'k': _number, 'd': 'Numeric keys 0-9'},
    "letter": {'k': _letter, 'd': 'Alphabet keys A-Z, a-z'},
    "punctuation": {'k': _punctuation, 'd': 'Punctuation keys and symbols'},
    "fn": {'k': _fn, 'd': 'Function keys F1-F12'},
    "modifier": {'k': _modifier, 'd': 'Modifier keys like Shift, Control, Alt'},
    "navigation": {'k': _navigation, 'd': 'Navigation keys like arrows, Home, End'},
    "keypad": {'k': _keypad, 'd': 'Numeric keypad and related keys'},
    "misc": {'k': _misc, 'd': 'Miscellaneous keys like Esc, Enter, Tab'},
    "language": {'k': _language, 'd': 'Language input and character conversion keys'},
    "xf86": {'k': _xf86, 'd': 'Multimedia and system control keys'},
}
""" Keycode groups
## Description
A dictionary of keycode split into logical groups

## Inner dictionary keys
- `k`: A list of keycodes
- `d`: A description of the keycode group

## Usage
```python
navigation = keycode_groups['navigation']
```
"""

keycodes: KeyListT = [x for group in keycode_groups.values()
                      for x in cast(KeyListT, group['k'])]
""" Keycodes
### Description
A list of all keycodes

## Keycode list items
- `[0]`: Keycode as a dict key
- `[1]`: Keycode value
- `[2]`: Keycode description

## Usage
```python
for keycode in keycodes:
    key = keycode[0]
    value = keycode[1]
    description = keycode[2]
```
"""


@dataclass
class ModifierKey():
    m, c, s, a, _ = ["m", "c", "s", "a", "no_mod"]


@dataclass
class ModifierLower():
    m, c, s, a, _ = ["m", "c", "s", "a", "_"]


@dataclass
class ModifierUpper():
    m, c, s, a, _ = ["M", "C", "S", "A", "_N"]


MK = ModifierKey
ML = ModifierLower
MU = ModifierUpper


ModT = Dict[str, str]
ModCombT = OrderedDict[str, ModT]
modifiers: ModCombT = OrderedDict({
    MK.m: {"l": ML.m, "u": MU.m, "c": "modkey", "d": "Modkey"},
    MK.c: {"l": ML.c, "u": MU.c, "c": "'Control'", "d": "Control"},
    MK.s: {"l": ML.s, "u": MU.s, "c": "'Shift'", "d": "Shift"},
    MK.a: {"l": ML.a, "u": MU.a, "c": "'Mod1'", "d": "Alt"},
    MK._: {"l": ML._, "u": MU._, "c": "", "d": "No Modifier"}
})
""" Modifier names
## Description
A dictionary of modifier names

## Keys
- `m`: Modkey
- `c`: Control
- `s`: Shift
- `a`: Alt
- `n`: No modifier

## Inner dictionary keys
- `l`: Lowercase
- `u`: Uppercase
- `c`: Keycode
- `d`: Description

## Usage
```python
for key, value in modifiers.items():
    control_lower = value['l']
```
"""


ModCombsT = OrderedDict[str, ModCombT]


def _all_combs() -> ModCombsT:
    out: ModCombsT = OrderedDict()
    for n_mods in range(1, len(modifiers)):
        mods_without_n = {k: v for k, v in modifiers.items() if k != MK._}
        mods = list(mods_without_n.items())
        for _mod_combs in itertools.combinations(mods, n_mods):
            key = ''.join([x[0] for x in _mod_combs])
            out[key] = OrderedDict({x[0]: x[1] for x in _mod_combs})
    out[MK._] = OrderedDict({MK._: modifiers[MK._]})
    return out


modifier_combinations: ModCombsT = _all_combs()
""" Modifier combinations
## Description
An ordered dictionary of all possible modifier combinations

## Usage
```python
for comb_key, comb_val in modifier_combinations.items():
    for mod_key, mod_val in comb_val.items():
        control_lower = mod_val['l']
```
"""


def mods_upper(mods: ModCombT) -> str:
    """ Get uppercase modifier names
    ## Description
    Get uppercase modifier names from a modifier combination

    ## Usage
    ```python
    mods_upper(modifier_combinations['ms'])
    ```
    """
    return ''.join([x['u'] for x in mods.values()])


def mods_lower(mods: ModCombT) -> str:
    """ Get lowercase modifier names
    ## Description
    Get lowercase modifier names from a modifier combination

    ## Usage
    ```python
    mods_lower(modifier_combinations['ms'])
    ```
    """
    return ''.join([x['l'] for x in mods.values()])

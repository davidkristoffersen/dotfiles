import logging
from pprint import pprint

from libs import (BM, BMA, BMAS, BMC, BMCA, BMCAS, BMCS, BMS, CS, VIM,
                  VIM_MIRROR, A, B, C, E, M, S)
from libs.utils import bm, camel, columns

logger = logging.getLogger(__name__)


def plasma_compat():
    fw = 'for_window'
    fe = 'floating enable'
    fd = 'floating disable'
    bn = 'border none'

    win = columns(f'''
{fw} [window_role="pop-up"] {fe}
{fw} [window_role="task_dialog"] {fe}
''')

    cls = columns(f'''
{fw} [class="yakuake"] {fe}
{fw} [class="systemsettings"] {fe}
{fw} [class="plasmashell"] {fe}
{fw} [class="Plasma"] {fe}; {bn}
{fw} [title="plasma-desktop"] {fe}; {bn}
{fw} [title="win7"] {fe}; {bn}
{fw} [class="krunner"] {fe}; {bn}
{fw} [class="Kmix"] {fe}; {bn}
{fw} [class="Klipper"] {fe}; {bn}
{fw} [class="Plasmoidviewer"] {fe}; {bn}
{fw} [class="(?i)*nextcloud*"] {fd}
''', [1])

    background = '$HOME/.local/share/backgrounds/manjaro.jpg'

    return f'''
# Plasma compatibility improvements
{win}

{cls}
{fw} [class="plasmashell" window_type="notification"] {bn}, move position 70 ppt 81 ppt
no_focus [class="plasmashell" window_type="notification"]

# Kill Desktop window that covers everything
{fw} [title="Desktop — Plasma"] kill; {fe}; {bn}

# Using plasma's logout screen instead of i3's
# Works only if the below usage of i3 nagbar is commented out 
{BMS}+e {E} qdbus org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.logout -1 -1 -1

# Application launcher
# {BMS}+d qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.activateLauncherMenu

# Audio integration
# Works only if the below usage pactl is commented out
{B} XF86AudioRaiseVolume {E} qdbus org.kde.kglobalaccel /component/kmix invokeShortcut "increase_volume"
{B} XF86AudioLowerVolume {E} qdbus org.kde.kglobalaccel /component/kmix invokeShortcut "decrease_volume"
{B} XF86AudioMute {E} qdbus org.kde.kglobalaccel /component/kmix invokeShortcut "mute"
{B} XF86AudioMicMute {E} qdbus org.kde.kglobalaccel /component/kmix invokeShortcut "mic_mute"

# Background, comment out nitrogen
# {E} feh --bg-scale {background}
'''


def variables():
    return f'''
# Mod1: Alt
# Mod4: Super
'''


def fonts():
    return f'''
# Window title font
font pango:monospace 8
'''


def network():
    return f'''
# Desktop env independentn system tray gui
{E} nm-applet
'''


def audio():
    ri3 = '$refresh_i3status'
    return f'''
# Use pactl to adjust volume in PulseAudio.
set {ri3} killall -SIGUSR1 i3status

# {B} XF86AudioRaiseVolume {E} pactl set-sink-volume @DEFAULT_SINK@ +10% && {ri3}
# {B} XF86AudioLowerVolume {E} pactl set-sink-volume @DEFAULT_SINK@ -10% && {ri3}
# {B} XF86AudioMute {E} pactl set-sink-mute @DEFAULT_SINK@ toggle && {ri3}
# {B} XF86AudioMicMute {E} pactl set-source-mute @DEFAULT_SOURCE@ toggle && {ri3}
'''


def screens():
    return f'''
# Output
{E} autorandr_helper.sh
{BMS}+m {E} autorandr_helper.sh

# Lock
{BMS}+o exec xlock
# {BMS}+o exec google-chrome-stable

# Kill focused window
{BMS}+q kill

# Background
{E} nitrogen --restore

# Swap active workspaces
{BMS}+s {E} i3_swap_workspaces.py
'''


def app_launcher():
    return f'''
# Rofi
{BM}+d exec rofi -show drun
'''


def notifications():
    return f'''
# Kill xfce notification daemon
{E} killall -q xfce4-notifyd
# Start dunst notification daemon
{E} dunst -config $HOME/.config/dunst/dunstrc
'''


def applications():
    return f'''
# Terminal
{BM}+Return exec terminator
# {BM}+Return exec alacritty

# Browser
{BM}+b exec google-chrome-stable

# Language swap
{BM}+space {E} toggle_xkbmap.sh
'''


def navigation():
    mwto = 'move workspace to output'

    def nav_type(mod='', type='', isVim=False):
        hotkey = bm(mod)
        out = [f'{hotkey}+{key} {type} {val}' if isVim else
               f'{hotkey}+{camel(val)} {type} {val}'
               for key, val in VIM.items()]
        return columns(out)

    return f'''
# Change focus
# Tiling / floating
{BMS}+t focus mode_toggle
# Parent container
{BM}+p focus parent
# Child container
{BM}+c focus child

# Vim style
{nav_type('', 'focus', True)}
# Arrow style
{nav_type('', 'focus')}

# Move container
# Vim style
{nav_type(S, 'move', True)}
# Arrow style
{nav_type(S, 'move')}

# Move workspace
# Vim style
{nav_type(A, mwto, True)}
# Arrow style
{nav_type(A, mwto)}

# Mouse
# Drag floating style
floating_modifier {M}
# Focus
focus_follows_mouse no
# Warping
mouse_warping output

# Split
# Horizontally
{BM}+bar split h
# Vertically
{BM}+minus split v

# Fullscreen focused container
{BM}+f fullscreen toggle

# Layout
{BM}+s layout stacking
{BM}+t layout tabbed
{BM}+e layout toggle split
{BMS}+space floating toggle

# Scratchpad / hide
# Make the currently focused window a scratchpad
{BMS}+minus move scratchpad

# Show the first scratchpad window
{BMS}+plus scratchpad show
'''


def workspaces():
    def wtype(mod='', type=''):
        hotkey = bm(mod)
        return '\n'.join([f'{hotkey}+{key} {type} {key}' for key in range(10)])

    def wnav(mod='', type='', isVim=False):
        hotkey = bm(mod)
        parent = ''.join(['focus parent;'] * 3) + 'focus '
        child = ''.join(['focus child;'] * 3) + 'focus child'

        cols = [f'{hotkey}+{key} {parent} {val}; {child}' if isVim else
                f'{hotkey}+{camel(val)} {parent} {val}; {child}'
                for key, val in VIM.items()]
        return columns(cols, [1, 6])

    def wswap(mod='', isVim=False):
        hotkey = bm(mod)
        script = 'i3_swap_workspaces.py'
        out = [f'{hotkey}+{key}; {E} {script} {val}' if isVim else
               f'{hotkey}+{camel(val)}; {E} {script} {val}'
               for key, val in VIM.items()]
        return columns(out)

    return f'''
# Switch to workspace
{wtype('', 'workspace number')}

# Move focused container to workspace
{wtype(S, 'move container to workspace number')}

# Rename focused workspace
{wtype(A, 'rename workspace to')}

# Focus directional workspace
# Vim style
{wnav(C, 'focus', True)}
# Arrow style
{wnav(C, 'focus')}

# swap directional workspace
# Vim style
{wswap(CS, True)}
# Arrow style
{wswap(CS)}

# Focus next/prev workspace on current monitor
{BMC}+n workspace next_on_output
{BMC}+p workspace prev_on_output
{BMC}+Tab workspace next_on_output
{BMCS}+Tab workspace prev_on_output

# Focus next/prev workspace on all monitors
{BMCA}+n workspace next
{BMCA}+p workspace prev
{BMCA}+Tab workspace next_on_output
{BMCAS}+Tab workspace prev_on_output
'''


def appearance():
    c = 'client'
    return f'''
# Gaps size
gaps inner 10
gaps outer 0

default_border pixel 2

# class                 border  backgr. text    indicator child_border
{c}.focused          #aaaaaa #aaaaaa #000000 #aaaaaa   #aaaaaa
{c}.focused_inactive #555555 #555555 #ffffff #555555   #555555
{c}.unfocused        #000000 #000000 #888888 #000000   #000000
{c}.urgent           #2f343a #900000 #ffffff #900000   #900000
{c}.placeholder      #000000 #0c0c0c #ffffff #000000   #0c0c0c

{c}.background       #ffffff

# App specific
# for_window [class="^Google chrome$" title=" - Google chrome$"] border 1
'''


def config():
    return f'''
# Reload config
{BMS}+c reload

# Restart i3
{BMS}+r restart

# Exit i3
# {BMS}+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'" 
'''


def modes():
    def mode(x): return f'mode "{x}"'
    m_default = mode('default')

    def to_default(hotkey: str = ''):
        return f'''
    {B} Return {m_default}
    {B} Escape {m_default}
    {hotkey + ' ' + m_default if hotkey else ''}
'''.strip()

    m_resize = mode('resize')
    h_resize = f'{BM}+r'

    m_bar = mode('modify bar')
    h_bar = f'{BMS}+b'

    def resize(isVim=False):
        grow = 'resize grow'
        shrink = 'resize shrink'
        size = '10 px or 10 ppt'
        out = [f'{B} {key} {grow} {val} {size}; {shrink} {mval} {size}' if isVim else
               f'{B} {camel(val)} {grow} {val} {size}; {shrink} {mval} {size}'
               for (key, val), mval in zip(VIM.items(), VIM_MIRROR.values())]
        return columns(out, [1, 4, 12], '\t')

    return f'''

# Resize windows
{m_resize} {{
	# Vim style
{resize(True)}

	# Arrow style
{resize()}

	# Exit mode
	{to_default(h_resize)}
}}

{m_bar} {{
    {B} s bar mode dock
    {B} h bar mode hide
    {B} i bar mode invisible
    {B}+t bar mode toggle

    # Exit mode
    {to_default(h_bar)}
}}

{h_resize} {m_resize}
{h_bar} {m_bar}
'''


def status_bar():
    return f'''
# i3bar
bar {{
	status_command i3status
    position top
    mode dock
}}
'''


def autostart_applications():
    return f'''
# exec google-chrome-stable
'''

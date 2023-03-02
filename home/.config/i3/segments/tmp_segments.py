import logging

from libs import B, E, M

logger = logging.getLogger(__name__)


def basic_config():
    return f'''
set {M} Mod4
font pango:monospace 8
workspace_auto_back_and_forth yes
'''


def key_bindings():
    return f'''
{B} {M}+Return {E} i3-sensible-terminal
{B} {M}+d {E} dmenu_run
'''


def window_rules():
    class_regex = '^.*'
    return f'''
for_window [class="{class_regex}"] border pixel 2
'''


def startup_apps():
    compositor = 'picom'
    wallpaper_manager = 'nitrogen --restore'
    power_manager = 'xfce4-power-manager'
    return f'''
{E} {compositor}
{E} {wallpaper_manager}
{E} {power_manager}
'''

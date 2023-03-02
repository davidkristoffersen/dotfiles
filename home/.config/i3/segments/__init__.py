from typing import Callable, List, Tuple

from .segments import *
from .tmp_segments import *

TMP_CATEGORIES: List[Tuple[Callable, str]] = [
    (basic_config, 'Basic i3 configurations'),
    (key_bindings, 'Key bindings'),
    (window_rules, 'Window rules'),
    (startup_apps, 'Startup applications')
]

CATEGORIES: List[Tuple[Callable, str]] = [
    (plasma_compat, 'Plasma compatibility'),
    (variables, 'Variables'),
    (fonts, 'Fonts'),
    (network, 'Network'),
    (audio, 'Audio'),
    (screens, 'Screens'),
    (app_launcher, 'Application launcher'),
    (notifications, 'Notifications'),
    (applications, 'Applications'),
    (navigation, 'Navigation'),
    (workspaces, 'Workspaces'),
    (appearance, 'Appearance'),
    (config, 'Config'),
    (modes, 'Modes'),
    (status_bar, 'Status bar'),
    (autostart_applications, 'Autostart applications')
]

#!/usr/bin/env python
"""Swap workspaces on two monitors"""

import os
import sys
from i3ipc import Connection


def swap_workspaces():
    """Swap two workspaces"""
    direction = sys.argv[1] if len(sys.argv) > 1 else False
    if not direction in ['left', 'right']:
        return False

    _i3 = Connection()

    # Get workspace objects
    focused = _i3.get_tree().find_focused().workspace()
    outputs = [output for output in _i3.get_outputs() if output.active]
    workspaces = [o.current_workspace for o in outputs][::-1]

    focused_idx = workspaces.index(focused.name)
    direction_num = {'left': -1, 'right': 1}[direction]
    direction_opp = {'left': 'right', 'right': 'left'}[direction]
    swap_idx = (focused_idx + direction_num) % len(workspaces)

    _i3.command('workspace ' + workspaces[focused_idx])
    _i3.command('move ' + 'workspace to output ' + direction)
    _i3.command('workspace ' + workspaces[swap_idx])
    _i3.command('move ' + 'workspace to output ' + direction_opp)
    return True


def focus_cursor():
    """Focus cursor on new workspace"""
    cmds = [
        "focused=$(xdotool getwindowfocus)",
        "eval $(xdotool getwindowgeometry --shell $focused)",
        "x=$(expr $WIDTH / 2)",
        "y=$(expr $HEIGHT / 2)",
        "xdotool mousemove -window $focused $x $y"
    ]
    cmd = ';'.join(cmds)
    os.system(cmd)


def main():
    """Main function"""
    if not swap_workspaces():
        return
    focus_cursor()


if __name__ == "__main__":
    main()

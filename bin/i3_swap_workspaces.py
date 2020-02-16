#!/usr/bin/env python
# Swap workspaces on two monitors
from i3ipc import Connection
import os

def swap():
    i3 = Connection()

    # Get workspace objects
    focused = i3.get_tree().find_focused().workspace()
    outputs = [output for output in i3.get_outputs() if output.active]
    if not len(outputs) == 2:
        return

    # First workspace is focused
    if not outputs[0].current_workspace == focused.name:
        outputs[0], outputs[1] = outputs[1], outputs[0]
    focus_workspace = outputs[1].current_workspace

    # Swap workspaces
    for output in outputs:
        i3.command('workspace ' + output.current_workspace)
        i3.command('move ' + 'workspace to output right')

    # Focus cursor on new workspace
    os.system("focused=`xdotool getwindowfocus`; eval `xdotool getwindowgeometry --shell $focused`; x=`expr $WIDTH / 2`; y=`expr $HEIGHT / 2`; xdotool mousemove -window $focused $x $y")

if __name__ == "__main__":
    swap()

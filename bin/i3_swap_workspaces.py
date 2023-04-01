#!/usr/bin/env python
"""Swap workspaces on two monitors"""

import asyncio
import os
import sys
from pprint import pprint
from typing import List

from i3ipc import Connection as i3Conn
from i3ipc import OutputReply as i3Out
from i3ipc import WorkspaceReply as i3Work
from i3ipc.aio import Connection as AConnection

i3OutL = List[i3Out]
i3WorkL = List[i3Work]


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


def focused_output():
    f = tree.find_focused()
    if f is not None:
        return f
    raise Exception('Focused container is not under this container')


def focused_workspace():
    return focused_output().workspace()


def get_next_output(outputs, current_output, direction):
    if direction == 'left':
        next_output = outputs[(outputs.index(
            current_output) - 1) % len(outputs)]
    elif direction == 'right':
        next_output = outputs[(outputs.index(
            current_output) + 1) % len(outputs)]
    else:
        next_output = None
    return next_output


def swap(i3: i3Conn):
    workspace1 = focused()
    tree.find_focused()
    workspace2 = tree.leaves()[1].workspace()
    i3.command(f'workspace {workspace2.name}; workspace {workspace1.name}')


def swap_dir(i3: i3Conn, direction: str):
    focused = focused_output()
    workspace = focused_workspace()
    outs = workspace.leaves()
    # Get workspace to swap with
    dir_workspace =

    out_names = [o.name for o in outs]
    print(f'Workspace: {f.name}')
    print(f'Outputs: {out_names}')
    print(f'Current output: {focused_output().name}')

    next_output = get_next_output(outputs, focused_output, direction)
    if next_output is not None:
        workspace1 = i3.get_tree().find_focused().workspace()
        workspace2 = i3.get_tree().leaves(output=next_output)[0].workspace()
        i3.command(f'workspace {workspace2}; workspace {workspace1}')
    else:
        print('Invalid direction')


def main():
    match len(outputs):
        case 2:
            print('Swapping workspaces')
            swap(i3)
        case l if l > 2:
            print('Number of outputs:', l)
            if (len(sys.argv) < 2):
                print('Please specify a direction: left or right')
                dir = input('Direction: ')
            else:
                dir = sys.argv[1]
            swap_dir(i3, dir)


async def m():
    conn = await ai3.connect()
    t = await conn.get_tree()
    f = t.find_focused()
    print(f'Focused: {f.name}')

if __name__ == "__main__":
    i3 = i3Conn()

    ai3 = AConnection()
    # r = asyncio.run(m())

    tree = i3.get_tree()
    outputs = i3.get_outputs()
    workspaces = i3.get_workspaces()

    main()

    i3.main_quit()
    # ai3.main_quit()

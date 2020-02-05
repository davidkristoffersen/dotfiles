#!/usr/bin/env python
# Swap workspaces on two monitors
from i3ipc import Connection, Event
from pylogger import Pylogger

logger = Pylogger()

def swap():
    i3 = Connection()

    focused = i3.get_tree().find_focused().workspace().name
    logger.log("focused: " + focused)

    outputs = [output.current_workspace for output in i3.get_outputs() if output.active]
    if not len(outputs) == 2:
        return

    for output in outputs:
        if not output == focused:
            to_focus = output
        logger.log("out: " + output)
        i3.command('workspace ' + output)
        i3.command('move ' + 'workspace to output right')

    logger.log("to_focus: " + to_focus)
    i3.command('workspace ' + to_focus)

if __name__ == "__main__":
    logger.clean()
    swap()
    logger.finalize()

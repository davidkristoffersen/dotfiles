
from util.config import VARS
from util.types import LogLevel

BOLD = '\x1b[1m'
FAINT = '\x1b[2m'
RESET = '\x1b[m'

BYELLOW = BOLD + '\x1b[38;2;255;255;0m'
BCYAN = BOLD + '\x1b[38;2;0;255;255m'
BLUE = '\x1b[38;2;0;100;200m'
RED = '\x1b[38;2;200;50;50m'
ERROR = BOLD + '\x1b[38;2;255;0;0m'


def print_error(msg, end='\n'):
    if VARS.print <= LogLevel.ERROR:
        printc(ERROR, msg, end)


def print_warn(msg, end='\n'):
    if VARS.print <= LogLevel.WARN:
        printc(RED, msg, end)


def print_header(name, new_line=True):
    '''Print header'''
    if VARS.print <= LogLevel.CATEGORY:
        if new_line:
            print()

        line = '#' * (len(name) + 4)

        printne(FAINT, line + '\n# ')
        printne(BYELLOW, name)
        printc(FAINT, ' #\n' + line)


def print_section(name):
    '''Print section'''
    if VARS.print <= LogLevel.CATEGORY:
        printne(FAINT, '\n# ')
        printc(BCYAN, name)


def print_info(msg):
    if VARS.print <= LogLevel.INFO:
        printc(BLUE, msg)


def print_debug(msg):
    if VARS.print <= LogLevel.DEBUG:
        print(msg)


def print_trace(msg):
    if VARS.print <= LogLevel.TRACE:
        printc(FAINT, msg)


def printne(color, line):
    print(color + line + RESET, end='')


def printc(color, line, end='\n'):
    print(color + line + RESET, end=end)

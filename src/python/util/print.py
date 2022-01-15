# from colorstring import Color
from .config import *
from .types import *

BOLD = '\x1b[1m'
FAINT = '\x1b[2m'
RESET = '\x1b[m'

BYELLOW = BOLD + '\x1b[38;2;255;255;0m'
BCYAN = BOLD + '\x1b[38;2;0;255;255m'
BLUE = '\x1b[38;2;0;100;200m'
RED = '\x1b[38;2;200;50;50m'
ERROR = '\x1b[38;2;255;0;0m'


def print_error(msg, end='\n'):
    if VARS['PRINT'] <= LogLevel.ERROR:
        print(f'{BOLD}{ERROR}{msg}{RESET}', end=end)


def print_warn(msg, end='\n'):
    if VARS['PRINT'] <= LogLevel.WARN:
        print(f'{RED}{msg}{RESET}', end=end)


def print_header(name, new_line=True):
    '''Print header'''
    if VARS['PRINT'] <= LogLevel.CATEGORY:
        if new_line:
            print()

        line = '#' * (len(name) + 4)

        print(RESET + FAINT + line)
        print(f'# {BYELLOW}{name}{RESET}{FAINT} #')
        print(line + RESET)

        # print(
        #     Color(f'{line}\n# ', 'faint') +
        #     Color(f'{name}', 'bold', 'yellow') +
        #     Color(f' #\n{line}', 'faint')
        # )


def print_section(name):
    '''Print section'''
    if VARS['PRINT'] <= LogLevel.CATEGORY:
        print(f'\n{FAINT}# {BCYAN}{name}{RESET}')
        # print(
        #     Color('\n# ', 'faint') +
        #     Color(name, 'bold', 'cyan')
        # )


def print_info(msg):
    if VARS['PRINT'] <= LogLevel.INFO:
        print(f'{BLUE}{msg}{RESET}')


def print_debug(msg):
    if VARS['PRINT'] <= LogLevel.DEBUG:
        print(msg)


def print_trace(msg):
    if VARS['PRINT'] <= LogLevel.TRACE:
        print(msg)

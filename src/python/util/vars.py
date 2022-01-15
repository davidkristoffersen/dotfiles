from .config import *


def set_print(log_level: LogLevel):
    VARS['PRINT'] = log_level


def set_sudo(boolean):
    VARS['SUDO'] = boolean

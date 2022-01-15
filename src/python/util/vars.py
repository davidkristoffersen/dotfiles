from .config import *


def set_print(log_level: LogLevel):
    VARS['PRINT'] = log_level


def set_write(boolean):
    VARS['WRITE'] = boolean


def set_sudo(boolean):
    VARS['SUDO'] = boolean

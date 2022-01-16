from . import access
from .types import *


class Vars():
    sudo = False
    write = False
    print = LogLevel.DEBUG

    def set_sudo(self, boolean: bool, reason=''):
        if boolean:
            self.sudo = True
            access.activate_sudo(reason)
        else:
            self.sudo = False

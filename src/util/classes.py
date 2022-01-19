from . import access
from .types import *


class Vars():
    sudo = False
    write = False
    submodule = False
    no_bash = False
    no_sudo = False
    print = LogLevel.DEBUG

    def set_sudo(self, boolean: bool, reason=''):
        if boolean and not self.no_sudo:
            self.sudo = True
            return access.activate_sudo(reason)
        else:
            self.sudo = False
        return True

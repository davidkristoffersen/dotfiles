
from util import access
from util.types import LogLevel


class Vars():
    sudo = False
    write = False
    no_bash = False
    no_sudo = False
    submodule = False
    print = LogLevel.DEBUG

    def set_sudo(self, boolean: bool, reason=''):
        if boolean and not self.no_sudo:
            self.sudo = True
            return access.activate_sudo(reason)
        self.sudo = False
        return True

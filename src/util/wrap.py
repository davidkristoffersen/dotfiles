from util.access import deactivate_sudo, get_path_access
from util.config import VARS
from util.path import real_path
from util.print import print_trace, print_warn


def decor_path(func):
    def inner(*args):
        if not len(args):
            raise TypeError(
                f'{func.__name__}() missing at least 1 required positional argument')
        path = real_path(args[0])
        access = get_path_access(path)

        pre_func(func, (path))
        out = decor_sudo(
            access, f'Path requires sudo access: {path}')(func)(*args)
        post_func(func, (path))
        return out
    return inner


def decor_path_args(*dargs):
    def inner(func):
        def wrap(*fargs):
            if len(fargs) < len(dargs):
                raise TypeError(
                    f'{func.__name__}() missing at least {len(dargs) - len(fargs)} required positional arguments')
            args = list(fargs)
            access = True
            sudo_path = ''
            for _it, darg in enumerate(dargs):
                args[_it] = real_path(args[_it], darg)
                if not get_path_access(args[_it]):
                    access = False
                    sudo_path = args[_it]

            pre_func(func, args)
            out = decor_sudo(access, f'Path requires sudo access: {sudo_path}')(
                func)(*args)
            post_func(func, args)
            return out
        return wrap
    return inner


def decor_sudo(access=True, reason=''):
    def inner(func):
        def wrap(*args):
            prev_sudo = VARS.sudo
            if access and prev_sudo:
                VARS.set_sudo(False)
            elif not access and not VARS.sudo:

                if VARS.no_sudo:
                    print_warn(
                        'Cannot run sudo command with "--no-sudo" flag')
                    return None
                if not VARS.set_sudo(True, reason):
                    print_warn('Failed to set sudo for command')
                    deactivate_sudo()
                    return None

            out = func(*args)

            if not VARS.sudo and prev_sudo:
                if not VARS.set_sudo(True, 'Sudo timed out'):
                    print_warn('Failed to set sudo for command')
            elif VARS.sudo and not prev_sudo:
                deactivate_sudo()
            return out
        return wrap
    return inner


def pre_func(func, *args):
    func_trace(func, 'pre: ', args)


def post_func(func, *args):
    func_trace(func, 'post:', args)


def func_trace(func, pos, args):
    sudo = 'sudo ' if VARS.sudo else ''
    print_trace(f'\t{pos} {sudo}{func.__name__}({args})')

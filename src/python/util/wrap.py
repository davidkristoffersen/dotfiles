from config import *
from print import *

from .access import *
from .path import *


def decor_path(func):
    def inner(*args):
        if not len(args):
            raise TypeError(
                f'{func.__name__}() missing at least 1 required positional argument')
        path = real_path(args[0])
        get_path_access(path)

        # print(f'pre: {func.__name__}({path})')
        func(path)
        # print(f'post: {func.__name__}({path})')
    return inner


def decor_path_args(*dargs):
    def inner(func):
        def wrap(*fargs):
            if len(fargs) < len(dargs):
                raise TypeError(
                    f'{func.__name__}() missing at least {len(dargs) - len(fargs)} required positional arguments')
            args = list(fargs)
            for it, darg in enumerate(dargs):
                args[it] = real_path(args[it], darg)
                get_path_access(args[it])

            # print(f'pre: {func.__name__}({args})')
            func(*args)
            # print(f'post: {func.__name__}({args})')
        return wrap
    return inner

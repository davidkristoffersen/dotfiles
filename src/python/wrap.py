from config import *
from print import *


def decor_path(func):
    def inner(*args):
        if not len(args):
            raise TypeError(
                f'{func.__name__}() missing at least 1 required positional argument')
        path = real_path(args[0])

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

            # print(f'pre: {func.__name__}({args})')
            func(*args)
            # print(f'post: {func.__name__}({args})')
        return wrap
    return inner


def sudo_path(path):
    pass


def real_path(path, pre_path=HOME):
    if not path:
        raise NotImplementedError('Path Cannot be empty')
    elif path == '/':
        raise NotImplementedError('Path Cannot be root')
    elif path[0] != '/':
        path = f'{pre_path}/{path}'
    elif path[-1] == '/':
        path = path[:-1]

    dirs = path[1:].split('/')
    out = []

    for _dir in dirs:
        if not _dir or _dir == '.':
            continue
        if _dir == '..' and out:
            out.pop()
        elif not _dir == '..':
            out.append(_dir)

    return '/' + '/'.join(out)

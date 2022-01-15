from .config import *
from .print import *


def base_name(path):
    return path.split('/')[-1]


def dir_name(path):
    return '/' + '/'.join(path.split('/')[1:-1])


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

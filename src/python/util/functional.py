from toolz import curry


@curry
def tap(func, x):
    func()
    return x


def pipe(data, *funcs):
    if data in [None, [], {}]:
        return data
    for func in funcs:
        data = func(data)
        if data in [None, [], {}]:
            return data
    return list(data)

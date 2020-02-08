def _default_text(text='Example text', col='white'):
    return {
        'text': text,
        'col': col
    }

default_title = {
    'header': _default_text(col='cyan'),
    'body': _default_text(),
    'sep': ': '
}

default_usage = {
    'header': _default_text(),
    'body': _default_text(),
    'sep': ' '
}

default_usages = {
    'header': _default_text(col='yellow'),
    'body': [],
    'sep': ':\n'
}

default_option = {
    'header': _default_text(),
    'single': _default_text(col='green'),
    'multi': _default_text(col='green'),
    'value': _default_text(col='green'),
    'default': _default_text(col='magenta'),
    'body': _default_text(),
    'sep': '\t'
}

default_options = {
    'header': _default_text(col='yellow'),
    'body': {},
    'sep': ':\n'
}

default_arg = {
    'header': _default_text(col='green'),
    'body': _default_text(),
    'sep': '\t'
}

default_args = {
    'header': _default_text(col='yellow'),
    'body': {},
    'sep': ':\n',
}

default_subcmd = {
    'header': _default_text(col='green'),
    'body': _default_text(),
    'sep': '\t'
}

default_subcmds = {
    'header': _default_text(col='yellow'),
    'body': {},
    'sep': ':\n',
}

default_json = {
    'title': default_title,
    'usage': default_usage,
    'options': default_options,
    'args': default_args,
    'subcmds': default_subcmds
}

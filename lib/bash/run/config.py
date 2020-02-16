from dotmap import DotMap

def _default_text(text='Example text', col='white'):
    return {
        'text': text,
        'col': col
    }

default_title = {
    'header': _default_text(text='MAIN', col='cyan'),
    'body': _default_text(),
    'sep': _default_text(text=': ')
}

default_usage = {
    'header': _default_text(text='usage'),
    'body': _default_text(),
    'sep': _default_text(text=' ')
}

default_usages = {
    'header': _default_text(text='USAGE', col='yellow'),
    'body': [],
    'sep': _default_text(text=':\t')
}

default_option = {
    'header': _default_text(text='option', col='green'),
    'single': _default_text(col='green'),
    'multi': _default_text(col='green'),
    'value': _default_text(col='green'),
    'default': _default_text(col='magenta'),
    'body': _default_text(),
    'sep': _default_text(text='\t')
}

default_options = {
    'header': _default_text(text='OPTIONS', col='yellow'),
    'body': {},
    'sep': _default_text(text=':')
}

default_arg = {
    'header': _default_text(text='arg', col='green'),
    'body': _default_text(),
    'sep': _default_text(text='\t')
}

default_args = {
    'header': _default_text(text='ARGS', col='yellow'),
    'body': {},
    'sep': _default_text(text=':')
}

default_subcmd = {
    'header': _default_text(text='subcmd', col='green'),
    'body': _default_text(),
    'sep': _default_text(text='\t')
}

default_subcmds = {
    'header': _default_text(text='SUBCOMMANDS', col='yellow'),
    'body': {},
    'cmd': {},
    'sep': _default_text(text=':')
}

default_json = {
    'title': default_title,
    'usages': default_usages,
    'options': default_options,
    'args': default_args,
    'subcmds': default_subcmds
}

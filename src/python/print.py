from colorstring import Color

BOLD = '\x1b[1m'
FAINT = '\x1b[2m'
RESET = '\x1b[m'

BYELLOW = BOLD + '\x1b[38;2;255;255;0m'
BCYAN = BOLD + '\x1b[38;2;0;255;255m'
BLUE = '\x1b[38;2;0;100;200m'


def print_header(name, new_line=True):
    '''Print header'''
    if new_line:
        print()

    line = '#' * (len(name) + 4)

    # print(RESET + FAINT + line)
    # print(f'# {BYELLOW}{name}{RESET}{FAINT} #')
    # print(line + RESET)

    print(
        Color(f'{line}\n# ', 'faint') +
        Color(f'{name}', 'bold', 'yellow') +
        Color(f' #\n{line}', 'faint')
    )


def print_section(name):
    '''Print section'''
    # print(f'\n{FAINT}# {BCYAN}{name}{RESET}')
    print(
        Color('\n# ', 'faint') +
        Color(name, 'bold', 'cyan')
    )

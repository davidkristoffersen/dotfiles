#!/usr/bin/env python3
# PYTHON_ARGCOMPLETE_OK

import argparse
import os
import subprocess

import argcomplete

b = '\x1b[1m'  # Bold
f = '\x1b[2m'  # Faint
r = '\x1b[0m'  # Reset
red = '\x1b[31m'
green = '\x1b[32m'

dst_dir = os.path.expanduser('~/.config/systemd/user')
src_dir = os.path.expanduser('~/dotfiles/home/.config/systemd/user')


def service_exists(service_name):
    try:
        subprocess.check_output(
            ['systemctl', '--user', 'is-enabled', f'{service_name}.service'], stderr=subprocess.STDOUT)
        return True
    except subprocess.CalledProcessError as e:
        return False


def get_current_wm():
    for wm in wms:
        if service_exists(f'plasma-{wm}'):
            return wm
    return 'kwin'


def enable_wm(wm):
    print(f'{green}Enabling: {wm}{r}')

    dst = f'{dst_dir}/plasma-{wm}.service'
    src = f'{src_dir}/plasma-{wm}.service'

    if not os.path.islink(dst):
        print(f'{b}Create symlink for plasma-{wm} service{r}')
        print(f'Created symlink {dst} → {src}.')
        os.symlink(src, dst)

    print(f'{b}Masking plasma-kwin_x11.service{r}')
    os.system('systemctl mask plasma-kwin_x11.service --user')

    print(f'{b}Enabling plasma-{wm} service{r}')
    os.system(f'systemctl enable plasma-{wm} --user')


def disable_wm(wm):
    print(f'{red}Disabling: {wm}{r}')

    dst = f'{dst_dir}/plasma-{wm}.service'

    if os.path.islink(dst):
        print(f'{b}Disabling plasma-{wm} service{r}')
        os.system(f'systemctl disable plasma-{wm} --user')

    print(f'{b}Unmasking plasma-kwin_x11.service{r}')
    os.system('systemctl unmask plasma-kwin_x11.service --user')
    print()


class DefaultHelpParser(argparse.ArgumentParser):
    def error(self, message):
        print(f'{red}{message}{r}')
        self.print_help()
        exit(2)


def parse_args():
    parser.add_argument('wm', nargs='?', default=None, choices=[
                        'kwin', *wms], action='store', help='Window manager to enable')
    parser.add_argument('-c', '--current', action='store_true',
                        dest='current', help='Get current window manager')

    argcomplete.autocomplete(parser)
    return parser.parse_args()


if __name__ == '__main__':
    parser = DefaultHelpParser('Enable window manager')
    wms = ['i3', 'awesome']
    cur_wm = get_current_wm()
    args = parse_args()

    if args.current:
        print('Current window manager:', cur_wm)
    elif args.wm is None:
        parser.error('No window manager specified')
    elif args.wm == 'kwin':
        for _wm in wms:
            disable_wm(_wm)
    else:
        if cur_wm is not args.wm:
            others = [_wm for _wm in wms if _wm != args.wm]
            for _wm in others:
                disable_wm(_wm)
            enable_wm(args.wm)

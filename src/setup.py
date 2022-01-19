#!/usr/bin/env python3

import argparse

import argcomplete

from install import install


def parse_args() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description='Install system')
    parser.add_argument(
        '-s', '--script', default='all',
        choices=['meta', 'shell', 'home', 'bin',
                 'lib', 'share',  'repo', 'private', 'all'],
        help='Script name to install'
    )
    parser.add_argument(
        '-w', '--write', dest='write', action='store_true', help='Do write operations')
    parser.add_argument(
        '-l', '--log', default='debug',
        choices=['all', 'trace', 'debug', 'info',
                 'category', 'warn', 'error', 'fatal', 'off'],
        help='Set log level'
    )
    parser.add_argument(
        '-a', '--apt', dest='apt', action='store_true', help='Run apt install')
    parser.add_argument(
        '-t', '--test', dest='test', action='store_true', help='Run test install')
    parser.add_argument(
        '--pacman', dest='pacman', action='store_true', help='Run pacman install')
    parser.add_argument(
        '--sub', dest='sub', action='store_true', help='Initialize submodules')
    parser.add_argument(
        '--no-sudo', dest='nosudo', action='store_true', help='Do not run sudo commands')
    parser.add_argument(
        '--no-bash', dest='nobash', action='store_true', help='Do not run bash commands')

    argcomplete.autocomplete(parser)
    return parser.parse_args()


def main(**args):
    install(args)


if __name__ == '__main__':
    main(**vars(parse_args()))

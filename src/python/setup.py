#!/usr/bin/env python3

import argparse

import argcomplete

from install import *


def parse_args() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description='Install system')
    parser.add_argument(
        '-s', '--script', choices=['shell', 'home'], help='Script name to install')
    parser.add_argument(
        '-a,', '--apt', dest='apt', action='store_true', help='Run apt install')
    parser.add_argument(
        '-t', '--test', dest='test', action='store_true', help='Run test install')
    parser.add_argument(
        '--log', choices=['all', 'trace', 'debug', 'info', 'category', 'warn', 'error', 'fatal', 'off'], help='Set log level')
    argcomplete.autocomplete(parser)
    return parser.parse_args()


def main(**args):
    install = Install(args['script'], args['apt'], args['test'], args['log'])

    install.run()


if __name__ == '__main__':
    main(**vars(parse_args()))

#!/usr/bin/env python3

from install import *

import argparse
import argcomplete


def parse_args():

    parser = argparse.ArgumentParser(description='Install system')
    parser.add_argument(
        '-s', '--script', choices=['shell', 'home'], help='Script name to install')
    parser.add_argument(
        '-p', '--pacman', dest='pacman', action='store_true', help='Run pacman install')
    parser.add_argument(
        '--server', dest='server', action='store_true', help='Run server install')
    argcomplete.autocomplete(parser)
    return parser.parse_args()


def main(**args):
    install = Install(args['script'], args['pacman'], args['server'])

    install.run()


if __name__ == '__main__':
    args = parse_args()
    main(**vars(args))

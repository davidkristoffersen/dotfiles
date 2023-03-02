#!/usr/bin/env python
# PYTHON_ARGCOMPLETE_OK

import os
from datetime import datetime
from typing import Callable, List, Tuple

from libs import get_logger, init_logger, parse_args, w
from rich.traceback import install
from segments import CATEGORIES, TMP_CATEGORIES

args = parse_args()
init_logger(args.log_level)
logger = get_logger(__name__)


def generate_config(category, config_file, funcs: List[Tuple[Callable, str]]):
    with open(config_file, 'w') as file:
        for config_func, config_name in funcs:
            if not category == 'all' and config_func.__name__ != category:
                continue
            config_lines = '\n'.join(config_func().splitlines()[1:])
            if len(config_lines) > 0:
                logger.info(f'Generating: {config_name}')
                config_lines = f'{config_lines}\n\n'
                w(f'#\n# {config_name.upper()}\n#\n\n{config_lines}', file)
            else:
                logger.warning(f'No config lines generated for: {config_name}')
    logger.info("i3 config generated successfully.")


def main():
    config_path = 'i3.config'
    funcs = CATEGORIES
    category = args.category
    all = args.category == 'all'

    if args.tmp:
        config_path = './tmp/i3.config'
        funcs = TMP_CATEGORIES
        category = args.tmp
        all = args.tmp == 'all'

    backup_path = f'{config_path}-{datetime.now().strftime("%Y-%m-%d_%H:%M:%S")}.bak'
    logger.debug(f'Using backup path: {backup_path}')

    if all:
        logger.info("Generating i3 config for all categories...")
        generate_config('all', config_path, funcs)
    else:
        logger.info(f"Generating i3 config for category: {category}")
        generate_config(category, config_path, funcs)


if __name__ == '__main__':
    install(show_locals=True)
    main()

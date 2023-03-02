import argparse
import logging

import argcomplete
from segments import CATEGORIES, TMP_CATEGORIES


class LogLevel:
    NONE = 0
    DEBUG = 10
    INFO = 20
    WARNING = 30
    ERROR = 40
    CRITICAL = 50
    NAMES = ['none', 'debug', 'info', 'warning', 'error', 'critical']

    @classmethod
    def nameToLevel(cls, name: str) -> int:
        return getattr(LogLevel, name.upper())

    @classmethod
    def levelToName(cls, level: int) -> str:
        return LogLevel.NAMES[level // 10]


def parse_args():
    parser = argparse.ArgumentParser(description='Generate an i3 config file.')

    category_names = [c[0].__name__ for c in CATEGORIES]
    parser.add_argument('-c', '--category', metavar='category', default='all',
                        choices=['all'] + category_names,
                        help='which categories to include in the config file')

    tmp_category_names = [c[0].__name__ for c in TMP_CATEGORIES]
    parser.add_argument('--tmp', default=False,
                        choices=['all'] + tmp_category_names,
                        help='which categories to include in the temporary config file')

    parser.add_argument('--log-level', choices=LogLevel.NAMES,
                        default='info', help='set the logging level')

    argcomplete.autocomplete(parser)
    return parser.parse_args()


def init_logger(log_level: str) -> None:
    log_format = '%(asctime)s %(levelname)s %(message)s'
    logLevel = LogLevel.nameToLevel(log_level)
    logging.basicConfig(filename='tmp/gen_config.log', filemode='w', encoding='utf-8',
                        format=log_format, level=logLevel)

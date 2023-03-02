import logging
import shutil
from typing import List

from .config import BM


def get_logger(name: str) -> logging.Logger:
    return logging.getLogger(name)


logger = get_logger(__name__)


def w(text, file):
    try:
        file.write(text)
    except IOError:
        logger.exception(f'Error writing to file: {file.name}')


def backup_file(filename: str) -> None:
    logger.debug(f'Backing up file {filename}')
    shutil.copyfile(filename, f'{filename}.bak')


def restore_file(filename: str) -> None:
    logger.debug(f'Restoring backup file {filename}')
    shutil.copyfile(f'{filename}.bak', filename)


def bm(mod: str = '') -> str:
    return f'{BM}{"+" + mod if mod else ""}'


def bk(key: str) -> str:
    return f'{BM}+{key}'


def bmk(mod: str, key: str) -> str:
    return f'{bm(mod)}+{key}'


def camel(s: str) -> str:
    return s[0].upper() + s[1:]


def columns(inp: str | List[str], splits: List[int] = [], pre: str = '') -> str:
    def get_column_widths(lines):
        num_cols = max(len(line.split()) for line in lines)
        col_widths = [max(len(word) for word in col)
                      for col in zip(*[line.split() for line in lines])]
        return num_cols, col_widths

    def get_aligned_line(line, col_widths, splits):
        words = line.split()
        cols_to_align = splits or range(len(col_widths))
        for col in cols_to_align:
            words[col] = words[col].ljust(col_widths[col])
        return ' '.join(words)

    lines = inp.split('\n') if isinstance(inp, str) else inp
    lines = [line for line in lines if line.strip()]

    num_cols, col_widths = get_column_widths(lines)

    if not splits:
        splits = list(range(num_cols))

    aligned_lines = []
    for line in lines:
        aligned_lines.append(get_aligned_line(line, col_widths, splits))

    return pre + f'\n{pre}'.join(aligned_lines)

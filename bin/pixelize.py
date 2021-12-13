#!/usr/bin/env python3
import sys

import numpy as np
from PIL import Image


def pixelize(src, size):
    h = len(src)
    w = len(src[0])
    chs = len(src[0][0])

    for y in range(0, h, size):
        for x in range(0, w, size):
            src[y:y + size, x:x + size, 0:chs] = src[y][x][0:chs]


if __name__ == "__main__":
    fin = sys.argv[1]
    fout = sys.argv[2]
    size = int(sys.argv[3])

    img = Image.open(fin)
    src = np.array(img)
    pixelize(src, size)
    im = Image.fromarray(src.astype(np.uint8))
    im.save(fout)

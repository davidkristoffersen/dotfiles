#!/usr/bin/env python
"""Convert config file to json"""

from json import dumps
import sys

def set_pos(org, pos):
    """Set max/min pos"""
    org[0] = pos if pos < org[0] else org[0]
    org[1] = pos if pos > org[1] else org[1]
    return org

def set_dim(org, _x, _y):
    """Set max dim"""
    org[0] = _x if _x > org[0] else org[0]
    org[1] = _y if _y > org[1] else org[1]
    return org

def main():
    """Main function"""
    if len(sys.argv) == 1:
        return

    json = {}
    key = ""
    pos_x = [0, 0]
    pos_y = [0, 0]
    dim = [0, 0]
    num_screens = 0
    screens = []
    primary = ""

    for line in sys.argv[1].split('\n'):
        words = line.split(' ')
        if words[0] == 'output':
            key = words[1]
            json[key] = {}
            num_screens += 1
            screens.append(key)
        elif words[0] == 'off':
            del json[key]
            num_screens -= 1
            screens.remove(key)
        elif words[0] == 'pos':
            pos = words[1].split('x')
            pos_x = set_pos(pos_x, int(pos[0]))
            pos_y = set_pos(pos_y, int(pos[1]))
            json[key]['x'] = int(pos[0])
            json[key]['y'] = int(pos[1])
        elif words[0] == 'mode':
            _dim = words[1].split('x')
            dim = set_dim(dim, int(_dim[0]), int(_dim[1]))
            json[key]['w'] = dim[0]
            json[key]['h'] = dim[1]
        elif words[0] == 'primary':
            primary = key
        elif words[0] == 'rate':
            json[key]['fps'] = ' '.join(words[1:])

    json['num_screens'] = num_screens
    json['min_x'] = pos_x[0]
    json['max_x'] = pos_x[1]
    json['min_y'] = pos_y[0]
    json['max_y'] = pos_y[1]
    json['max_w'] = dim[0]
    json['max_h'] = dim[1]
    json['screens'] = screens
    json['primary'] = primary
    print(dumps(json))

if __name__ == "__main__":
    main()

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
            json[key]['x'] = int(pos[0])
            json[key]['y'] = int(pos[1])
        elif words[0] == 'mode':
            _dim = words[1].split('x')
            json[key]['w'] = int(_dim[0])
            json[key]['h'] = int(_dim[1])
        elif words[0] == 'primary':
            primary = key
        elif words[0] == 'rate':
            json[key]['fps'] = ' '.join(words[1:])

    json['num_screens'] = num_screens
    json['screens'] = screens
    json['primary'] = primary

    min_x, max_x = 0, 0
    min_y, max_y = 0, 0
    _w, _h = 0, 0

    for screen in json['screens']:
        data = json[screen]
        if data['x'] < min_x:
            min_x = data['x']
        elif data['x'] > max_x:
            max_x = data['x']
        if data['y'] < min_y:
            min_y = data['y']
        elif data['y'] > max_y:
            max_y = data['y']
        if data['x'] + data['w'] > _w:
            _w += data['x'] + data['w'] - _w
        if data['y'] + data['h'] > _h:
            _h += data['y'] + data['h'] - _h

    json['min_x'] = min_x
    json['max_x'] = max_x
    json['min_y'] = min_y
    json['max_y'] = max_y
    json['max_w'] = _w
    json['max_h'] = _h

    print(dumps(json))

if __name__ == "__main__":
    main()

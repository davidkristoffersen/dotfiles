#!/usr/bin/env python
"""Convert config file to json"""

from json import dumps
import sys

def main():
    """Main function"""
    if len(sys.argv) == 1:
        return
    json = {}
    key = ""
    for line in sys.argv[1].split('\n'):
        words = line.split(' ')
        if words[0] == 'output':
            key = words[1]
            json[key] = {}
        elif words[0] == 'off':
            del json[key]
        else:
            json[key][words[0]] = ' '.join(words[1:])
    print(dumps(json))

if __name__ == "__main__":
    main()

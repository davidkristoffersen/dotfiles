local util = require('util')
util.init_module('autostart')

require('background')
require('foreground')

util.deinit_module()

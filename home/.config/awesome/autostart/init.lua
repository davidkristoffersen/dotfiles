local m = require('util.init').module

m.init()

require('background')
require('foreground')

m.cleanup()

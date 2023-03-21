local m = require('util.module')

m.init()

require('background')
require('foreground')

m.cleanup()

local m = require('helpers.module')

m.init()

require('background')
require('foreground')

m.cleanup()

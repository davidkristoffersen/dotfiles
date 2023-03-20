-- local dir = require('util.module').script_path()

local module = require('util.module')

return {
    init_module = module.init_module,
    deinit_module = module.deinit_module,
}

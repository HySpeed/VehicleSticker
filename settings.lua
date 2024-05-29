---Settings

local Constants = require( "common.constants" )

-- runtime-global settings (can be changed in game)
data:extend {
  {
    name          = "vs_add_locomotive_sticker",
    setting_type  = "runtime-global",
    type          = "bool-setting",
    default_value = true,
    order         = "vs-als"
  },
  {
    name          = "vs_add_wagon_sticker",
    setting_type  = "runtime-global",
    type          = "bool-setting",
    default_value = true,
    order         = "vs-aws"
  }
}

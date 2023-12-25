-- Utility functions

local Constants  = require( "common.constants"   )
local random = math.random

local Utils = {}

-- =============================================================================

function Utils.getColor( player )
  local rgb_flow = player.gui.screen.sticker_ui.sticker_content_flow.sticker_content_rgb_flow
  local r = math.min( tonumber( rgb_flow.sticker_r_flow.sticker_rgb_r_textfield.text ), 255 )
  local g = math.min( tonumber( rgb_flow.sticker_g_flow.sticker_rgb_g_textfield.text ), 255 )
  local b = math.min( tonumber( rgb_flow.sticker_b_flow.sticker_rgb_b_textfield.text ), 255 )
  local color = {r = r, g = g, b = b}

  return color
end

-- -----------------------------------------------------------------------------

function Utils.createColorRGB()
  local r = random( 100, 200)
  local g = random( 100, 200)
  local b = random( 100, 200)
  return r, g, b
end

-- -----------------------------------------------------------------------------

function Utils.isSupportedType( selectedType )
  local isSupported = false

  if    selectedType == Constants.LOCOMOTIVE
     or selectedType == Constants.CAR
     or selectedType == Constants.TANK
     or selectedType == Constants.SPIDERTRON
     or selectedType == Constants.CARGO_WAGON
     or selectedType == Constants.FLUID_WAGON
     or selectedType == Constants.ARTILLERY_WAGON
    then
      isSupported = true
  end
  return isSupported
end

-- -----------------------------------------------------------------------------

--[[
  game.surfaces[1].find_entities_filtered( { name = "cargo-wagon" })
1: <LuaEntity>{name="cargo-wagon", type="cargo-wagon", unit_number=46}
2: <LuaEntity>{name="cargo-wagon", type="cargo-wagon", unit_number=45}
]]

-- build list of wagons, loop through looking for unit_number that is not used
-- ? secondary check to ensure name not used?
-- global.stickers[selected.unit_number]
function Utils.selectVehicle( player, vehicle_type )
  local selected = nil

  local wagons = player.surface.find_entities_filtered( { name = vehicle_type } )
  for wagon in pairs( wagons ) do
    if global.stickers[wagons[wagon].unit_number] == nil then  -- if no render_id, it is not 'claimed'
      selected = wagons[wagon]
    end
  end

  return selected
end

-- -----------------------------------------------------------------------------

function Utils.skipIntro()
  if Constants.DEV_MODE then
    if remote.interfaces["freeplay"] then -- In "sandbox" mode, freeplay is not available
      remote.call( "freeplay", "set_disable_crashsite", true ) -- removes crashsite and cutscene start
      remote.call( "freeplay", "set_skip_intro", true )        -- Skips popup message to press tab to start playing
    end
  end
end

-- =============================================================================

return Utils

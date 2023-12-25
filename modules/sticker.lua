-- Sticker module
-- processes sticker event

local Constants  = require( "common.constants"   )
local Utils      = require( "common.utils" )
local StickerUI  = require( "modules.sticker_ui" )
local Validators = require( "common.validators" )

local Sticker = {}

-- =============================================================================

function Sticker.applySticker( selected, stickerText, color )

  local existing_id = global.stickers[selected.unit_number]
  if existing_id then rendering.destroy( existing_id ) end

  local render_id = rendering.draw_text({
    alignment = "center",
    color     = color,
    scale     = 2,
    scale_with_zoom = true,
    surface   = selected.surface,
    target    = selected,
    target_offset = { 0.0, -1.0 },
    text      = stickerText
  })

  global.stickers[selected.unit_number] = render_id -- store the render id for later reference
end

-- -----------------------------------------------------------------------------

function Sticker.pasteSticker( target, source_render_id )
  -- remove existing, if any
  local unit_number = target.unit_number
  local check_target_id = global.stickers[unit_number]
  if check_target_id ~= nil then rendering.destroy( check_target_id ) end

  local render_id = rendering.draw_text({
    alignment = "center",
    color     = rendering.get_color( source_render_id ),
    scale     = 2,
    scale_with_zoom = true,
    surface   = rendering.get_surface( source_render_id ),
    target    = target,
    target_offset = { 0.0, -1.0 },
    text      = rendering.get_text( source_render_id )
  })

  global.stickers[target.unit_number] = render_id -- store the render id for later reference

end
-- -----------------------------------------------------------------------------

function Sticker.saveSticker( event )
  local selected = global.stickers.selected[event.player_index]
  local player = game.players[event.player_index]
  local stickerText = player.gui.screen.sticker_ui.sticker_content_flow.sticker_content_name_flow.sticker_textfield.text
  local color = Utils.getColor( player )
  Sticker.applySticker( selected,  stickerText, color )
  StickerUI.destroy_sticker_frame( event )
end


-- -----------------------------------------------------------------------------
-- External interface for action
function Sticker.addWagonSticker( player_name, message, r, g, b )
  if settings.global["vs_add_wagon_sticker"].value ~= true then return end
  -- game.print( { "", {"vs-text.name"}, {"vs-text.add_wagon_sticker"}, message } )

  -- validations (on error, most will display a message and return nil or false)
  local player = Validators.validatePlayerName( player_name )
  if not player then return end
  if not Validators.validateMessage( message ) then return end
  if not Validators.validateColorRGB( r, g, b ) then
    r, g, b = Utils.createColorRGB()
  end
  local color = { r, g, b }

  local selected = Utils.selectVehicle( player, "cargo-wagon" )
  if selected ~= nil then
    Sticker.applySticker( selected, message, color )
    local gps = string.format( "[gps=%s,%s,%s]", selected.position.x, selected.position.y, player.surface.name )
    game.print( { "", { "vs-text.added_sticker", message, gps } } )
  else
    game.print( { "", {"vs-text.name"}, {"vs-error.no_wagon", message} }, Constants.COLOR.ERROR )
  end

end

-- =============================================================================

return Sticker

-- Sticker module
-- processes sticker event

local Constants  = require( "common.constants"   )
local Utils      = require( "common.utils" )
local StickerUI  = require( "modules.sticker_ui" )
local Validators = require( "common.validators" )

local Sticker = {}

-- =============================================================================

function Sticker.applySticker( selected, surface, stickerText, color )

  local unit_number = selected.unit_number
  local existing_id = global.stickers[unit_number]
  if existing_id then
    rendering.destroy( existing_id )
    global.stickers[unit_number] = nil -- store the render id for later reference
  end
  if stickerText == nil or stickerText == "" then return end -- an empty label results in removing the sticker

  local render_id = rendering.draw_text({
    alignment = "center",
    color     = color,
    scale     = 2,
    scale_with_zoom = true,
    surface   = surface,
    target    = selected,
    target_offset = { 0.0, -1.0 },
    text      = stickerText,
    use_rich_text = true
  })

  global.stickers[unit_number] = render_id -- store the render id for later reference
end

-- -----------------------------------------------------------------------------

function Sticker.pasteSticker( event )

  if event.source == nil or event.source.name           == nil   then return end -- no source and name
  if event.destination == nil or event.destination.name == nil   then return end -- no destination and name
  if Utils.isSupportedType( event.source.name )         == false then return end -- source is not a supported vehicle
  if Utils.isSupportedType( event.destination.name )    == false then return end -- dest   is not a supported vehicle
  if global.stickers[event.source.unit_number]          == nil   then return end -- no sticker on source vehicle

  local render_id = global.stickers[event.source.unit_number]
  local surface   = rendering.get_surface( render_id )
  local text      = rendering.get_text(    render_id )
  local color     = rendering.get_color(   render_id )
  Sticker.applySticker( event.destination, surface, text, color )

end
-- -----------------------------------------------------------------------------

function Sticker.saveSticker( event )
  local selected = global.stickers.selected[event.player_index]
  local player = game.players[event.player_index]
  local stickerText = player.gui.screen.sticker_ui.sticker_content_flow.sticker_content_name_flow.sticker_textfield.text
  local color = Utils.getColor( player )
  Sticker.applySticker( selected,  selected.surface, stickerText, color )
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
    Sticker.applySticker( selected, selected.surface, message, color )
    local gps = string.format( "[gps=%s,%s,%s]", selected.position.x, selected.position.y, player.surface.name )
    game.print( { "", { "vs-text.added_sticker", message, gps } } )
  else
    game.print( { "", {"vs-text.name"}, {"vs-error.no_wagon", message} }, Constants.COLOR.ERROR )
  end

end

-- =============================================================================

return Sticker

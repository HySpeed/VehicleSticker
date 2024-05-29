-- Vehicle Sticker
-- Apply a sticker to a vehicle

-- thanks to GotLag for 'Renamer' and the functions from that were used.
-- thanks to Aeodin for the graphics


local Constants = require( "common.constants"   )
local Utils     = require( "common.utils" )
local Sticker   = require( "modules.sticker" )
local StickerUI = require( "modules.sticker_ui" )

-- =============================================================================

local function onLoad()
  -- Allow for events through integration to apply stickers.
  remote.remove_interface( "vehicleSticker" )
  remote.add_interface( "vehicleSticker", {
    add_locomotive_sticker=Sticker.addLocomotiveSticker,
    add_wagon_sticker=Sticker.addWagonSticker
  } )
  end

-- =============================================================================

script.on_init( function()
  global = global or {}
  global.stickers = {}
  global.stickers.selected = {}
  Utils.skipIntro()
  onLoad()
end )

-- -----------------------------------------------------------------------------

script.on_load( onLoad )

-- -----------------------------------------------------------------------------

-- open gui dialog is clicked
script.on_event( defines.events.on_gui_click, function( event )
  if    event.element.name == "sticker_save" then
    Sticker.saveSticker( event )
  elseif event.element.name == "sticker_cancel" then
    StickerUI.destroy_sticker_frame( event )
  end
end )

-- -----------------------------------------------------------------------------

-- Enter is pressed in a Lua GUI
script.on_event( defines.events.on_gui_confirmed, function( event )
  if event.element.name == "sticker_textfield" or
     event.element.name == "sticker_rgb_r_textfield" or
     event.element.name == "sticker_rgb_g_textfield" or
     event.element.name == "sticker_rgb_b_textfield" then
    Sticker.saveSticker( event )
  end
end )

-- -----------------------------------------------------------------------------

-- Escape is pressed in a Lua GUI
script.on_event( defines.events.on_gui_closed, function(event)
  if  event.element and
    ( event.element.name == "sticker_textfield" or
      event.element.name == "sticker_rgb_r_textfield" or
      event.element.name == "sticker_rgb_g_textfield" or
      event.element.name == "sticker_rgb_b_textfield" ) then
    StickerUI.destroy_sticker_frame( event )
  end
end )

-- -----------------------------------------------------------------------------

-- Hotkey is pressed
script.on_event( "sticker", function( event )
  if not event.player_index then return end
  local player = game.players[event.player_index]
  if not player then return end
  local selected = player.selected
  if not selected then return end

  if Utils.isSupportedType( selected.type ) then
    global.stickers.selected[event.player_index] = selected
    StickerUI.onGuiOpened( event )
  end
end )

-- -----------------------------------------------------------------------------

script.on_event( { defines.events.on_player_created,
                   defines.events.on_player_joined_game },
  function( event )
    local player = game.get_player( event.player_index )
    if player and player.connected then
      game.print( {"vs-text.init"} )
    end
  end 
)

-- -----------------------------------------------------------------------------

-- -- Paste is pressed
-- -- if 'supported type' get source info and paste to target
-- -- note: this only triggers on paste that aligns with valid target.  Cannot paste "locomotive" to "cargo-wagon"
script.on_event( defines.events.on_entity_settings_pasted , function( event )
  Sticker.pasteSticker( event )
end )

-- =============================================================================

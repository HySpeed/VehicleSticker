-- UI Components

local mod_gui   = require( "mod-gui" )

local StickerUI = {}

-- =============================================================================

local function create_sticker_label_frame( event )
  local player = game.players[event.player_index]
  local screen = player.gui.screen
  local selected = global.stickers.selected[event.player_index]
  local existing_id = global.stickers[selected.unit_number]

  if screen.sticker_ui then
    screen.sticker_ui.destroy()
  end

  local sticker_frame = screen.add({
    type      = "frame",
    name      = "sticker_ui",
    style     = "frame",
    direction = "vertical"
  })
  sticker_frame.style.bottom_padding = 4
  local frame_title = sticker_frame.add({
    type      = "flow",
    name      = "sticker_titlebar_flow",
    style     = "sticker_titlebar_flow"
  })
  local label = frame_title.add({
    type      = "label",
    name      = "sticker_titlebar_label",
    style     = "frame_title",
    caption   = {"vs-text.sticker_label"}
  })
  label.drag_target = sticker_frame
  local filler = frame_title.add({
    type  = "empty-widget",
    name  = "sticker_title_filler",
    style = "draggable_space_header"
  })
  filler.style.horizontally_stretchable = true
  filler.style.natural_height = 24
  filler.style.right_margin   = 7
  filler.style.left_margin    = 7
  filler.drag_target = sticker_frame
  frame_title.add({
    type   = "sprite-button",
    name   = "sticker_cancel",
    sprite = "utility/close_white",
    style  = "frame_action_button"
  })
  -- content
  local content = sticker_frame.add({
    type = "flow",
    name = "sticker_content_flow",
    direction = "vertical"
  })
  content.style.vertical_align = "center"
  -- name
  local content_name = content.add({
    type = "flow",
    name = "sticker_content_name_flow"
  })
  content_name.add({
    type = "label",
    caption = {"vs-text.sticker_name"}
  })
  content_name.style.vertical_align = "center"

  local text = nil
  if existing_id then
    text = rendering.get_text( existing_id )
  else
    text = "" -- avoids warning for type string
  end
  local sticker_textfield = content_name.add({
    type = "textfield",
    name = "sticker_textfield",
    text = text
  })
  -- rgb
  local rgb_content = content.add({
    type = "flow",
    name = "sticker_content_rgb_flow",
    direction = "vertical"
  })
  rgb_content.style.vertical_align = "center"
  -- r
  local r_flow = rgb_content.add({
    type = "flow",
    name = "sticker_r_flow"
  })
  r_flow.add({
    type = "label",
    caption = "R: "
  })
  local r = 110
  if existing_id then
     r = math.floor( rendering.get_color( existing_id ).r * 255 )
  end
  r_flow.add({
    type = "textfield",
    name = "sticker_rgb_r_textfield",
    numeric = true,
    text = r
  })
  
  -- g
  local g_flow = rgb_content.add({
    type = "flow",
    name = "sticker_g_flow"
  })
  g_flow.add({
    type = "label",
    caption = "G: "
  })
  local g = 111
  if existing_id then
     g = math.floor( rendering.get_color( existing_id ).g * 255 )
  end
  g_flow.add({
    type = "textfield",
    name = "sticker_rgb_g_textfield",
    numeric = true,
    text = g
  })
  -- b
  local b_flow = rgb_content.add({
    type = "flow",
    name = "sticker_b_flow"
  })
  b_flow.add({
    type = "label",
    caption = "B: "
  })
  local b = 112
  if existing_id then
     b = math.floor( rendering.get_color( existing_id ).b * 255 )
  end
  b_flow.add({
    type = "textfield",
    name = "sticker_rgb_b_textfield",
    numeric = true,
    text = b
  })
  -- save
  local save_button = content.add({
    type    = "sprite-button",
    name    = "sticker_save",
    sprite  = "virtual-signal/signal-check",
    style   = "confirm_button",
    tooltip = {"sticker-gui-tooltips.save_button"}
  })
  save_button.style.top_margin = 1
  sticker_textfield.select_all()
  sticker_textfield.focus()
  sticker_frame.force_auto_center()
  player.opened = sticker_textfield

  return sticker_frame
end


-- =============================================================================

function StickerUI.onGuiOpened( event )
  return create_sticker_label_frame( event )
end

-------------------------------------------------------------------------------

function StickerUI.destroy_sticker_frame( event )
  local player = game.players[event.player_index]
  local screen = player.gui.screen
  if screen.sticker_ui then
    screen.sticker_ui.destroy()
  end
  global.stickers.selected[event.player_index] = nil
end

-- =============================================================================

return StickerUI

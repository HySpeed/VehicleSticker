data:extend({
  {
    type = "custom-input",
    name = "sticker",
    key_sequence = "CONTROL + ALT + S",
    consuming = "none"
  }
})

data.raw["gui-style"].default["sticker_titlebar_flow"] = {
  type = "horizontal_flow_style",
  direction = "horizontal",
  horizontally_stretchable = "on",
  vertical_align = "center"
}

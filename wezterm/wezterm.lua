local wezterm = require("wezterm")
local config = wezterm.config_builder()

config({
  front_end = "WebGpu",
  color_scheme = "Catppuccin Mocha",
  font = wezterm.font("Cozette"),
  enable_scroll_bar = true,
  enable_tab_bar = true,
  enable_wayland = false,
})

return config

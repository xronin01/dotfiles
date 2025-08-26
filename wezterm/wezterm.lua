local wezterm = require("wezterm")
local config = wezterm.config_builder()

config({
  color_scheme = "Catppuccin Mocha",
  font = wezterm.font("Cozette"),
  front_end = "WebGpu",
  enable_wayland = false,
  enable_scroll_bar = true,
  enable_tab_bar = true,
})

return config

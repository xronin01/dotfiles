local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.front_end = "WebGpu"
config.color_scheme = "Catppuccin Mocha"
-- config.font = wezterm.font("CozetteVector")
config.enable_scroll_bar = true
config.enable_tab_bar = true
config.enable_wayland = false

return config

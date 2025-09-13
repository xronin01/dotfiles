---@type Wezterm
local wezterm = require("wezterm")

---@type Config
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("Cozette")
config.front_end = "WebGpu"
config.enable_wayland = false
config.enable_scroll_bar = true
config.enable_tab_bar = true

return config

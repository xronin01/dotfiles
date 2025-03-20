local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gc = require("gears.color")
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local palette = {
  --- Catppuccin mocha
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#cba6f7",
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  text = "#cdd6f4",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay0 = "#6c7086",
  surface2 = "#585b70",
  surface1 = "#45475a",
  surface0 = "#313244",
  base = "#1e1e2e",
  mantle = "#181825",
  crust = "#11111b",
}

local icons = {
  --- Window layouts
  tile = themes_path .. "default/layouts/tilew.png",
  tileleft = themes_path .. "default/layouts/tileleftw.png",
  tilebottom = themes_path .. "default/layouts/tilebottomw.png",
  tiletop = themes_path .. "default/layouts/tiletopw.png",
  floating = themes_path .. "default/layouts/floatingw.png",
  --- Titlebar buttons
  close = themes_path .. "default/titlebar/close_normal.png",
  maximized_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png",
  maximized_active = themes_path .. "default/titlebar/maximized_normal_active.png",
  minimize = themes_path .. "default/titlebar/minimize_normal.png",
  floating_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png",
  floating_active = themes_path .. "default/titlebar/floating_normal_active.png",
  ontop_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png",
  ontop_active = themes_path .. "default/titlebar/ontop_normal_active.png",
  sticky_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png",
  sticky_active = themes_path .. "default/titlebar/sticky_normal_active.png",
  --- Menu
  submenu = themes_path .. "default/submenu.png",
}

local theme = {}

theme.font = "Maple Mono NF 9"
theme.hotkeys_font = " Maple Mono NF 9"
theme.hotkeys_description_font = "Maple Mono NF 8"

theme.useless_gap = dpi(2)
theme.border_width = dpi(1)
theme.client_border_width = dpi(2)
theme.hotkeys_border_width = dpi(2)
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

--- Set colors
theme.bg_normal = palette.mantle
theme.bg_focus = palette.lavender
theme.bg_urgent = palette.red
theme.bg_minimize = palette.crust
theme.bg_systray = palette.mantle

theme.fg_normal = palette.text
theme.fg_focus = palette.mantle
theme.fg_urgent = palette.text
theme.fg_minimize = palette.subtext0

theme.border_color_normal = palette.mantle
theme.border_color_active = palette.lavender
theme.border_color_marked = palette.red

theme.hotkeys_modifiers_fg = palette.lavender
theme.hotkeys_border_color = palette.lavender
theme.hotkeys_label_bg = palette.red

theme.taglist_bg_empty = palette.surface0
theme.taglist_bg_occupied = palette.surface1
-- theme.titlebar_bg_focus = palette.mantle
-- theme.titlebar_fg_focus = palette.text

theme.btn_normal = palette.text
theme.btn_focus = palette.mantle
theme.layout_color = palette.text
theme.submenu_color = palette.crust

--- Set image icons
theme.titlebar_close_button_normal = gc.recolor_image(icons.close, theme.btn_normal)
theme.titlebar_close_button_focus = gc.recolor_image(icons.close, theme.btn_focus)

theme.titlebar_maximized_button_normal_inactive = gc.recolor_image(icons.maximized_inactive, theme.btn_normal)
theme.titlebar_maximized_button_focus_inactive = gc.recolor_image(icons.maximized_inactive, theme.btn_focus)
theme.titlebar_maximized_button_normal_active = gc.recolor_image(icons.maximized_active, theme.btn_normal)
theme.titlebar_maximized_button_focus_active = gc.recolor_image(icons.maximized_active, theme.btn_focus)

theme.titlebar_minimize_button_normal = gc.recolor_image(icons.minimize, theme.btn_normal)
theme.titlebar_minimize_button_focus = gc.recolor_image(icons.minimize, theme.btn_focus)

theme.titlebar_floating_button_normal_inactive = gc.recolor_image(icons.floating_inactive, theme.btn_normal)
theme.titlebar_floating_button_focus_inactive = gc.recolor_image(icons.floating_inactive, theme.btn_focus)
theme.titlebar_floating_button_normal_active = gc.recolor_image(icons.floating_active, theme.btn_normal)
theme.titlebar_floating_button_focus_active = gc.recolor_image(icons.floating_active, theme.btn_focus)

theme.titlebar_ontop_button_normal_inactive = gc.recolor_image(icons.ontop_inactive, theme.btn_normal)
theme.titlebar_ontop_button_focus_inactive = gc.recolor_image(icons.ontop_inactive, theme.btn_focus)
theme.titlebar_ontop_button_normal_active = gc.recolor_image(icons.ontop_active, theme.btn_normal)
theme.titlebar_ontop_button_focus_active = gc.recolor_image(icons.ontop_active, theme.btn_focus)

theme.titlebar_sticky_button_normal_inactive = gc.recolor_image(icons.sticky_inactive, theme.btn_normal)
theme.titlebar_sticky_button_focus_inactive = gc.recolor_image(icons.sticky_inactive, theme.btn_focus)
theme.titlebar_sticky_button_normal_active = gc.recolor_image(icons.sticky_active, theme.btn_normal)
theme.titlebar_sticky_button_focus_active = gc.recolor_image(icons.sticky_active, theme.btn_focus)

theme.layout_tile = gc.recolor_image(icons.tile, theme.layout_color)
theme.layout_tileleft = gc.recolor_image(icons.tileleft, theme.layout_color)
theme.layout_tilebottom = gc.recolor_image(icons.tilebottom, theme.layout_color)
theme.layout_tiletop = gc.recolor_image(icons.tiletop, theme.layout_color)
theme.layout_floating = gc.recolor_image(icons.floating, theme.layout_color)

theme.menu_submenu_icon = gc.recolor_image(icons.submenu, theme.submenu_color)

theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.bg_normal)

theme.icon_theme = nil

return theme

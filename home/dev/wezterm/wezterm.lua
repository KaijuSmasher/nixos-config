local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Tokyo Night Storm'

-- Window
config.enable_wayland = false
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14

return config

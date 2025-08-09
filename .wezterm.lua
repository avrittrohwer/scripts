local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.leader = { key = 'a', mods = 'CTRL', timout_milliseconds = 500 }
config.keys = {
    {
        mods = 'LEADER',
        key = 'j',
        action = wezterm.action.ActivatePaneDirection 'Down'
    },
    {
        mods = 'LEADER',
        key = 'k',
        action = wezterm.action.ActivatePaneDirection 'Up'
    },
    {
        mods = 'LEADER',
        key = 'h',
        action = wezterm.action.ActivatePaneDirection 'Left'
    },
    {
        mods = 'LEADER',
        key = 'l',
        action = wezterm.action.ActivatePaneDirection 'Right'
    },
    {
        mods = 'LEADER',
        key = 'UpArrow',
        action = wezterm.action.AdjustPaneSize { 'Up', 5 }
    },
    {
        mods = 'LEADER',
        key = 'DownArrow',
        action = wezterm.action.AdjustPaneSize { 'Down', 5 }
    },
    {
        mods = 'LEADER',
        key = 'LeftArrow',
        action = wezterm.action.AdjustPaneSize { 'Left', 5 }
    },
    {
        mods = 'LEADER',
        key = 'RightArrow',
        action = wezterm.action.AdjustPaneSize { 'Right', 5 }
    },
    {
        mods = 'LEADER',
        key = '\\',
        action = wezterm.action.SplitPane { direction = 'Right' }
    },
    {
        mods = 'LEADER',
        key = '-',
        action = wezterm.action.SplitPane { direction = 'Down' }
    },
    {
        mods = 'LEADER|SHIFT',
        key = 'Enter',
        action = wezterm.action.TogglePaneZoomState
    },
    {
        mods = 'LEADER',
        key = 'Enter',
        action = wezterm.action.Multiple{
            wezterm.action.RotatePanes 'Clockwise',
            wezterm.action.ActivatePaneDirection 'Next',
        },
    },
}
for i = 1, 8 do
    table.insert(config.keys, {
        mods = 'LEADER',
        key = tostring(i),
        action = wezterm.action.ActivateTab(i-1),
    })
end

config.scrollback_lines = 10000
config.initial_cols = 200
config.initial_rows = 80

config.use_fancy_tab_bar = true
config.inactive_pane_hsb = {
  brightness = 0.95,
  saturation = 0.2,
}

config.font_size = 12
config.font = wezterm.font(
    'Hermit',
    { weight = 'Regular' }
)
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.default_cursor_style = 'SteadyBlock'
--config.cursor_blink_ease_in = 'Constant'
--config.cursor_blink_ease_out = 'Constant'
--config.cursor_blink_rate = 1000

config.colors = {
  foreground = 'black',
  background = 'white',
  cursor_fg = 'black',
  cursor_bg = '#a8a8a8',

  -- xterm colors except for not https://www.ditig.com/256-colors-cheat-sheet
  ansi = {
      '#000000', -- black
      '#ff0000', -- red
      '#00ff00', -- lime
      '#dede00', -- yellow, dimmer
      '#0000ff', -- blue
      '#ff00ff', -- fuchsia
      '#00dddd', -- aqua, dimmer
      '#c0c0c0', -- silver
  },
  brights = {
      '#808080', -- grey
      '#ff0000', -- red
      '#00ff00', -- lime
      '#ffff00', -- yellow
      '#0000ff', -- blue
      '#ff00ff', -- fuchsia
      '#00ffff', -- aqua
      '#ffffff', -- white
  },
}

return config

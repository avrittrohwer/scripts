local wezterm = require('wezterm')
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
  saturation = 0.7,
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
  cursor_bg = 'hsl: 0 0 80',

  -- hsl based xterm colors https://www.ditig.com/256-colors-cheat-sheet
  ansi = {
      'hsl: 0 0 0', -- black
      'hsl: 0 100 37',-- marooon
      'hsl: 120 100 37',-- green
      'hsl: 60 100 37', -- olive
      'hsl: 240 100 37', -- navy
      'hsl: 300 100 37', -- purple
      'hsl: 180 100 37', -- teal
      'hsl: 0 0 95', -- silver
  },
  brights = {
      'hsl: 0 0 30', -- grey
      'hsl: 0 100 50',-- red
      'hsl: 120 100 50',-- lime
      'hsl: 60 100 50', -- yellow
      'hsl: 240 100 50', -- blue
      'hsl: 300 100 50', -- magenta
      'hsl: 180 100 50', -- cyan
      'hsl: 0 0 100', -- white
  },
}

return config

local wezterm = require 'wezterm'
local act = wezterm.action

local function font_with_fallback(name, params)
  local names = { name, 'Noto Color Emoji', 'JetBrains Mono' }
  return wezterm.font_with_fallback(names, params)
end

local function get_appearance()
  if wezterm.gui then return wezterm.gui.get_appearance() end
  return 'Dark'
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then return 'GruvboxDark' end
  return 'Gruvbox (Gogh)'
end

local function colors_for_appearance(appearance)
  if appearance == nil then return {} end
  if appearance:find 'Dark' then
    return {
      foreground = '#ebdbb2',
      background = '#282828',

      cursor_bg = '#bdae93',
      cursor_fg = '#665c54',

      selection_fg = '#ebdbb2',
      selection_bg = '#d65d0e',

      scrollbar_thumb = '#222222',

      split = '#444444',

      ansi = {
        '#3c3836',
        '#cc241d',
        '#98971a',
        '#d79921',
        '#458588',
        '#b16286',
        '#689d6a',
        '#a89984',
      },
      brights = {
        '#928374',
        '#fb4934',
        '#b8bb26',
        '#fabd2f',
        '#83a598',
        '#d3869b',
        '#8ec07c',
        '#fbf1c7',
      },

      indexed = { [136] = '#af8700' },
      compose_cursor = 'orange',
    }
  else
    return {}
  end
end

wezterm.on('update-status', function(window, pane)
  local leader = ''
  if window:leader_is_active() then leader = '(L)  ' end

  window:set_right_status(wezterm.format {
    { Text = leader .. window:active_workspace() .. '    ' },
  })
end)

wezterm.on(
  'window-config-reloaded',
  function(window, pane) window:toast_notification('wezterm', 'Configuration reloaded!', nil, 4000) end
)

local function tab_title(tab_info)
  local title = tab_info.tab_title
  local zoom = ''
  if tab_info.active_pane.is_zoomed then zoom = ' (Z)' end

  if title and #title > 0 then return title .. zoom end
  return tab_info.active_pane.title .. zoom
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab_title(tab)

  if tab.is_active then return {
    { Background = { Color = 'Black' } },
    { Text = ' ' .. title .. ' ' },
  } end
  return title
end)

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
  config:set_strict_mode(true)
end

config.term = 'wezterm'
config.adjust_window_size_when_changing_font_size = false
config.font = font_with_fallback('Maple Mono', { weight = 'Regular' })
config.font_size = 17.0
config.line_height = 1.45
config.font_rules = {
  { italic = true, font = font_with_fallback('Maple Mono', { weight = 'Regular', style = 'Italic' }) },
  {
    italic = true,
    intensity = 'Bold',
    font = font_with_fallback('Maple Mono', { weight = 'Bold', style = 'Italic' }),
  },
  { intensity = 'Bold', font = font_with_fallback('Maple Mono', { weight = 'Bold', style = 'Normal' }) },
}

config.use_resize_increments = false
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.window_decorations = 'INTEGRATED_BUTTONS | RESIZE| MACOS_FORCE_DISABLE_SHADOW'
config.allow_square_glyphs_to_overflow_width = 'Always'
config.command_palette_font_size = 17.0
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'HighPerformance'
config.default_cursor_style = 'SteadyBlock'

config.window_frame = {
  font = wezterm.font { family = 'Roboto', weight = 'Bold' },
  font_size = 14.0,
  active_titlebar_bg = '#333333',
  inactive_titlebar_bg = '#333333',
}

config.window_padding = {
  left = '1cell',
  right = '1cell',
  top = '0.5cell',
  bottom = '0.25cell',
}

config.color_scheme = scheme_for_appearance(get_appearance())
config.colors = colors_for_appearance(get_appearance())

config.leader = { key = '/', mods = 'SUPER', timeout_milliseconds = 2000 }

config.keys = {
  { key = 'UpArrow', mods = 'SUPER', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow', mods = 'SUPER', action = act.ActivatePaneDirection 'Down' },
  { key = 'LeftArrow', mods = 'SUPER', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'SUPER', action = act.ActivatePaneDirection 'Right' },
  { key = 'p', mods = 'SUPER', action = act.ActivateCommandPalette },
  { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },
  { key = 'e', mods = 'LEADER|CTRL', action = act.PaneSelect },
  { key = '%', mods = 'LEADER|SHIFT', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '"', mods = 'LEADER|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = '/', mods = 'LEADER|SUPER', action = act.ActivateLastTab },
  { key = 'i', mods = 'CTRL|SHIFT', action = act.SwitchToWorkspace },
  { key = 's', mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' } },
  { key = 'r', mods = 'LEADER', action = act.RotatePanes 'Clockwise' },
  { key = '[', mods = 'SUPER', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'SUPER', action = act.ActivateTabRelative(1) },
  { key = 'H', mods = 'LEADER', action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'J', mods = 'LEADER', action = act.AdjustPaneSize { 'Down', 5 } },
  { key = 'K', mods = 'LEADER', action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'L', mods = 'LEADER', action = act.AdjustPaneSize { 'Right', 5 } },
  {
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line is set only if enter key is pressed
        if line then window:active_tab():set_title(line) end
      end),
    },
  },
}

return config

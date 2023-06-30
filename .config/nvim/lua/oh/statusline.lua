local conditions = require 'heirline.conditions'
local utils = require 'heirline.utils'
local heirline = require 'heirline'

local function setup_colors()
  return {
    bright_bg = utils.get_highlight('StatusLine').fg,
    bright_fg = utils.get_highlight('StatusLine').bg,
    red = utils.get_highlight('DiagnosticError').fg,
    dark_red = utils.get_highlight('DiffDelete').bg,
    green = utils.get_highlight('String').fg,
    blue = utils.get_highlight('Function').fg,
    gray = utils.get_highlight('NonText').fg,
    orange = utils.get_highlight('Operator').fg,
    purple = utils.get_highlight('Statement').fg,
    cyan = utils.get_highlight('Special').fg,
    diag_warn = utils.get_highlight('DiagnosticWarn').fg,
    diag_error = utils.get_highlight('DiagnosticError').fg,
    diag_hint = utils.get_highlight('DiagnosticHint').fg,
    diag_info = utils.get_highlight('DiagnosticInfo').fg,
    git_del = utils.get_highlight('GitSignsDelete').fg,
    git_add = utils.get_highlight('GitSignsAdd').fg,
    git_change = utils.get_highlight('GitSignsChange').fg,
  }
end

local ViMode = {
  init = function(self)
    self.mode = vim.fn.mode(1)

    -- For operator mode
    if not self.once then
      vim.api.nvim_create_autocmd('ModeChanged', {
        pattern = '*:*o',
        command = 'redrawstatus',
      })
      self.once = true
    end
  end,

  static = {
    mode_names = {
      ['n'] = 'N',
      ['no'] = 'N?',
      ['nov'] = 'N?',
      ['noV'] = 'N?',
      ['no\22'] = 'N?',
      ['niI'] = 'Ni',
      ['niR'] = 'Nr',
      ['niV'] = 'Nv',
      ['nt'] = 'Nt',
      ['ntT'] = 'NtT',
      ['v'] = 'V',
      ['vs'] = 'Vs',
      ['V'] = 'V_',
      ['Vs'] = 'Vs',
      ['\22'] = '^V',
      ['\22s'] = '^V',
      ['s'] = 'S',
      ['S'] = 'S_',
      ['\19'] = '^S',
      ['i'] = 'I',
      ['ic'] = 'Ic',
      ['ix'] = 'Ix',
      ['R'] = 'R',
      ['Rc'] = 'Rc',
      ['Rx'] = 'Rx',
      ['Rv'] = 'Rv',
      ['Rvc'] = 'Rv',
      ['Rvx'] = 'Rv',
      ['c'] = 'C',
      ['cv'] = 'Ex',
      ['ce'] = 'Ex',
      ['r'] = '...',
      ['rm'] = 'M',
      ['r?'] = '?',
      ['!'] = '!',
      ['t'] = 'T',
    },
    mode_colors = {
      n = { bg = 'gray', fg = 'bright_fg' },
      i = { bg = 'orange', fg = 'gray' },
      v = { bg = 'cyan', fg = 'gray' },
      V = { bg = 'cyan', fg = 'gray' },
      ['\22'] = { bg = 'cyan', fg = 'gray' },
      c = { bg = 'orange', fg = 'gray' },
      s = { bg = 'purple', fg = 'gray' },
      S = { bg = 'purple', fg = 'gray' },
      ['\19'] = { bg = 'purple', fg = 'gray' },
      R = { bg = 'orange', fg = 'gray' },
      r = { bg = 'orange', fg = 'bright_fg' },
      ['!'] = { bg = 'red', fg = 'bright_fg' },
      t = { bg = 'red', fg = 'bright_fg' },
    },
  },

  provider = function(self)
    return '  %2(' .. self.mode_names[self.mode] .. '%) '
  end,

  hl = function(self)
    local mode = self.mode:sub(1, 1)
    local color = self.mode_colors[mode]
    return { fg = color.fg, bg = color.bg, bold = true }
  end,

  update = { 'ModeChanged' },
}

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
  end,

  provider = function(self)
    return self.icon and (' ' .. self.icon .. ' ')
  end,

  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileName = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,

  provider = function(self)
    -- Trim the pattern relative to the current directory.
    -- See :h filename-modifers for other options.
    local filename = vim.fn.fnamemodify(self.filename, ':.')
    if filename == '' then
      return '[No Name] '
    end

    -- If the filename occupies more than 1/4th of the available
    -- space, trim the file path to its initials
    if not conditions.width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename .. ' '
  end,

  hl = { fg = utils.get_highlight('Directory').fg },
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = '+',
    hl = { fg = 'green' },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = '',
    hl = { fg = 'orange' },
  },
}

FileNameBlock = utils.insert(
  FileNameBlock,
  FileIcon,
  FileName,
  FileFlags,
  { provider = '%<' } -- The statusline is cut here when there's not enough space
)

local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = '%7(%l/%L%):%2c %P',
}

local ScrollBar = {
  static = {
    sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = 'blue', bg = 'bright_bg' },
}

local LSPActive = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },

  provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
      table.insert(names, server.name)
    end
    return '  [' .. table.concat(names, ' ') .. '] '
  end,
  hl = { fg = 'green', bold = true },
}

local Align = { provider = '%=' }
local Space = { provider = ' ' }

local heirline_group = vim.api.nvim_create_augroup('Heirline', { clear = true })
vim.api.nvim_create_autocmd('ColorScheme', {
  group = heirline_group,
  callback = function()
    local colors = setup_colors()
    utils.on_colorscheme(colors)
  end,
})

heirline.setup {
  statusline = { ViMode, FileNameBlock, Align, LSPActive, Ruler, Space, ScrollBar },
}

heirline.load_colors(setup_colors())

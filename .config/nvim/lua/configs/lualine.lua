require('lualine').setup{
   options = {
      theme = 'gruvbox',
      -- component_separators = '|',
      -- section_separators = { left = '', right = '' },
   },
  --  sections = {
  --   lualine_a = {
  --     { 'mode', separator = { left = '' }, right_padding = 2 },
  --   },
  --   lualine_b = { 'filename', 'branch' },
  --   lualine_c = { 'fileformat' },
  --   lualine_x = {},
  --   lualine_y = { 'filetype', 'progress' },
  --   lualine_z = {
  --     { 'location', separator = { right = '' }, left_padding = 2 },
  --   },
  -- },
  -- inactive_sections = {
  --   lualine_a = { 'filename' },
  --   lualine_b = {},
  --   lualine_c = {},
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = { 'location' },
  -- },
  -- tabline = {},
  -- extensions = {},
}

function SpellToggle()
    if vim.opt.spell:get() then
        vim.opt_local.spell = false
        vim.opt_local.spelllang = "en"
    else
        vim.opt_local.spell = true
        vim.opt_local.spelllang = {"en_us", "de"}
    end
end

-- statusline
local git_branch = function()
    if vim.g.loaded_fugitive then
        local branch = vim.fn.FugitiveHead()
        if branch ~= '' then return string.upper(" " .. branch) end
    end
    return ''
end

local file_path = function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    if buf_name == "" then return "[No Name]" end
    local home = vim.env.HOME
    local is_term = false
    local file_dir = ""

    if buf_name:sub(1, 5):find("term") ~= nil then
        file_dir = vim.env.PWD
        is_term = true
    else
        file_dir = vim.fn.expand("%:p:h")
    end

    if file_dir:find(home, 0, true) ~= nil then
        file_dir = file_dir:gsub(home, "~", 1)
    end

    if vim.api.nvim_win_get_width(0) <= 80 then
        file_dir = vim.fn.pathshorten(file_dir)
    end

    if is_term then
        return file_dir
    else
        return string.format("%s/%s", file_dir, vim.fn.expand("%:t"))
    end
end

local word_count = function()
    if vim.fn.wordcount().visual_words ~= nil then
        return vim.fn.wordcount().visual_words
    else
        return vim.fn.wordcount().words
    end
end

local modes = setmetatable({
    ['n'] = {'NORMAL', 'N'},
    ['no'] = {'N·OPERATOR', 'N·P'},
    ['v'] = {'VISUAL', 'V'},
    ['V'] = {'V·LINE', 'V·L'},
    [''] = {'V·BLOCK', 'V·B'},
    [''] = {'V·BLOCK', 'V·B'},
    ['s'] = {'SELECT', 'S'},
    ['S'] = {'S·LINE', 'S·L'},
    [''] = {'S·BLOCK', 'S·B'},
    ['i'] = {'INSERT', 'I'},
    ['ic'] = {'INSERT', 'I'},
    ['R'] = {'REPLACE', 'R'},
    ['Rv'] = {'V·REPLACE', 'V·R'},
    ['c'] = {'COMMAND', 'C'},
    ['cv'] = {'VIM·EX', 'V·E'},
    ['ce'] = {'EX', 'E'},
    ['r'] = {'PROMPT', 'P'},
    ['rm'] = {'MORE', 'M'},
    ['r?'] = {'CONFIRM', 'C'},
    ['!'] = {'SHELL', 'S'},
    ['t'] = {'TERMINAL', 'T'}
}, {
    __index = function()
        return {'UNKNOWN', 'U'} -- handle edge cases
    end
})

local get_current_mode = function()
    local current_mode = vim.api.nvim_get_mode().mode
    if vim.api.nvim_win_get_width(0) <= 80 then
        return string.format('%s ', modes[current_mode][2])
    else
        return string.format('%s ', modes[current_mode][1])
    end
end

---@diagnostic disable-next-line: lowercase-global
function status_line()
    return table.concat {
        get_current_mode(), -- get current mode
        "%{toupper(&spelllang)}", -- display language and if spell is on
        git_branch(), -- branch name
        " %<", -- spacing
        file_path(), -- smart full path filename
        "%h%m%r%w", -- help flag, modified, readonly, and preview
        "%=", -- right align
        "%{get(b:,'gitsigns_status','')}[", -- gitsigns
        word_count(), -- word count
        "][%-3.(%l|%c]", -- line number, column number
        "[%{strlen(&ft)?&ft[0].&ft[1:]:'None'}]" -- file type
    }
end

-- vim.opt.statusline = "%!v:lua.status_line()"


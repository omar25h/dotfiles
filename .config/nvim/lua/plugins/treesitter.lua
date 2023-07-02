return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'UIEnter',
    version = false,
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
    },
    ---@type TSConfig
    opts = {
      highlight = { enable = true },
      indent = { enable = true, disable = { 'python' } },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = 'all',
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = '<nop>',
          node_decremental = '<bs>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ['af'] = { query = '@function.outer', desc = 'Select outer part of a function region' },
            ['if'] = { query = '@function.inner', desc = 'Select inner part of a function region' },
            ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class region' },
            ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
            ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v',
            ['@function.outer'] = 'V',
            ['@class.outer'] = '<c-v>',
          },
          include_surrounding_whitespace = true,
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
      additional_vim_regex_highlighting = false,
    },
    ---@param opts TSConfig
    config = function(_, opts)
      require('nvim-treesitter.install').compilers = { 'clang' }
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    'nvim-treesitter/playground',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}

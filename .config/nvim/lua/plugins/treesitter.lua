return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ":TSUpdate",
    dependencies = {
      'nvim-treesitter/completion-treesitter',
      'nvim-treesitter/nvim-treesitter-context',
    },
    ---@type TSConfig
    opts = {
      highlight = { enable = true },
      indent = { enable = true, disable = { "python" } },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = {
        'bash',
        'c',
        'fish',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'help',
        'html',
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'query',
        'regex',
        'rust',
        'toml',
        'vim',
        'yaml',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false
      require 'nvim-treesitter.install'.compilers = { 'clang' }
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

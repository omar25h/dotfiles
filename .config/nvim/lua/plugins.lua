-------------------------------------------------------------------------------------------------
-- Plugins
-------------------------------------------------------------------------------------------------

require'packer'.startup {
  function(use)
    use 'wbthomason/packer.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'mfussenegger/nvim-jdtls'

    -- Completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'saadparwaiz1/cmp_luasnip'

    use 'rafamadriz/friendly-snippets'

    -- Treesitter
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/completion-treesitter'
    use 'nvim-treesitter/nvim-treesitter-context'

    use 'editorconfig/editorconfig-vim'

    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' }
    }

    use {
      'kyazdani42/nvim-tree.lua',
      requires = 'kyazdani42/nvim-web-devicons',
    }

    use {
      'ur4ltz/surround.nvim',
      config = function()
        require'surround'.setup { mappings_style = 'sandwich' }
      end
    }

    use {
      'numToStr/Comment.nvim',
      config = function()
        require'Comment'.setup()
      end
    }


    use {
      'ellisonleao/gruvbox.nvim',
      requires = { 'rktjmp/lush.nvim' },
    }


    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
      },
    }

    use {
      'nvim-neorg/neorg',
      requires = { 'nvim-lua/plenary.nvim' },
    }

    use 'IndianBoy42/tree-sitter-just'

    use 'L3MON4D3/LuaSnip'

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' }
    }
  end
}


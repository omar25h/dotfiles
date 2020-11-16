" -------------------------------------------------------------------------------------------------
" plugins
" -------------------------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/completion-treesitter'

Plug 'sheerun/vim-polyglot'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'editorconfig/editorconfig-vim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'mileszs/ack.vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'

call plug#end()

" -------------------------------------------------------------------------------------------------
" general configuration
" -------------------------------------------------------------------------------------------------

set autoread
set autowrite
set mouse=a
set number relativenumber
set path+=**
set wildmenu
set splitbelow
set splitright
set nohlsearch
set termguicolors
set smartcase
set completeopt=menuone,noinsert,noselect
set omnifunc=v:lua.vim.lsp.omnifunc
set shortmess+=c

if exists($XDG_CONFIG_HOME)
    luafile $XDG_CONFIG_HOME/nvim/init.lua
else
    luafile ~/.config/nvim/init.lua
endif

syntax on

let mapleader=','

if &diff
    syntax off
endif

let g:filetype_m='objc'

" -------------------------------------------------------------------------------------------------
" styling
" -------------------------------------------------------------------------------------------------

colorscheme gruvbox

highlight LineNr ctermfg=1 guifg=#6F6F6F ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight CursorLineNr ctermbg=NONE guibg=NONE

highlight GitGutterAddDefault guibg=NONE
highlight GitGutterChangeDefault guibg=NONE
highlight GitGutterDeleteDefault guibg=NONE

" -------------------------------------------------------------------------------------------------
" airline
" -------------------------------------------------------------------------------------------------

let g:airline_powerline_fonts=1
let g:airline_theme='base16_gruvbox_dark_hard'

" -------------------------------------------------------------------------------------------------
" ack
" -------------------------------------------------------------------------------------------------

if executable('ag')
  let g:ackprg='ag --vimgrep'
endif

" -------------------------------------------------------------------------------------------------
" keymap
" -------------------------------------------------------------------------------------------------

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
nnoremap <leader>ne :LuaTreeToggle<CR>
nmap <C-S-T> :vs<bar>:b#<CR>
tnoremap <Esc> <C-\><C-n>

" lsp
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>rn     <cmd>lua vim.lsp.buf.rename()<CR>

" popup menu navigation
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" -------------------------------------------------------------------------------------------------
" vim-go
" -------------------------------------------------------------------------------------------------

let g:go_addtags_transform='snakecase'
let g:go_auto_type_info=0
let g:go_def_mode='gopls'
let g:go_diagnostics_enabled=0
let g:go_doc_keywordprg_enabled=0
let g:go_doc_popup_window=0
let g:go_doc_url='https://pkg.go.dev'
let g:go_fmt_autosave=0
let g:go_fmt_command='gopls'
let g:go_fmt_fail_silently=1
let g:go_gopls_complete_unimported='v:true'
let g:go_gopls_deep_completion='v:true'
let g:go_gopls_matcher='fuzzy'
let g:go_highlight_build_constraints=1
let g:go_highlight_extra_types=0
let g:go_highlight_fields=0
let g:go_highlight_function_calls=1
let g:go_highlight_functions=0
let g:go_highlight_interfaces=0
let g:go_highlight_operators=0
let g:go_highlight_structs=1
let g:go_highlight_types=1
let g:go_implements_mode='gopls'
let g:go_imports_autosave=0
let g:go_imports_mode='gopls'
let g:go_info_mode='gopls'
let g:go_list_type='quickfix'
let g:go_rename_command='gopls'
let g:go_test_timeout='30s'
let g:go_def_mapping_enabled=0
let g:go_gopls_enabled=0

highlight link goBuiltins Keyword

" -------------------------------------------------------------------------------------------------
" gitgutter settings
" -------------------------------------------------------------------------------------------------

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)


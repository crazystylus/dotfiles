call plug#begin('~/.vim/plugged')

Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'itchyny/lightline.vim'
" Plug 'chiel92/vim-autoformat'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'cespare/vim-toml'
" Plug 'stephpy/vim-yaml'
Plug 'chriskempson/base16-vim'
" Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'

call plug#end()
"source $HOME/.sources/base-16-themes/base16-atelier-dune-vim.vim

set shortmess+=c

syntax on
set completeopt=menuone,noinsert,noselect
set cmdheight=2


set nu
set history=999
set undolevels=999
set autoread
set nobackup
set nowritebackup
set noswapfile
set hlsearch        " highlights searches
set incsearch       " Best Match so far
set t_Co=256        " Set UI to 256 colour mode
set cursorline
set showmode
"set clipboard=unnamedplus,autoselect
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
filetype plugin indent on
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

set noexpandtab
set autoindent
set softtabstop=2
set tabstop=2
set shiftwidth=2
set smarttab
set wrap
set formatoptions=qrn1
set formatoptions-=o
set relativenumber " Relative line numbers
set number " Also show current absolute line
set pastetoggle=<leader>p

nnoremap <leader>c :set nolist!<CR>
nnoremap <silent> \ :silent nohlsearch<CR>
" Syntactic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Rust
let g:rustfmt_autosave = 1

"Keys maps
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
nnoremap ; :

" Remove irritating help
map <F1> <Esc>
imap <F1> <Esc>

" Ctrl+h get rids of highlighting
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

""" Colors for vim



""" Colors for Lightline

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ },
      \ }
set laststatus=2
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Preview function to be used with Okular on Markdown files
function! Preview()
	:call system('nohup okular '.shellescape(expand("%")).' &> /dev/null &')
endfunction
nnoremap pv :call Preview()<CR>

" Configure Ale for linting
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'vim': ['vint'],
    \ 'cpp': ['clang'],
    \ 'c': ['clang'],
		\ 'yaml': ['yamllint'],
		\ 'xml': ['xmllint'],
		\ 'json': ['jq'],
		\ 'go': ['gofmt'],
		\ 'sh': ['shellcheck'],
		\ 'rust': ['cspell'],
\}
let g:ale_set_highlights = 1
let g:ale_fixers = {
		\'*': ['remove_trailing_lines', 'trim_whitespace'],
		\'javascript': ['eslint'],
		\'cpp': ['clang-format'],
		\'c': ['clang-format'],
		\'yaml': ['yamlfix'],
		\ 'xml': ['xmllint'],
		\ 'rust': ['rustfmt'],
\}
let b:ale_fix_on_save = 1
" LSP Config
lua << END
local lspconfig = require'lspconfig'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      completion = {
	postfix = {
	  enable = false,
	},
      },
    },
  },
  capabilities = capabilities,
}
END

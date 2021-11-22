call plug#begin('~/.vim/plugged')

Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'itchyny/lightline.vim'
Plug 'chiel92/vim-autoformat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'chriskempson/base16-vim'
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'

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
\}
let g:ale_set_highlights = 0
let g:ale_fixers = {
		\'*': ['remove_trailing_lines', 'trim_whitespace'],
		\'javascript': ['eslint'],
		\'cpp': ['clang-format'],
		\'c': ['clang-format'],
		\'yaml': ['yamlfix'],
		\ 'xml': ['xmllint'],
\}
let b:ale_fix_on_save = 1

call plug#begin('~/.vim/plugged')

Plug 'vim-syntastic/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'chiel92/vim-autoformat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


set shortmess+=c

syntax on
set completeopt=menuone,noinsert,noselect
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

set expandtab
set autoindent smartindent
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

""" Customize colors
hi Pmenu ctermbg=DarkGrey guibg=DarkGrey ctermfg=White
hi CocFloating ctermbg=DarkGrey guibg=DarkGrey ctermfg=White
hi CocErrorFloat ctermbg=DarkGrey guibg=DarkGrey ctermfg=White
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

au BufWrite * :Autoformat

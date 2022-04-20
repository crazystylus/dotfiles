call plug#begin('~/.vim/plugged')

" Enhancements
Plug 'ciaranm/securemodelines'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" GUI Enhancements
Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'

" Fuzzy Finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language Support
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'
Plug 'neovim/nvim-lspconfig'

" Extended LSP Support
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'

" Only because nvim-cmp _requires_ snippets
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'

call plug#end()

" Theme Setup
set termguicolors
colorscheme base16-atelier-dune

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

set mouse=a " Enable mouse usage (all modes) in terminals
set listchars=nbsp:¬,extends:»,precedes:«,trail:• " Show hidden characters

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
filetype plugin indent on
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

set expandtab
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

" Rust
let g:rustfmt_autosave = 1

" Keys maps
nnoremap <up> <nop>
nnoremap <down> <nop>

" Arrow keys for buffer switching
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
nnoremap ; :
nmap <leader>; :Buffers<CR>
map <C-p> :Files<CR>

" Show or hide hidden characters
nnoremap <leader>, :set invlist<cr>

" Remove irritating help
map <F1> <Esc>
imap <F1> <Esc>

" Ctrl+h get rids of highlighting " For older versions of NVIM
" vnoremap <C-h> :nohlsearch<cr>
" nnoremap <C-h> :nohlsearch<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Securemode Lines Config
let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "colorcolumn"
                \ ]

" Colors for Lightline
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

" Permanent undo
set undodir=~/.vimdid
set undofile

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

let g:ale_set_highlights = 0 " Disable ALE Highlights
let g:ale_fixers = {
		\'*': ['remove_trailing_lines', 'trim_whitespace'],
		\'javascript': ['eslint'],
		\'cpp': ['clang-format'],
		\'c': ['clang-format'],
		\'yaml': ['yamlfix'],
		\'xml': ['xmllint'],
		\'rust': ['rustfmt'],
\}

let b:ale_fix_on_save = 1

" LSP Config
lua << END
local lspconfig = require'lspconfig'
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping.confirm({ select = true })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  })
})

-- LSP Setup
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


  -- Get signatures (and _only_ signatures) when in argument lists.
  require "lsp_signature".on_attach({
    doc_lines = 0,
    handler_opts = {
      border = "none"
    },
  })
end
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { 'pyright', 'tsserver' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
	  settings = {
			completion = {
				postfix = {
					enable = false,
				},
			},
		},
	  capabilities = capabilities,
  }
end

-- Rust Analyzer Setup
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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

-- Treesitter Setup
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "python", "rust", "cpp", "go", "vim", "lua" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

END

" Inlay hints in Rust
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }

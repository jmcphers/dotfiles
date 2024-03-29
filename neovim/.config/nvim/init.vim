call plug#begin('~/.local/share/nvim/plugged')

Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'freitass/todo.txt-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'vimwiki/vimwiki'
Plug 'flazz/vim-colorschemes'
Plug 'jalvesaq/vimcmdline'
Plug 'mbbill/undotree'
Plug 'machakann/vim-highlightedyank'
Plug 'Olical/vim-enmasse'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'radenling/vim-dispatch-neovim'
Plug 'junegunn/fzf.vim'
Plug 'chrisbra/Colorizer'
Plug 'kana/vim-textobj-user'
Plug 'reedes/vim-textobj-quote'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mileszs/ack.vim'


" use fzf if already installed
if isdirectory("/usr/local/opt/fzf")
  Plug '/usr/local/opt/fzf'
elseif isdirectory("/opt/homebrew/opt/fzf")
  Plug '/opt/homebrew/opt/fzf'
elseif isdirectory(expand("~/.fzf"))
  Plug '~/.fzf'
elseif isdirectory("/home/linuxbrew/.linuxbrew/opt/fzf/bin")
  Plug '/home/linuxbrew/.linuxbrew/opt/fzf'
endif

if has("python")
  Plug 'SirVer/ultisnips'
endif

" this plugin adds github magic; it requires a personal access token w/ repo 
" permissions. add a line to ~/.netrc as follows:
" machine api.githup.com login <user> password <token>
Plug 'tpope/vim-rhubarb'

call plug#end()

filetype plugin indent on

" Preferences
set nu
set noerrorbells visualbell t_vb=
set wmh=0
set ts=4
set sw=4
set et
set hls
set incsearch
set laststatus=2
set encoding=utf-8
set smarttab
set showcmd
let mapleader = " "
set nocompatible
set cursorline
set bs=2
set showcmd
set autoindent
set ruler
set wildmenu
set display+=lastline
set autoread
set formatoptions+=j
set listchars+=space:·,eol:¬
set nrformats-=octal
set scrolloff=1
set inccommand=nosplit

" Don't clutter local dirs, but keep backup/swap/undo files
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undodir=~/.vim/undo
set undofile

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

" turn on syntax highlighting
syn on

" setup for solarized colorscheme
let g:solarized_termcolors=256
let g:solarized_italic=0

set guioptions-=m  " disable GUI menubar
set guioptions-=r  " disable GUI scrollbar
set guioptions-=T  " disable GUI toolbar

if has("win32") || has("win16")
  set gfn=Consolas:h9:cANSI 
  let g:airline_powerline_fonts = 0
endif

" RStudio
au FileType cpp setlocal makeprg=make\ \-j4\ -C\ ~/git/rstudio/src/cpp/build
nmap <Leader>rc :Dispatch cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -B~/git/rstudio/src/cpp/build -H~/git/rstudio/src/cpp<CR>
nmap <Leader>m :Make<CR>

" RStudio Connect
au FileType go setlocal makeprg=make

" enable spell checking in files primarily composed of prose
au FileType markdown setlocal spell spelllang=en_us
au FileType rmd setlocal spell spelllang=en_us
au FileType gitcommit setlocal spell spelllang=en_us
au FileType vimwiki setlocal spell spelllang=en_us

" also in common code files so comments can be spellchecked
au FileType cpp setlocal spell spelllang=en_us
au FileType javascript setlocal spell spelllang=en_us
au FileType typescript setlocal spell spelllang=en_us
au FileType ruby setlocal spell spelllang=en_us
au FileType java setlocal spell spelllang=en_us
au FileType r setlocal spell spelllang=en_us

" Shortcuts
map <Leader>f :Ag <cword><CR>
map <Leader>= :EasyAlign =<CR>
nmap <Leader>d :sp ~/git/vimwiki/todo.txt<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>G :Ggrep <cword><CR>
nmap <Leader>n :noh<CR>
nmap <Leader>s :update<CR>
nmap <Leader>u :UndotreeToggle<CR>
map <Leader>qc <Plug>ReplaceWithCurly
map <Leader>qs <Plug>ReplaceWithStraight
nmap <Leader>gt :GitGutterBufferToggle<CR>
nmap <Leader>gw :Gwrite<CR>
nmap <Leader>gc :Git commit<CR>
nmap <Leader>gp :Git push<CR>
nmap <Leader>gs :Git<CR>

" use fzf to supply most fuzzy matching, if installed
if isdirectory("/opt/homebrew/opt/fzf") || isdirectory("/usr/local/opt/fzf") || isdirectory(expand("~/.fzf")) || isdirectory("/home/linuxbrew/.linuxbrew/opt/fzf")
  let g:ctrlp_map = ''
  nmap <c-p> :Files<CR> 
  nmap <Leader>a :Marks<CR>
  nmap <Leader>o :GFiles<CR>
  nmap <Leader>i :GFiles?<CR>
  nmap <Leader>b :CtrlPBuffer<CR>
  nmap <Leader>wp :Files ~/git/vimwiki/<CR>
endif

" search the wiki
function VimwikiSearch(str) 
  execute ":Ack " a:str " ~/git/vimwiki"
endfunction
nmap <Leader>wf :call VimwikiSearch("")<Left><Left>

" integrate with par if needed
if executable('par')
  map <Leader>p :!par w79<CR>
endif

" Go
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" Airline settings
let g:airline#extensions#whitespace#enabled = 0

" Plugin-supplied shortcuts
"
" Git Gutter
" ]c         next hunk
" [c         previous hunk
" <Leader>hs stage hunk
" <Leader>hr revert hunk
"
" Disable gitgutter by default for performance reasons; toggle with 
" :GitGutterToggle
let g:gitgutter_enabled = 0

" use the silver searcher for ctrl-p browsing (if installed)
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

autocmd FileType markdown let b:coc_suggest_disable = 1
autocmd FileType vimwiki let b:coc_suggest_disable = 1
autocmd FileType gitcommit let b:coc_suggest_disable = 1
autocmd FileType todo let b:coc_suggest_disable = 1

 " Use completion-nvim in every buffer
 " autocmd BufEnter * lua require'completion'.on_attach()

" UltiSnips configuration settings
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"

" use dotfiles to store snippet dictionaries
set rtp+=~/dotfiles
let g:UltiSnipsSnippetDirectories = ['~/dotfiles/UltiSnips', 'UltiSnips']

" EditorConfig settings
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" if we have ag (The Silver Searcher), use it
if executable('ag')
  let g:ackprg = 'ag -U --vimgrep --smart-case --ignore tags'
  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack
endif

" without this setting, ctrl-p matches inside directory names (toggle with
" <C-D>)
let g:ctrlp_by_filename = 1

if has("win32")
  let g:vimwiki_list = [ { 'path': '~\git\vimwiki', 'syntax': 'markdown', 'ext': '.md' } ]
else
  let g:vimwiki_list = [ { 'syntax': 'markdown', 'ext': '.md' } ]
endif

" add margin/column guides for common code file types
au FileType cpp setlocal colorcolumn=100
au FileType java setlocal colorcolumn=100
au FileType javascript setlocal colorcolumn=100
au FileType r setlocal colorcolumn=100
   
lua << EOF

-- Install R language server: > install.packages("languageserver")
require'lspconfig'.r_language_server.setup{}

-- Install CSS language server: $ npm install -g vscode-css-languageserver-bin
require'lspconfig'.cssls.setup{}

-- Start lualine plugin
require('lualine').setup{
    options = {
        icons_enabled = 0,
        section_separators = '',
        component_separators = ''
    }
}
EOF

" turn on auto color highlighting in CSS and HTML files
let g:colorizer_auto_filetype='css,html'


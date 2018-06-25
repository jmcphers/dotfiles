set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-vinegar'
Plug 'mileszs/ack.vim'
Plug 'junegunn/vim-easy-align'
Plug 'freitass/todo.txt-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'vimwiki/vimwiki'
Plug 'flazz/vim-colorschemes'
Plug 'mbbill/undotree'
Plug 'Olical/vim-enmasse'
Plug 'ctrlpvim/ctrlp.vim'

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

" Don't clutter local dirs, but keep backup/swap/undo files
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undodir=~/.vim/undo
set undofile

set t_Co=256

" don't treat numbers with leading 0 as octal
set nrformats-=octal

" make sure one line is visible below/above cursor
if !&scrolloff
  set scrolloff=1
endif

" delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" use fancy listchars where supported
if has("patch711")
  set listchars+=space:·,eol:¬
endif

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

" Speedy shortcuts
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

" enable spell checking in files primarily composed of prose
au FileType markdown setlocal spell spelllang=en_us
au FileType rmd setlocal spell spelllang=en_us
au FileType gitcommit setlocal spell spelllang=en_us
au FileType vimwiki setlocal spell spelllang=en_us

" Shortcuts
map <Leader>f :Ag <cword><CR>
map <Leader>= :EasyAlign =<CR>
nmap <Leader>t :sp ~/Dropbox/todo.txt<CR>
nmap <Leader>G :Ggrep <cword><CR>
nmap <Leader>n :noh<CR>
nmap <Leader>s :update<CR>
nmap <Leader>b :CtrlPBuffer<CR>
nmap <Leader>wp :CtrlP ~/git/vimwiki/<CR>

" search the wiki
function VimwikiSearch(str) 
  execute ":Ack " a:str " ~/git/vimwiki"
endfunction
nmap <Leader>wf :call VimwikiSearch("")<Left><Left>

" integrate with par if needed
if executable('par')
  map <Leader>p :!par w79<CR>
endif

" Airline settings
let g:airline#extensions#whitespace#enabled = 0

" use the silver searcher for ctrl-p browsing (if installed)
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

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

" sync vimwiki with dropbox directly on Windows (since we can't symlink
" there)
if has("win32")
  let g:vimwiki_list = [ { 'path': '~\git\vimwiki' } ]
endif

" add margin/column guides for common code file types
au FileType cpp setlocal colorcolumn=100
au FileType java setlocal colorcolumn=100
au FileType javascript setlocal colorcolumn=100
au FileType r setlocal colorcolumn=100


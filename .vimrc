set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
  
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" Vundles
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-dispatch'
Bundle 'wookiehangover/jshint.vim'
Bundle 'marijnh/tern_for_vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'junegunn/vim-easy-align'
Bundle 'fatih/vim-go'

" Preferences
set nu
set noerrorbells visualbell t_vb=
set wmh=0
set ts=3
set sw=3
set et
set backupdir=~/.vimbackup
set directory=~/.vimswap
filetype plugin indent on
set hls
set incsearch
set laststatus=2
set encoding=utf-8
set gfn=Sauce\ Code\ Powerline\ Light:h11
set colorcolumn=80
set t_Co=256
set showcmd
let mapleader = ","
set nocompatible
set cursorline
syn on 
colors jellybeans

" Speedy shortcuts
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
imap <C-I> <ESC>:cn<CR>
imap <C-U> <ESC>:cp<CR>
nmap <C-I> :cn<CR>
nmap <C-U> :cp<CR>

" RStudio
au FileType cpp set makeprg=make\ \-j4\ -C\ ~/rstudio-build
nmap <Leader>rt :Dispatch ctags --recurse --verbose -o ~/rstudio/src/cpp/tags ~/rstudio/src/cpp
nmap <Leader>a :Dispatch ant draft -f ~/rstudio/src/gwt/build.xml<CR>
nmap <Leader>m :Make<CR>

" Plugin prefs
let JSHintUpdateWriteOnly=1
let g:Powerline_symbols = 'fancy'

" Shortcuts
map <Leader>d :YcmCompleter GoToImprecise<CR>
map <Leader>f :Ag --ignore tags <cword><CR>
map <Leader>p :!par w79<CR>
map <Leader>= :EasyAlign =<CR>
nmap <Leader>t :sp ~/Dropbox/todo.txt<CR>


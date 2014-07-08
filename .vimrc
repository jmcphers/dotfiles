set rtp+=~/.vim/bundle/vundle
call vundle#rc()
  
" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

" Vundles
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-dispatch'
Plugin 'wookiehangover/jshint.vim'
Plugin 'marijnh/tern_for_vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'junegunn/vim-easy-align'
Plugin 'fatih/vim-go'
Plugin 'airblade/vim-gitgutter'

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

" Plugin-supplied shortcuts
"
" Git Gutter
" ]c         next hunk
" [c         previous hunk
" <Leader>hs stage hunk
" <Leader>hr revert hunk
"

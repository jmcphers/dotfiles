set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  
" let Vundle manage Vundle
" required! 
Plugin 'gmarik/Vundle.vim'

" Vundles
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-dispatch'
Plugin 'marijnh/tern_for_vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'junegunn/vim-easy-align'
Plugin 'fatih/vim-go'
Plugin 'leafgarland/typescript-vim'
Plugin 'freitass/todo.txt-vim'
Plugin 'SirVer/ultisnips'

if has("nvim") 
  " in the neovim gui, use a native neovim make plugin
  Plugin 'neomake/neomake'
endif

" gitgutter doesn't play very nicely with neovim.app
if !has("nvim")
  Plugin 'airblade/vim-gitgutter'
endif

" requires server: npm install -g clausreinke/typescript-tools
Plugin 'clausreinke/typescript-tools.vim'

call vundle#end()
filetype plugin indent on

" Preferences
set nu
set noerrorbells visualbell t_vb=
set wmh=0
set ts=4
set sw=4
set et
set backupdir=~/.vimbackup
set directory=~/.vimswap
set hls
set incsearch
set laststatus=2
set encoding=utf-8
set colorcolumn=80
set smarttab
set showcmd
let mapleader = ","
set nocompatible
set cursorline
set bs=2
set showcmd
set autoindent
set ruler
set wildmenu
set display+=lastline
set autoread
set listchars+=space:·,eol:¬

" set up colors appropriately
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
else
  set t_Co=256
endif


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

syn on
let g:solarized_termcolors=256
let g:solarized_italic=0
set background=light
colors solarized

set guioptions-=m  " disable GUI menubar
set guioptions-=r  " disable GUI scrollbar
set guioptions-=T  " disable GUI toolbar

if has("win32") || has("win16")
  set gfn=Consolas:h9:cANSI 
  let g:airline_powerline_fonts = 0
  set 
else
  set gfn=Sauce\ Code\ Powerline\ Light:h11
  let g:airline_powerline_fonts = 1
endif

" Speedy shortcuts

map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
imap <C-I> <ESC>:cn<CR>
imap <C-U> <ESC>:cp<CR>
nmap <C-I> :cn<CR>
nmap <C-U> :cp<CR>

" RStudio
au FileType cpp setlocal makeprg=make\ \-j4\ -C\ ~/rstudio-build
nmap <Leader>rt :Dispatch ctags --recurse --verbose -o ~/rstudio/src/cpp/tags ~/rstudio/src/cpp<CR>
nmap <Leader>rc :Dispatch cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -B~/rstudio-build -H~/rstudio/src/cpp<CR>
nmap <Leader>a :Dispatch ant draft -f ~/rstudio/src/gwt/build.xml<CR>
nmap <Leader>m :Make<CR>

" RStudio Connect
au FileType go setlocal makeprg=make

" Indent prefs by filetype
au FileType javascript setlocal shiftwidth=2 tabstop=2 
au FileType cpp setlocal shiftwidth=3 tabstop=3
au FileType r setlocal shiftwidth=2 tabstop=2 et 
au FileType ruby setlocal shiftwidth=2 tabstop=2 et 

" enable spell checking in files primarily composed of prose
au FileType markdown setlocal spell spelllang=en_us
au FileType gitcommit setlocal spell spelllang=en_us

" Shortcuts
map <Leader>d :YcmCompleter GoToImprecise<CR>
map <Leader>f :Ag -U --ignore tags --ignore *.a --ignore *.min.* --ignore *.cache.js <cword><CR>
map <Leader>s :Ag -U --ignore tags --ignore *.a --ignore *.min.* --ignore *.cache.js 
map <Leader>p :!par w79<CR>
map <Leader>= :EasyAlign =<CR>
nmap <Leader>t :sp ~/Dropbox/todo.txt<CR>
nmap <Leader>g :Ggrep <cword><CR>
nmap <Leader>b :CtrlPBuffer<CR>
nmap <Leader>n :noh<CR>

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

" Typescript
au BufRead,BufNewFile *.ts      setlocal filetype=typescript
if !exists("g:ycm_semantic_triggers")
   let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" UltiSnips configuration settings
let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-u>"
let g:UltiSnipsJumpBackwardTrigger="<c-i>"
let g:UltiSnipsEditSplit="vertical"


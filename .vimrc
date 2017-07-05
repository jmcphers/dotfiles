set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'marijnh/tern_for_vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'junegunn/vim-easy-align'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'leafgarland/typescript-vim'
Plug 'freitass/todo.txt-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
Plug 'lyuts/vim-rtags'
Plug 'vimwiki/vimwiki'

if has("python")
  Plug 'SirVer/ultisnips'
endif

if has("nvim") 
  Plug 'radenling/vim-dispatch-neovim'
endif

" TypeScript tools/server
function! InstallTSServer(info)
  if a:info.status == 'installed' || a:info.force
    !npm install -g typescript
    !npm install -g clausreinke/typescript-tools
  endif
endfunction
Plug 'clausreinke/typescript-tools.vim', { 'do': function('InstallTSServer') }

" YouCompleteMe requires compilation after install
function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --tern-completer
  endif
endfunction
if has("python")
  Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
endif

if has("nvim") 
  " in the neovim gui, use a native neovim make plugin
  Plug 'neomake/neomake'
endif

" gitgutter doesn't play very nicely with neovim.app
if !has("nvim")
  Plug 'airblade/vim-gitgutter'
endif

call plug#end()

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

" set up colors appropriately
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set termguicolors
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

" use fancy listchars where supported
if has("patch711")
  set listchars+=space:·,eol:¬
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
"   set gfn=Sauce\ Code\ Powerline\ Light:h11
" let g:airline_powerline_fonts = 1
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
nmap <Leader>rc :Dispatch cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -B~/rstudio-build -H~/rstudio/src/cpp<CR>
nmap <Leader>a :Dispatch ant draft -f ~/rstudio/src/gwt/build.xml<CR>
nmap <Leader>m :Make<CR>

" RStudio Connect
au FileType go setlocal makeprg=make

" enable spell checking in files primarily composed of prose
au FileType markdown setlocal spell spelllang=en_us
au FileType rmd setlocal spell spelllang=en_us
au FileType gitcommit setlocal spell spelllang=en_us
au FileType vimwiki setlocal spell spelllang=en_us

" Shortcuts
map <Leader>d :YcmCompleter GoToImprecise<CR>
map <Leader>f :Ag <cword><CR>
map <Leader>= :EasyAlign =<CR>
nmap <Leader>t :sp ~/Dropbox/todo.txt<CR>
nmap <Leader>g :Ggrep <cword><CR>
nmap <Leader>b :CtrlPBuffer<CR>
nmap <Leader>n :noh<CR>

" browse for a wiki page by name
nmap <Leader>wp :CtrlP ~/Dropbox/vimwiki/<CR>

" search the wiki
function VimwikiSearch(str) 
  execute ":Ack " a:str " ~/Dropbox/vimwiki"
endfunction
nmap <Leader>wf :call VimwikiSearch("")<Left><Left>


" log current line as an entry to idonethis
function LogDone()
  echo system('rvm 2.3.3 do idt entry new ' . shellescape(getline(".")))
endfunction
nmap <Leader>idt :call LogDone()<CR>

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

" use the silver searcher for ctrl-p browsing (if installed)
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" disable youcompleteme for file types for which it's annoying
let g:ycm_filetype_blacklist = {
      \ 'gitcommit': 1,
      \ 'infolog' : 1,
      \ 'mail' : 1,
      \ 'markdown' : 1,
      \ 'notes' : 1,
      \ 'pandoc' : 1,
      \ 'qf' : 1,
      \ 'rmd': 1,
      \ 'tagbar' : 1,
      \ 'text' : 1,
      \ 'unite' : 1,
      \ 'vimwiki' : 1,
      \ 'todo' : 1,
\}
 
" Typescript
au BufRead,BufNewFile *.ts      setlocal filetype=typescript
if !exists("g:ycm_semantic_triggers")
   let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" UltiSnips configuration settings
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-u>"
let g:UltiSnipsJumpBackwardTrigger="<c-i>"
let g:UltiSnipsEditSplit="vertical"

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

" enable live, in-place feedback when doing substitutions (supported by
" neovim)
if exists('&inccommand') 
  set inccommand=nosplit
endif

" sync vimwiki with dropbox directly on Windows (since we can't symlink
" there)
if has("win32")
  let g:vimwiki_list = [ { 'path': '~\Dropbox\vimwiki' } ]
endif

" add margin/column guides for common code file types
au FileType cpp setlocal colorcolumn=100
au FileType java setlocal colorcolumn=100
au FileType javascript setlocal colorcolumn=100


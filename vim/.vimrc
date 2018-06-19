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
Plug 'marijnh/tern_for_vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/vim-easy-align'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'leafgarland/typescript-vim'
Plug 'freitass/todo.txt-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
Plug 'vimwiki/vimwiki'
Plug 'vim-scripts/gtags.vim'
Plug 'flazz/vim-colorschemes'
Plug 'jalvesaq/vimcmdline'
Plug 'mbbill/undotree'
Plug 'machakann/vim-highlightedyank'
Plug 'Olical/vim-enmasse'
Plug 'ctrlpvim/ctrlp.vim'

if has("nvim") 
  " neovim-specific plugins
  Plug 'radenling/vim-dispatch-neovim'
  Plug 'w0rp/ale'
endif

if has("python")
  Plug 'SirVer/ultisnips'
endif

if !has("gui_running")
  " use fzf in the terminal
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
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

" gitgutter doesn't play very nicely with neovim.app
if !has("nvim")
  Plug 'airblade/vim-gitgutter'
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

" use gnu global to provide tags
set cscopetag
set cscopeprg=gtags-cscope
" TODO: it's still currently necessary to do "cs add GTAGS" in order to get
" tag-jumping to work via ^] and friends. add some code to figure out the
" project root and add the GTAGS file as appropriate.

" Don't clutter local dirs, but keep backup/swap/undo files
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undodir=~/.vim/undo
set undofile

" set up colors appropriately
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set termguicolors
  colors onedark
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

" setup for solarized colorscheme
let g:solarized_termcolors=256
let g:solarized_italic=0

set guioptions-=m  " disable GUI menubar
set guioptions-=r  " disable GUI scrollbar
set guioptions-=T  " disable GUI toolbar

if has("win32") || has("win16")
  set gfn=Consolas:h9:cANSI 
  let g:airline_powerline_fonts = 0
else
"   set gfn=Sauce\ Code\ Powerline\ Light:h11
" let g:airline_powerline_fonts = 1
endif

" Speedy shortcuts

map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

" RStudio
au FileType cpp setlocal makeprg=make\ \-j4\ -C\ ~/rstudio-build
nmap <Leader>rc :Dispatch cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -B~/rstudio-build -H~/rstudio/src/cpp<CR>
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
nmap <Leader>G :Ggrep <cword><CR>
nmap <Leader>g :GtagsCursor<CR>
nmap <Leader>n :noh<CR>
nmap <Leader>s :update<CR>

if has("gui_running")
  " use ctrl-p as a fuzzy finder in gui mode
  let g:ctrlp_map = '<c-p>'
  nmap <Leader>b :CtrlPBuffer<CR>
  nmap <Leader>wp :CtrlP ~/git/vimwiki/<CR>
else
  " otherwise, use fzf
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

" log current line as an entry to idonethis
function LogDone()
  echo system('achiever-cli --description ' . shellescape(getline(".")))
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
      \ 'infolog':   1,
      \ 'mail':      1,
      \ 'markdown':  1,
      \ 'notes':     1,
      \ 'pandoc':    1,
      \ 'qf':        1,
      \ 'rmd':       1,
      \ 'tagbar':    1,
      \ 'text':      1,
      \ 'todo':      1,
      \ 'unite':     1,
      \ 'vim':       1,
      \ 'vimwiki':   1,
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
  let g:vimwiki_list = [ { 'path': '~\git\vimwiki' } ]
endif

" add margin/column guides for common code file types
au FileType cpp setlocal colorcolumn=100
au FileType java setlocal colorcolumn=100
au FileType javascript setlocal colorcolumn=100
au FileType r setlocal colorcolumn=100


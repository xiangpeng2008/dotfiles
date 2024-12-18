
inoremap <esc> <esc>:w<cr>l
inoremap <F2> <esc>:w<cr>
scriptencoding utf-8
set encoding=utf-8
set nocompatible "should be put in the very start

" pluggin ------------- {{{
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdcommenter'
"Plug 'vimwiki/vimwiki'
"Plug 'tmhedberg/SimpylFold'
"Plug 'Vimjas/vim-python-pep8-indent'
"Plug 'vim-scripts/delimitMate.vim'
"Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fladson/vim-kitty', {'branch': 'main'}
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
"Plug 'github/copilot.vim', {'branch': 'release'}
Plug 'jeetsukumaran/vim-indentwise'

if $TERM !=# "xterm-kitty"
    Plug 'epeli/slimux'
else
    Plug 'xiangpeng2008/vim-slime'
endif

Plug 'xiangpeng2008/vim_xiangpeng'

call plug#end()
" }}}

" Basic Settings ---------- {{{

let mapleader = "," "set leader to ,
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" from learn vimscript the hard way
" wrap long line
set wrap

set noswapfile
" set no number
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
set number

" Highlight searches
" Highlight dynamically as pattern is typed
set hlsearch incsearch
" ignorecase and smartcase can work together
set ignorecase
set smartcase

" Allow backspace in insert mode
set backspace=indent,eol,start

"split below and right, which is more natural
set splitbelow
set splitright
" show a visual line under the cursor's current line
set cursorline

" set undo, backup, swap directory to under .vim
set undodir=~/.vim/.undo
set undofile
set backupdir=~/.vim/.backup
set directory=~/.vim/.swp

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" always show status bar
set laststatus=2
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Enable mouse in all modes
set mouse=a

" Don’t reset cursor to start of line when moving around.
set nostartofline

" use dark background
set background=dark
"autocmd vimenter * colorscheme gruvbox
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the (partial) command as it’s being typed
set showcmd

" Start scrolling three lines before the horizontal window border
set scrolloff=3


"set statusline=Current:\ %-5l\ Total:\ %-5L\ %F
"set statusline=\ %-3p%%\ \ \ Total:\ %-5L\ %m\ %F
set statusline=%F\ %-3p%%\ \ \ Total:\ %-5L\ %m\ %y

"stops the search at the end of the file
set nowrapscan


" set tabs to have 4 spaces
set ts=4

" change the current working directory whenever open a file
set autochdir

" indent when moving to the next line while writing code
set autoindent
set smartindent

" expand tabs into spaces
set expandtab
" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show the matching part of the pair for [] {} and ()
set showmatch

" avoid error No write since last change (add ! to override)
set hidden

" use vim as  c++ IDE
" force vim to source .vimrc file if it present in workingg directory
set exrc
" restrict usage of some commands in non-default .vimrc files
set secure

" F10 to open buffer list
set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>

set tagrelative
set tags=tags;
set tags^=.git/tags
let g:slimux_select_from_current_window=1

" }}}

" set nerd comment for q language
let g:NERDCustomDelimiters = { 'q': { 'left': '//' } }

" leave insert mode quickly ------------------ {{{
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
" }}}

" augroup ------------- {{{
" only for linux, to double check
augroup rsync
    autocmd!
    "autocmd BufWrite * :execute '!echo rsync ' expand('%:p') 'nyzls147c:'.expand('%:p').';'
    "autocmd BufWrite * :execute silent! '!rsync ' expand('%:p') 'nyzls147c:'.expand('%:p') '$1 > /dev/null 2>&1'
    autocmd BufWrite * silent !rsync %:p nyzls147c:%:p $1>/dev/null 2>&1 &
augroup END
augroup nerdtree
    " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    " Close the tab if NERDTree is the only window remaining in it.
    autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END
" }}}
" highlight search
set hlsearch


colorscheme dracula
"let g:gruvbox_contrast_dark='medium'
"let g:gruvbox_contrast_dark='soft'
"let g:gruvbox_contrast_dark='hard'


" vimwiki
"filetype plugin indent on
filetype plugin on
syntax enable

" read a .vim file from the same directory as the file I'm editing, regardless of what the current directory is.
let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
  execute "source ".b:vim
endif


let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_root_markers = ['.ctrlp']
" open new tab before current one
let g:ctrlp_tabpage_position = 'bc'

" double check, airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#default#layout = [
  \ [ 'b', 'c'],
  \ [ 'x', 'y', 'z', 'warning']
\ ]



" config for kitty {{{
let g:slime_target = "kitty"
if $TERM !=# "xterm-kitty"
    source ~/.vim/plugged/vim_xiangpeng/xterm/slimux.vim
else
    source ~/.vim/plugged/vim_xiangpeng/xterm/vim-slime.vim
    let &t_ut=''
endif
"}}}



"Source the SP snippet loading functionality
" to double check if this is needed
"let sppluginpath="/opt/third/vim-plugins/1.0.1/"
"execute 'source ' . fnameescape(sppluginpath . "sp-init/init.vim")
" hite whitespace in difference
set diffopt+=iwhite
set diffexpr=DiffW()
function DiffW()
  let opt = ""
   if &diffopt =~ "icase"
     let opt = opt . "-i "
   endif
   if &diffopt =~ "iwhite"
     let opt = opt . "-w " " swapped vim's -b with -w
   endif
   silent execute "!diff -a --binary " . opt .
     \ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
endfunction


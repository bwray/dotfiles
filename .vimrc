" Created by Brian Wray, 3-Nov-2017
"
" To download: git clone https://github.com/bwray/dotfiles.git
" This is my first attempt at creating my own vim.rc from scratch. I want to
" understand every line in this document.
" Check out https://dougblack.io/words/a-good-vimrc.html
"
" Note that this file should open with lines folded up. Hit <space> to expand
" any of them.
"
" There are some things that need to be installed, namely the colorscheme
" badwolf, and the syntax checkers for C, Java, and Python.
"
" To install badwolfj
" git clone https://github.com/sjl/badwolf.git
" mkdir -p ~/.vim/colors
" mv ~/badwolf/colors/* ~/.vim/colors
" rm -r ~/badwolf
"
" To install Vundle (for managing plugins)
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
" To install syntastic from within vim:
" :PluginInstall Syntastic
"
" place colors from that download in .vim/colors
"
" This must be first, because it changes other options as a side effect
set nocompatible
" This is for Vundle
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
" Vundle packages {{{
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-syntastic/syntastic'

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" }}}
"

call vundle#end()            " required
filetype plugin indent on    " required

" General Config {{{
" set relativenumber            " Line numbers relative to cursor. Useful for jumping around
set number            " Line numbers relative to start of file
set backspace=indent,eol,start  " Allow backspace in insert mode
set history=1000                " Store lots of :cmdline history
set showcmd                         " Show incomplete cmds down at the bottom
set showmode                    " Show current mode on the bottom
set visualbell                  " No sounds
set cursorline                  " Highlight currentline. Helps see where you are.
filetype indent on              " Load filetype-specific indent files
set wildmenu                    " Visual autocomplete for command menu (e.g. for opening files with :e)
set lazyredraw          " Some advanced stuff dealing with macros.
set showmatch           " Highlight matching [{()}]. AWESOME!
set ruler               " Put the column number (line position) in the status bar on the bottom
set mouse=a
" Setup infinite undo:
set undofile
set undodir=~/.vim/undodir
" }}}

" {{{  Searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" Turn off search highlight with ,<space>
nnoremap ,<space> :nohlsearch<CR>
" }}}
"

" {{{  Folding
" Folding lets you temporarily hide parts of a file.
set foldenable          " Turn it on
set foldlevelstart=10   " Open most folds by default (0 = all folds closed, 99 = all open)
set foldnestmax=10      " Who on earth would ever have 10 nested folds?
" Cool, now <space> will open and close folds
nnoremap <space> za
set foldmethod=indent      " Good for python code
" }}}

" Colors {{{
syntax enable                   " Enable syntax processing
set background=dark
" colorscheme solarized         " For some reason, this is not working right. The whole screen looks highlighted
" colorscheme goodwolf          " I have it installed but it's off right now
colorscheme badwolf
" }}}

" Spaces & Tabs {{{
"set tabstop=4                  " number of visual spaces per tab
"set softtabstop=0 noexpandtab          " number of spaces in tab when editing
"set shiftwidth=2
" set expandtab                 " Good for editing in bash and python. Turns tabs into spaces
" }}}

" Movement {{{
" When a single line is too wide for the editor window and has to span two
" lines, then j and k won't skip over that overflow part of the line
nnoremap j gj
nnoremap k gk
" highlight last inserted text
nnoremap gV `[v`]
" }}}

" Leader Shortcuts  {{{

let mapleader=","       " leader is comma instead of forward slash
" easier write
nmap <leader>w :w!<cr>
" easier quit
nmap <leader>q :q<cr>
"paste from outside buffer
nnoremap <leader>p :set paste<CR>"+p:set nopaste<CR>
vnoremap <leader>p <Esc>:set paste<CR>gv"+p:set nopaste<CR>
"copy to outside buffer
vnoremap <leader>y "+y
"select all
nnoremap <leader>a ggVG

" exit insert mode with ii
:imap ii <Esc>

" }}}

" Syntastic settings {{{

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

" }}}

" .vimrc-specific settings {{{
set modelines=1
" }}}
" vim:foldmethod=marker:foldlevel=0

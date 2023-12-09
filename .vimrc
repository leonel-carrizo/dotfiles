
" Add line numbers
set number

set ruler                         " Show cursor position.
set relativenumber

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on
filetype indent plugin on

" Set shift width to 4 spaces.
" set shiftwidth=8

" Set tab width to 4 columns.
" set tabstop=8
"set cindent

" Use space characters instead of tabs.
"set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Set Mouse support
set mouse=a

" Do not wrap lines. Allow long lines to extend as far as the line goes.
" set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

set wildmode=list:longest         " Complete files like a shell.

set laststatus=2                  " Show the status line all the time

set title                         " Set the terminal's title

let mapleader = ","

" Sets hidden editing
"set list lcs=tab:<>
set listchars=eol:↓,space:·,trail:●,tab:→⇥⇥,extends:>,precedes:<
:highlight SpecialKey ctermfg=DarkGray
:highlight NonText ctermfg=DarkGray
" mapping for set list
noremap <F5> :set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-c>:set list!<CR>

" saving
inoremap <C-S> <C-O>:update<CR>
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>

" close
nnoremap <C-x> :wq<CR>

"close the parentesis
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap " ""<left>
inoremap ' ''<left>

"Enter in the midle of [] {}
  inoremap <expr> <CR> CheckBraces()
  function! CheckBraces()
    let col = col('.') - 1
    let prev_char = getline('.')[col - 1]
    let next_char = getline('.')[col]

    if (prev_char == '{' && next_char == '}') || (prev_char == '(' && next_char == ')')
        return "\<CR>\<Esc>O"
    else
        return "\<CR>"
    endif
 endfunction

call plug#begin('~/.vim/plugged')
""Plug 'morhetz/gruvbox'
call plug#end()

""let g:gruvbox_contrast_dark='hard'
""colorscheme gruvbox 
""set background=dark

" for 42 HEADER the default <F1> doesn't work on kitty
noremap <C-h> :Stdheader<CR>

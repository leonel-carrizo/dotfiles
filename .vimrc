"------------------------------------------------------------------------------
"           _  _____          _                 _                             "
"          | ||___ /   ___   | | __ _ __  _ __ (_) ____ ___                   "
"          | |  |_ \  / _ \  | |/ /| '__|| '__|| ||_  // _ \                  "
"          | | ___) || (_) | |   < | |   | |   | | / /| (_) |                 "
"          |_||____/  \___/  |_|\_\|_|   |_|   |_|/___|\___/                  "
"                                                                             "
"------------------------------------------------------------------------------

""let mapleader="\"
set encoding=utf-8
let &t_ut=''  " To render properly background of the color scheme

" Add line numbers
"set number
nnoremap <leader>nn :set number!<CR>
inoremap <leader>nn :set <C-o>:set number!<CR>
 
" Toggle relative line numbers and regular line numbers.
nnoremap <leader>rn :set relativenumber!<CR>
inoremap <leader>rn <C-o>:set relativenumber!<CR>

" Show cursor position.
" set cursorline
" status line
set laststatus=2

" status line format
set statusline=%t\ [%{mode()}]\ %r%m%h%w%=\ File:\ %{&filetype}%=\ \
			\ %l-%c\\|\%L-lines\\|\(%p%%)

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Turn syntax highlighting on.
syntax on

" Enable type file detection. to try to detect the type of file in use.
filetype plugin indent on

" Set shift width to 4 spaces.
" set shiftwidth=8

" Set tab width to 4 columns.
 set tabstop=8
"
" identation for C
set cindent

" Use space characters instead of tabs.
"set expandtab

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Set Mouse support
set mouse=r

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching incrementally highlight matching characters as you type.
set incsearch

" clear highlight after a search
nnoremap <silent> <Leader>. :nohl<CR> 

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

" ----------------------------- comments ---------------------------------------
" new line with comment if the last wast commented
set fo+=ro

" For Commentary Pluging
noremap <leader>/ :Commentary<cr>
inoremap <leader>/ :Commentary<cr>
autocmd FileType c setlocal commentstring=//\ %s
" ------------------------------------------------------------------------------

"----------------- Show when a line is longer than 81 chars --------------------

let g:highlight_long_lines_enabled = 0


function! ToggleHighlightLongLines()
    if g:highlight_long_lines_enabled
        augroup! highlight_long_lines
        hi clear LongLine
        let g:highlight_long_lines_enabled = 0
        echo "Check lines deactivate"
    else
        augroup highlight_long_lines
            autocmd!
            autocmd BufEnter,BufWritePost *.{c,h,cpp,hpp,sh,vim,py,css,js,jsx,vimrc,
                \zshrc,bashrc,php,java,html,rb,go,swift,ts,ps1,json,yaml,yml,lua}
                \ match LongLine /\%>80v.\+/
            hi LongLine ctermbg=red guibg=red ctermfg=yellow
        augroup END
        let g:highlight_long_lines_enabled = 1
        echo "Check lines activate"
    endif
endfunction

"-------------------------------------------------------------------------------

"------------------------------ Sets hidden editing ----------------------------
" set list
"set listchars=eol:↓,space:·,trail:●,tab:→⇥⇥→➤,extends:>,precedes:<
set listchars=eol:↓,space:·,trail:●,tab:――\ ,extends:>,precedes:<
highlight SpecialKey ctermfg=DarkGray
highlight NonText ctermfg=DarkGray
noremap <F5> :set list!<CR>:call ToggleHighlightLongLines()<CR>
inoremap <F5> <C-o>:set list!<CR>:call ToggleHighlightLongLines()<CR>
cnoremap <F5> <C-c>:set list!<CR>:call ToggleHighlightLongLines()<CR>
" mapping for set list and check lines lenght
" noremap <F5> :call ToggleHighlightLongLines()<CR>:set list!<CR>
" inoremap <F5> :call ToggleHighlightLongLines()<CR>:set list!<CR>
" cnoremap <F5> :call ToggleHighlightLongLines()<CR>:set list!<CR>

"------------------------------------------------------------------------------

" saving
inoremap <C-S> <C-O>:update<CR>
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>

" close
nnoremap <C-x> :x<CR>
inoremap <C-x> <C-O>:x<CR>
vnoremap <C-x> <C-C>:x<CR>

" ----------------------- NETRW, TABS, TERMINAL  -----------------------------

"Edit Vim config file in a new tab.
map <leader>ev :tabnew $MYVIMRC<CR>
" update config file
map <leader>sv :source $MYVIMRC<CR>

" Netrw with
let g:netrw_winsize= 25

" netrw stile with details 
let g:netrw_liststyle=3

" function to open and close Lexplore
function! ToggleExplorer()
    " Verify if explorer is opened
    if exists("g:explorer_is_open") && g:explorer_is_open == 1
        " if opened close it
        Lex
        let g:explorer_is_open = 0
    else
        " if close it, open it
        Lex 25
        let g:explorer_is_open = 1
    endif
endfunction

" open new tab on netrw
nnoremap <leader>ll :call ToggleExplorer()<CR>

nnoremap <leader>nt <Esc>:tabe<CR>

" open terminal horizontal
nnoremap <leader>tr <Esc>:terminal<CR>

" let netrw_browse_split = 2
" ------------------------------------------------------------------------------

" sugestion and compplete
set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c
set wildmenu
set wildmode=full


"close the parentesis
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap " ""<left>
inoremap ' ''<left>

" Keymap for using hjkl in INSERT mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-;> <End>

"------------------------Enter in the midle of [] {}----------------------------
inoremap <expr> <CR> CheckBraces()

function! CheckBraces()
    let col = col('.') - 1
    let prev_char = getline('.')[col - 1]
    let next_char = getline('.')[col]
    if ( (prev_char == '{' && next_char == '}')
	\ || (prev_char == '(' && next_char == ')') )
        return "\<CR>\<Esc>O"
    else
        return "\<CR>"
    endif
endfunction
"-------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
""Plug 'morhetz/gruvbox'
call plug#end()

""let g:gruvbox_contrast_dark='hard'
""colorscheme gruvbox 
""set background=dark

"-------------- for 42 HEADER | default mapping <F1> --------------------------
let g:user42 = 'lcarrizo'
let g:mail42 = 'lcarrizo@student.42london.com'
" noremap <C-h> :Stdheader<CR>
" inoremap <C-h> <C-o>:Stdheader<CR>
" vnoremap <C-h> <C-c>:Stdheader<CR>

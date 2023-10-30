"let g:user42 = 'lcarrizo'
"let g:mail42 = 'lcarrizo@student.42london.com'

  set nocompatible               " Be iMproved
  "set runtimepath+=~/.vim/bundle/neobundle.vim/
  let g:user42 = 'lcarrizo'
  let g:mail42 = 'lcarrizo@student.42london.com'

  syntax enable                     " Turn on syntax highlighting.
  "filetype indent on         " Turn on file type detection.
  set showcmd                       " Display incomplete commands.
  set showmode                      " Display the mode you're in.
   
 " set backspace=indent,eol,start    " Intuitive backspacing.
   
  set hidden                        " Handle multiple buffers better.
   
  set wildmenu                      " Enhanced command line completion.
  set wildmode=list:longest         " Complete files like a shell.
   
  set ignorecase                    " Case-insensitive searching.
  set smartcase                     " But case-sensitive if expression contains a capital letter.
 " set autoindent 

  set number                        " Show line numbers.
  set ruler                         " Show cursor position.
  set relativenumber  
  set mouse=a
 
  set incsearch                     " Highlight matches as you type.
  set hlsearch                      " Highlight matches.
  set tabstop=8
  "set expandtab 
  set shiftwidth=8
  set cindent
  "set smartindent
  syntax on
  filetype indent plugin on 

  set wrap                          " Turn on line wrapping.
  set scrolloff=0                   " Show 3 lines of context around the cursor.
   
  set title                         " Set the terminal's title
   
  set visualbell                    " No beeping.
   
  set laststatus=2                  " Show the status line all the time

  set background=dark

  let mapleader = ","
   
  " Tab mappings.
  map <leader>tt :tabnew<cr>
  map <leader>te :tabedit
  map <leader>tc :tabclose<cr>
  map <leader>to :tabonly<cr>
  map <leader>tn :tabnext<cr>
  map <leader>tp :tabprevious<cr>
  map <leader>tf :tabfirst<cr>
  map <leader>tl :tablast<cr>
  map <leader>tm :tabmove

  inoremap <C-S> <C-O>:update<CR>
  noremap <C-S> :update<CR>
  vnoremap <C-S> <C-C>:update<CR>
  
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
		"return ""\<CR>\<Esc>0\<Tab>"
		return "\<CR>\<Tab>\<CR>"
	else
		return "\<CR>"
	endif
 endfunction





 let g:airline_powerline_fonts=1


call plug#begin('~/.vim/plugged')
Plug 'preservim/NERDTree'
Plug 'morhetz/gruvbox'

call plug#end()

let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

"gotta be first
set nocompatible

let mapleader = ','
let g:Perl_Ctrl_j = 'off'

"pathogen for managing plugins
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()


set hidden
set ruler
set showmatch


"tabs
set tabstop=8
set expandtab
set softtabstop=2
set shiftwidth=2
set smartindent
set autoindent

autocmd filetype perl set expandtab


"search
set hlsearch
set incsearch


"large buffers
set history=1000
set undolevels=1000
set wildignore=*.swp
set visualbell
set noerrorbells

set nobackup
set noswapfile

set laststatus=2

"backspace over everything in insert mode
set backspace=indent,eol,start



nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


"type specific stuff
filetype plugin indent on

"colors
set t_Co=256
syntax on

" make perl syntax highlighting include pod
let perl_include_pod = 1

" syntax color complex things like @{${"foo"}}
let perl_extended_vars = 1



"paste toggle
set pastetoggle=<F2>


"no shift for every vim command
nnoremap ; :


"reformat paragraph
vmap Q gq
nmap Q gqap


"visual navigation
nnoremap j gj
nnoremap k gk


" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" turn off highlighting the easy way
nmap <silent> <leader>/ :nohlsearch<CR>

"utf8
"if has("multi_byte")
"  if &termencoding == ""
"    let &termencoding = &encoding
"  endif
"  set encoding=utf-8
"  setglobal fileencoding=utf-8 bomb
"  set fileencodings=ucs-bom,utf-8,latin1
"endif


" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
:endfunction


"remove trailing spaces
set list listchars=trail:.,extends:>,tab:>-
autocmd FileWritePre *.pl,*.pm,*.t,*.tt :call TrimWhiteSpace()
autocmd FileAppendPre *.pl,*.pm,*.t,*.tt :call TrimWhiteSpace()
autocmd FilterWritePre *.pl,*.pm,*.t,*.tt :call TrimWhiteSpace()
autocmd BufWritePre *.pl,*.pm,*.t,*.tt :call TrimWhiteSpace()

map <F3> :call TrimWhiteSpace()<CR>
map! <F3> :call TrimWhiteSpace()<CR>

" toggle line numbers
nmap <F4> :set invnumber<CR>

silent! source ~/.vimrc_local

set wildmenu

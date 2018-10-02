set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/molokai'
Plugin 'tpope/vim-fugitive'
Plugin 'altercation/vim-colors-solarized'
Plugin 'fatih/vim-go'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'chase/vim-ansible-yaml'

call vundle#end()            " required
filetype plugin indent on    " required

" which key should be the <leader>
" " (\ is the default, but ',' is more common, and easier to reach)
let mapleader=","

" we also want to get rid of accidental trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" we want to tell the syntastic module when to run
" " we want to see code highlighting and checks when  we open a file
" " but we don't care so much that it reruns when we close the file
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" use goimports for formatting
let g:go_fmt_command = "goimports"

" turn highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['golint']

" " Open go doc in vertical window, horizontal, or tab
au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
au Filetype go nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>

"Settings
set noerrorbells " No beeps
set number " Show line numbers
set backspace=indent,eol,start " Makes backspace key more powerful.
set showcmd " Show me what I'm typing
set showmode " Show current mode.
set noswapfile " Don't use swapfile
set nobackup " Don't create annoying backup files
set splitright " Split vertical windows right to the current windows
set splitbelow " Split horizontal windows below to the current windows
set encoding=utf-8 " Set default encoding to UTF-8
set autowrite " Automatically save before :next, :make etc.
set autoread " Automatically reread changed files without asking me anything
set laststatus=2
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats"
set incsearch " Shows the match while typing"
set hlsearch " Highlight found searches"
set ignorecase " Search case insensitive...
set smartcase " ... but not when search pattern contains upper case characters
set ttyfast
"Time out on key codes but not mappings.
"Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10
"Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone
colorscheme koehler
syntax enable
set background=dark
let g:solarized_termcolors = 256

colorscheme molokai

set wildmenu
set wildmode=list:longest
set wildmode=list:full
set wildignore+=.hg,.git,.svn " Version control
set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl " compiled spelling word lists
set wildignore+=*.sw? " Vim swap files
set wildignore+=*.DS_Store " OSX bullshit
set wildignore+=*.luac " Lua byte code
set wildignore+=migrations " Django migrations
set wildignore+=go/pkg " Go static files
set wildignore+=go/bin " Go bin files
set wildignore+=go/bin-vagrant " Go bin-vagrant files
set wildignore+=*.pyc " Python byte code
set wildignore+=*.orig " Merge resolution files
"Prettify json
com! JSONFormat %!python -m json.tool
" ==================== NerdTree ====================
" " Open nerdtree in current dir, write our own custom function because
" " NerdTreeToggle just sucks and doesn't work for buffers
function! g:NerdTreeFindToggle()
if nerdtree#isTreeOpen()
exec 'NERDTreeClose'
else
exec 'NERDTreeFind'
endif
endfunction
" For toggling
noremap <Leader>n :<C-u>call g:NerdTreeFindToggle()<cr>
" For refreshing current file and showing current dir
noremap <Leader>j :NERDTreeFind<cr>
""==================== Fugitive ====================
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
vnoremap <leader>gb :Gblame<CR>

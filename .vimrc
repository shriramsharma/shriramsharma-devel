set tabstop=2
set shiftwidth=2
set expandtab
autocmd BufWritePre *.pl,*.t,*.pm :%s/\s\+$//e
filetype plugin on
syntax on
set syntax=perl
set showmatch
set ruler
set incsearch
set confirm
set laststatus=2
set wildmenu
inoremap <tab> <c-n>
filetype plugin on
set nohlsearch
set grepprg=ack
set backspace=2
set equalprg=perltidy\ -nola
set equalprg=tidy\ -i\ -xml
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
colorscheme murphy

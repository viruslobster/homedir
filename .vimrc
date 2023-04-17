set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sleuth'
Plugin 'fatih/vim-go'
Plugin 'plan9-for-vimspace/acme-colors'
Plugin 'viruslobster/justtxt'

call vundle#end()            " required
filetype plugin indent on    " required

" b/c I learned the wrong keyboard layout
nnoremap l o
vnoremap l o
nnoremap o l
vnoremap o l
nnoremap L O
nnoremap O L
nnoremap j n
vnoremap j n
nnoremap n j
vnoremap n j
nnoremap J N
nnoremap N J
nnoremap gn gj
nnoremap gj gn
nnoremap k e
vnoremap k e
nnoremap e k
vnoremap e k
nnoremap K E
nnoremap E <nop>
nnoremap gk ge
nnoremap ge gk
nnoremap h y
vnoremap h y
onoremap h y
nnoremap y h
vnoremap y h
nnoremap H Y
nnoremap Y H
nnoremap <C-y> <C-w>h
nnoremap <C-n> <C-w>j
nnoremap <C-e> <C-w>k
nnoremap <C-o> <C-w>l

" Higlight lines that are too long
"highlight OverLength ctermbg=red ctermfg=white guibg=#
"match OverLength /\%81v.\+/
"augroup vimrc_autocmds
"  autocmd BufEnter * highlight OverLength ctermbg=red guibg=darkgrey
"  autocmd BufEnter * match OverLength /\%81v.*/
"augroup END

" Eliminate tabs
" used `:retab` fix
" set smartindent
set shiftwidth=4
set tabstop=4
set expandtab
syn match tab display "\t"
hi link tab Error

nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>
nnoremap <leader>pg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>

" Display line numbers
set nu

" syntax for weird fb file extenstions
au BufRead,BufNewFile *.cinc set filetype=python
au BufRead,BufNewFile *.cconf set filetype=python
au BufRead,BufNewFile *.mcconf set filetype=python
au BufRead,BufNewFile *.tw set filetype=python

" maybe i'll be able to see my code now, seems important
"colorscheme gruvbox
"set background=dark
colorscheme acme

" lol, but why is this needed?
set backspace=indent,eol,start

syntax off

" myc fuzzy finding
set rtp+=/usr/local/share/myc/vim
nmap <leader>t :MYC<CR>

let g:go_gopls_enabled = 0
set nowrap

" bc vim internally decided php doesn't get autoindenting. Come on
autocmd FileType php setlocal autoindent

" enable mouse support, like dragging to resize buffers
" set mouse=a


nnoremap <leader>r :JustTxtRun<CR>
nnoremap . :JustTxtRun<CR>
nnoremap <leader>c :JustTxtKill<CR>

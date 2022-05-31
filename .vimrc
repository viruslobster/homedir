set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'fatih/vim-go'
Plugin 'wincent/command-t'
Plugin 'plan9-for-vimspace/acme-colors'
Plugin 'tpope/vim-sleuth'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

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

syntax enable
filetype indent plugin on
set modeline
set number
set tabstop=4
set shiftwidth=4
set expandtab
set viminfo='100,<1000,s100,h

"colorscheme gruvbox
"set background=dark
colorscheme acme
syntax off

set backspace=2 " make backspace work like most other programs
autocmd FileType php setlocal autoindent

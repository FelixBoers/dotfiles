"===================================================
" PLUGINS
"===================================================
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-fugitive'
Plugin 'mtth/scratch.vim'
Plugin 'vim-scripts/BufOnly.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'sjl/badwolf'
Plugin 'scrooloose/syntastic.git'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()            	" required
filetype plugin indent on    	" required

"===================================================
" BASIC SETTINGS
"===================================================
set encoding=utf-8
set fileencoding=utf-8

set ttyfast			            " faster redraw
set backspace=indent,eol,start	" make the backspace key work the way it should

" avoid the 'hit enter to continue' prompts
set shortmess=atI
set cmdheight=2
set noshowmode

" turn off visual bell and error belles
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

set hidden			            " allow leave modified buffers without saving

" tabstops
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set ai

" history
set history=700
set undolevels=700
set noundofile

" searching
set incsearch			        " search as characters are inserted
set hlsearch			        " highlight search matches
set ignorecase smartcase	    " case-insensitive search by default

" folding
set foldenable
nnoremap <space> za

" backup
set nobackup
set noswapfile

"===================================================
" COLOR
"===================================================
syntax on
set background=dark
colors badwolf
let g:badwolf_darkgutter = 1

"===================================================
" LAYOUT
"===================================================
set showcmd			            " show command you have typed at the right bottom
set ruler			            " show the cursor position all the time
set showmode
set number			            " show line numbers
set relativenumber
set wildmenu			        " visual autocompletion for command menu
set lazyredraw
set nocursorline
set showmatch			        " automatically show matching brackets
set splitbelow
set splitright
set fo-=t                       " don't automatically warp text when typing
set nowrap                      " don't automatically wrap on load


"===================================================
" KEYBINDINGS
"===================================================
let mapleader=","
let maplocalleader="."

" edit/source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" go to tag in helpfile
nnoremap t <C-]>

" split navigation
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" tab navigation
nnoremap <leader>n <ESC>:tabprevious<CR>
nnoremap <leader>m <ESC>:tabnext<CR>

" paste multiple times
nnoremap p pgvy

" parenthesis
onoremap p i(
onoremap inp :<c-u>normal! f(vi(<cr>
onoremap ilp :<c-u>normal! F)vi(<cr>

" save with sudo rights
cmap w!! w !sudo teek %

" newline before/after cursor without going to insert mode
nnoremap <S-Enter> O<Esc>j
nnoremap <CR> o<Esc>k

" easier moving of code blocks
vnoremap < <gv
vnoremap > >gv

" quick save command
noremap <F2> :update<CR>
vnoremap <F2> <C-C>:update<CR>
inoremap <F2> <C-O>:update<CR>

"===================================================
" PLUGIN CONFIGURATIONS
"===================================================

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#fnamecollapse = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline_powerline_fonts = 1
set laststatus=2

" CtrlP
let g:ctrlp_match_window='bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

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
Plugin 'sjl/badwolf'
Plugin 'scrooloose/syntastic.git'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'itchyny/vim-gitbranch'
Plugin 'PProvost/vim-ps1'

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

set guifont=Consolas:h11

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
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" backup
set nobackup
set noswapfile

" status line
function! StatuslineGit()
  let l:branchname = gitbranch#name()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

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


"netrw
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 3 " Liststyle: tree
let g:netrw_browse_split = 4 " Open files in a new vertial split
" Toggle Vexplore with F9
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <F9> :call ToggleVExplorer()<CR>

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
nnoremap <leader>o <C-W><C-O>

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

" clear search highlight
nnoremap <esc> :noh<return><esc>

" unindent via Shift+Tab
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>

" YouCompleteMe go to definition
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

"===================================================
" LANGUAGE SPECIFIC
"===================================================

" PYTHON: enable PEP8 indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" Mark bad whitespaces
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'sripts/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

"===================================================
" PLUGIN CONFIGURATIONS
"===================================================

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" CtrlP
let g:ctrlp_match_window='bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

" SimpylFold
let g:SimpylFold_docstring_preview=1

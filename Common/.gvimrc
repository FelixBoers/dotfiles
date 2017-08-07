"set background=dark
"colorscheme solarized

function! ToggleGUICruft()
  if &guioptions=='i'
    exec('set guioptions=imTrL')
  else
    exec('set guioptions=i')
  endif
endfunction

map <F11> <Esc>:call ToggleGUICruft()<cr>

" by default, hide gui menus
set guioptions=i

set mousefocus

set sessionoptions+=resize,winpos
autocmd VIMEnter * :source ~/.vim/.session.vim
autocmd VIMLeave * :mksession! ~/.vim/.session.vim

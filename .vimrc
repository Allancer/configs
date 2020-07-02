execute pathogen#infect('~/.vim/bundle/{}')
set number
syntax on
filetype plugin indent on
" let g:solarized_termcolors=256
set background=dark
colorscheme gotham

call togglebg#map("<F5>")

if !has('gui_running')
	  set t_Co=256
  endif

set laststatus=2 " This line makes lighline.vim appear
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'gotham',
      \ }


------------------------------------

set number
syntax on
set background=light

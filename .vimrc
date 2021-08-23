set number
syntax on
filetype indent on
set t_Co=256
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark    " Setting dark mode
colorscheme deus
let g:deus_termcolors=256

=============================================

set number relativenumber
" enables mouse support to all modes
set mouse=a

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

" Ignore case in general, but become case-sensitive when uppercase is present
set ignorecase smartcase

" Run code | https://stackoverflow.com/a/18948530
autocmd FileType python map <buffer> <F9> :w<CR>:exec 'bel split term://python3' shellescape(@%, 1)<CR> 
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec 'bel split term://python3' shellescape(@%, 1)<CR>
 
"    autocmd: command that Vim will execute automatically on {event} (here: if you open a python file)
"    [i]map: creates a keyboard shortcut to <F9> in insert/normal mode
"    <buffer>: If multiple buffers/files are open: just use the active one
"    <esc>: leaving insert mode
"    :w<CR>: saves your file
"    !: runs the following command in your shell (try :!ls)
"    %: is replaced by the filename of your active buffer. But since it can contain things like whitespace and other "bad" stuff it is better practise not to write :python %, but use:
"    shellescape: escape the special characters. The 1 means with a backslash
"    we need term for interatctive shell so we split and use term:// so we can
"    get our input and the results

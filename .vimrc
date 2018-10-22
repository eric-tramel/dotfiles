"""1. Installed Plugins
call plug#begin('~/.vim/plugged')

Plug 'suan/vim-instant-markdown'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'tmhedberg/simpylfold'
Plug 'scrooloose/syntastic'
Plug 'vimwiki/vimwiki'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'

call plug#end()

""" 2. Basic vim configiruation
set number
set relativenumber
set showcmd
set wildmenu
syntax on
syntax enable
filetype indent plugin on
set nocompatible
set mouse=a
set backspace=indent,eol,start
set scrolloff=10
set noshowmode
set splitright

""" 3. Configure Plugins
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeIgnore = ['\.pyc$','.DS_Store$','\.swp$','__pycache__$','.vscode$']
let NERDTreeShowHidden=1

"""" vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                       \ 'syntax': 'markdown', 'ext': '.md'}]


""" 4. Set color schemes
colorscheme tokyo-metro
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ }

set fillchars+=vert:.

"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h


" Set Tabs
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces




" Trying some fold jumping key mapping per
" https://stackoverflow.com/questions/9403098/is-it-possible-to-jump-to-closed-folds-in-vim
nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

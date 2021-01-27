"""1. Installed Plugins
call plug#begin('~/.vim/plugged')

Plug 'eric-tramel/nord-vim'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'tmhedberg/simpylfold'
Plug 'w0rp/ale'
"Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/vim-easy-align'
Plug 'godlygeek/tabular'
Plug 'lervag/vimtex'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/goyo.vim'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'CrispyDrone/vim-tasks'
Plug 'cespare/vim-toml'

call plug#end()


""" 2. Basic vim configiruation
set number
set relativenumber
set showcmd
set wildmenu
syntax enable
filetype indent plugin on
syntax on
set nocompatible
set mouse=a
set backspace=indent,eol,start
set scrolloff=10
set noshowmode
set splitright
"" I had to add the following two lines because for some reason,
"" after upgrading vim, I started to get a bunch of '[?]' on 
"" glpyhs.
set termencoding=utf-8
set encoding=utf-8

""" 3. Configure Plugins
"""" NerdTree
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeIgnore = ['\.pyc$','.DS_Store$','\.swp$','__pycache__$','.vscode$']
let NERDTreeShowHidden=1
let g:NERDTreeWinSize=20

"""" vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                       \ 'syntax': 'markdown', 'ext': '.md'}]

""" Markdown settings
let g:vim_markdown_new_list_item_indent = 4
let g:vim_markdown_math = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_folding_disabled=1


"""" Tagbar
nmap <F8> :TagbarToggle<CR>

""" 4. Set color schemes
"colorscheme tokyo-metro
colorscheme nord
let g:nord_italic = 1
" For Airline
let g:airline_theme='nord'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" ALE Configs
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%] %s [%linter%] (%code%)'

nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)


"" from help
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#ale#enabled = 1

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''



set fillchars+=vert:.

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



""" For Python
au BufRead,BufNewFile *.py,*.pyw match Cursor /\s\+$/

""" For LaTeX
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
"let g:vimtex_compiler_latexmk='latexmk'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'


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

" Trying stuff for tags
" set statusline+=%{gutentags#statusline('>>','')}
let g:gutentags_exclude_filetypes=['tex', 'latex']

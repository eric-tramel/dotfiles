"""1. Installed Plugins
call plug#begin('~/.vim/plugged')

Plug 'suan/vim-instant-markdown'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'tmhedberg/simpylfold'
Plug 'scrooloose/syntastic'

call plug#end()

autocmd vimenter * NERDTree


set number
set relativenumber
set showcmd
set wildmenu
syntax on
syntax enable
colorscheme tokyo-metro
"colorschme gummybears
"colorscheme orange-moon
filetype indent plugin on
highlight LineNr ctermfg=lightgrey
highlight LineNr ctermbg=darkgrey

set mouse=a
set backspace=indent,eol,start
set scrolloff=10

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeIgnore = ['\.pyc$','.DS_Store$','\.swp$','__pycache__$','.vscode$']
let NERDTreeShowHidden=1

set fillchars+=vert:.
hi StatusLine ctermbg=black ctermfg=white

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Cyan ctermfg=6 guifg=Black ctermbg=0
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  else
    hi statusline guibg=DarkRed ctermfg=1 guifg=Black ctermbg=0
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=10 guifg=White ctermbg=0

" default the statusline to green when entering Vim
hi statusline guibg=DarkGrey ctermfg=10 guifg=White ctermbg=0

" Formats the statusline
set statusline=%f                           " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%y      "filetype
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag

" Puts in the current git status
set statusline+=%{fugitive#statusline()}

" Puts in syntastic warnings
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set statusline+=\ %=                        " align left
set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
set statusline+=\ Col:%c                    " current column
" set statusline+=\ Buf:%n                    " Buffer number
" set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor
"
" Set Tabs
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

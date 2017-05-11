autocmd! BufWritePost ~/.vimrc source ~/.vimrc
autocmd! Filetype html setlocal ts=2 sts=2 sw=2
autocmd! Filetype css setlocal ts=2 sts=2 sw=2
autocmd! Filetype md :MarkdownPreview<CR>
autocmd! Filetype py setlocal textwidth=79
autocmd! FileType python map <buffer> <leader>8 :call Flake8()<CR>
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
"if has("multi_byte")
    "if &termencoding == ""
        "let &termencoding = &encoding
    "endif
    "set encoding=utf-8
    "setglobal fileencoding=utf-8
    "set fileencodings=ucs-bom,utf-8,latin1,cp936
"endif
filetype off
filetype plugin indent on
syntax enable
syntax on
set expandtab
set tabstop=4
set shiftwidth=4
set laststatus=2
set number
set hlsearch
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936,latin1
set termencoding=utf-8
set encoding=utf-8

set sessionoptions="blank,buffers,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"
set undodir=~/.undo_history/
set undofile


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"Plugin 'vim-syntastic/syntastic'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'groenewege/vim-less'
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'edkolev/tmuxline.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'iamcco/mathjax-support-for-mkdp'
Plugin 'iamcco/markdown-preview.vim'
Plugin 'lilydjwg/fcitx.vim'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'Shougo/unite.vim'
Plugin 'nvie/vim-flake8'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'itchyny/vim-cursorword'
Plugin 'tpope/vim-surround'
Plugin 'mhinz/vim-startify'
Plugin 'easymotion/vim-easymotion'
Plugin 'ntpeters/vim-better-whitespace', {'on': 'StripWhitespace'}
Plugin 'Raimondi/delimitMate'
Plugin 'othree/html5.vim'
Plugin 'mattn/emmet-vim'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'ryanoasis/vim-devicons'
call vundle#end()

colorscheme Tomorrow-Night-Eighties
hi Normal ctermbg=None
hi LineNr ctermbg=None
let mapleader=";"
nmap LB 0
nmap LE $
vnoremap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
nmap <Leader>WQ :wa<CR>:q<CR>
nmap <Leader>Q :qa!<CR>
nmap <Leader>x :x<CR>
nnoremap nw <C-W><C-W>
nnoremap <Leader>lw <C-W>l
nnoremap <Leader>hw <C-W>h
nnoremap <Leader>kw <C-W>k
nnoremap <Leader>jw <C-W>j
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
map <Leader>1 :b 1<CR>
map <Leader>2 :b 2<CR>
map <Leader>3 :b 3<CR>
map <Leader>4 :b 4<CR>
map <Leader>5 :b 5<CR>
nmap <Leader>M %
nmap <Leader>fl :NERDTreeToggle<CR>
nnoremap <Leader>gy :Goyo<CR>
nnoremap <Leader>xd :StripWhitespace<CR>
nmap <Leader>mk :MarkdownPreview<CR>

let NERDTreeWinSize=32
let NERDTreeWinPos="violet"
let NERDTreeShowHidden=1

let g:airline_powerline_fonts=1
let g:airline_theme='term'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_idx_mode=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#tabline#buffer_nr_format='%s:'
let g:airline#extensions#tmuxline#enabled=0
let g:airline#extensions#branch#enabled=1
"let g:airline#extensions#default#section_truncate_width = {
                "\ 'b': 79,
                "\ 'x': 60,
                "\ 'y': 88,
                "\ 'z': 45,
                "\ 'warning': 80,
                "\ 'error': 80,
                "\ }


let g:pymode_lint_checkers = ['pyflakes']
hi pythonLambdaExpr      ctermfg=105 guifg=#8787ff
hi pythonInclude         ctermfg=68  guifg=#5f87d7 cterm=bold gui=bold
hi pythonClass           ctermfg=167 guifg=#FF62B0 cterm=bold gui=bold
hi pythonParameters      ctermfg=147 guifg=#AAAAFF
hi pythonParam           ctermfg=175 guifg=#E37795
hi pythonBrackets        ctermfg=183 guifg=#d7afff
hi pythonClassParameters ctermfg=111 guifg=#FF5353
hi pythonSelf            ctermfg=68  guifg=#5f87d7 cterm=bold gui=bold
hi pythonDottedName      ctermfg=74  guifg=#5fafd7
hi pythonError           ctermfg=196 guifg=#ff0000
hi pythonIndentError     ctermfg=197 guifg=#ff005f
hi pythonSpaceError      ctermfg=198 guifg=#ff0087
hi pythonBuiltinType     ctermfg=74  guifg=#9191FF
hi pythonBuiltinObj      ctermfg=71  guifg=#5faf5f
hi pythonBuiltinFunc     ctermfg=169 guifg=#d75faf cterm=bold gui=bold
hi pythonException       ctermfg=207 guifg=#CC3366 cterm=bold gui=bold

let g:limelight_conceal_ctermfg='gray'
let g:Goyo_width=1024
let g:Goyo_height=768

highlight ExtraWhitespace ctermbg=197

let g:mkdp_path_to_chrome="google-chrome-stable"

let g:ycm_semantic_triggers = {
    \ 'css': ['re!^\s{4}', 're!:\s+'],
    \ 'html': ['</'],
    \}
let g:ycm_server_python_interpreter = "/usr/bin/python2"

" for tmux to automatically set paste and nopaste mode at the time pasting (as
" happens in VIM UI)
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>",'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

let g:ycm_collect_identifiers_from_tags_files = 1
set tags+=/data/misc/software/misc./vim/stdcpp.tags
inoremap <leader>; <C-x><C-o>
set completeopt=preview
let g:ycm_server_python_interpreter='/usr/bin/python2'
let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_comfirm_extra_conf=0
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=1

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

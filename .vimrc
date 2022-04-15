" Vundle manage
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'arcticicestudio/nord-vim'
Plugin 'sainnhe/gruvbox-material'
Plugin 'chriskempson/base16-vim'
Plugin 'tomasr/molokai'

Plugin 'preservim/nerdtree'
Plugin 'preservim/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'dense-analysis/ale'

Plugin 'Valloric/YouCompleteMe'
"Plugin 'ludovicchabant/vim-gutentags'

Plugin 'tpope/vim-sensible'

" Plugin 'ryanoasis/vim-devicons'

Plugin 'ronakg/quickr-cscope.vim'
call vundle#end()
filetype plugin indent on

""" style
set background=light
highlight LineNr ctermfg=DarkGrey
highlight CursorLine cterm=underline
" Vim split bar styling
" https://stackoverflow.com/questions/9001337/vim-split-bar-styling
highlight VertSplit cterm=NONE
set fillchars+=vert:\|

" Shows syntax highlighting groups for the current cursor position
" https://githubhot.com/repo/arcticicestudio/nord-vim/issues/259
augroup nord-theme-overrides
  autocmd!
  " Use Grey as foreground color for Vim comment titles.
  autocmd ColorScheme nord highlight Comment ctermfg=Grey cterm=italic
augroup END

nmap <C-S-K> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

set foldmethod=syntax
syntax enable
colorscheme nord

" Basic config for Linux Kernel C Style
" https://gist.github.com/mxwell/4246602
syn keyword cType uint ubyte ulong uint64_t uint32_t uint16_t uint8_t boolean_t int64_t int32_t int16_t int8_t u_int64_t u_int32_t u_int16_t u_int8_t
syn keyword cOperator likely unlikely


set showcmd
set title
set smarttab
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2
set number
set autoindent
set cindent
set incsearch
set hlsearch
"set cursorline

if has("autocmd")
  " fold default to unfolded
  " https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
  autocmd BufWinEnter * normal zR

  " Tagbar
  " autocmd BufReadPost *.cpp,*.c,*.h,*.cc,*.cxx call tagbar#autoopen(1) | setlocal nocursorline
  " For opening Tagbar also if you open a supported file in an already running
  " https://github.com/preservim/tagbar/blob/master/doc/tagbar.txt
  autocmd FileType * nested :call tagbar#autoopen(0)

  " NetReTree
  " Start NERDTree when Vim is started without file arguments.
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc()==0 && !exists('s:std_in') | NERDTree | endif
  " Close the tab if NERDTree is the only window remaining in it.
  autocmd BufEnter * if winnr('$')==1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

  " CursorLine highlight applied in the current window only
  " https://vim.fandom.com/wiki/Highlight_current_line
  "augroup CursorLine
  "  au!
  "  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  "  au WinLeave * setlocal nocursorline
  "augroup END
endif

nnoremap <space> za <CR>


" Ctage
set tags=./tags;,tags
"nnoremap <C-]> <Esc>:exe "ptjump " . expand("<cword>")<Esc>

" airline
let g:airline_theme='serene'
"let g:airline_theme='nord'
"let g:airline#extensions#tabline#enabled=1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Tagbar
nnoremap <C-m> :TagbarToggle<CR>
"let g:tarbar_width=20

" Issue with universal-ctags installed via snap
" https://github.com/preservim/tagbar/issues/568
"let g:tagbar_use_cache = 0

" NetReTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Ale
"let g:ale_sign_column_always=1
let g:ale_lint_on_text_changed='normal'
let g:ale_lint_on_insert_leave=1
let g:ale_echo_msg_format='[%linter%,%severity%]%(code): %%s'
"let g:ale_set_highlights=1
"let g:ale_virtualtext_cursor=1
"let g:ale_sign_error='✗'
"let g:ale_sign_warning='w'
"let g:ale_statusline_format=['✗ %d', '⚡ %d', '✔ OK']
let g:ale_c_gcc_options='-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options='-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options=''
let g:ale_cpp_cppcheck_options=''

" YouCompleteMe
"let g:ycm_server_python_interpreter='/usr/bin/python3'
"let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_add_preview_to_completeopt=0
let g:ycm_show_diagnostics_ui=0
let g:ycm_server_log_level='info'
let g:ycm_min_num_identifier_candidate_chars=2
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion='<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }

highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

let g:ycm_filetype_whitelist = {
			\ "c":1,
			\ "cpp":1,
			\ }

" Gutentags
"set statusline+=%{gutentags#statusline()}

" 搜索工程目錄的標誌，碰到這些文件/目錄名就停止向上一級目錄遞歸
let g:gutentags_project_root=['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile='tags'

" 配置 ctags 的參數
let g:gutentags_ctags_extra_args=['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args+=['--c++-kinds=+px']
let g:gutentags_ctags_extra_args+=['--c-kinds=+px']

"-----------------------------------------------------------
" cscope:建立資料庫：cscope -Rbq； F5 查找c符號； F6 查找字符串； F7 查找函數定義； F8 查找函數誰調用了
"-----------------------------------------------------------
"if has("cscope")
"	set csprg=/usr/bin/cscope
"	set csto=1
"	set cst
"	set nocsverb
	" add any database in current directory
"	if filereadable("cscope.out")
"		cs add cscope.out
"	endif
"	set csverb
"endif
":set cscopequickfix=s-,c-,d-,i-,t-,e-
"nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"F5 查找c符號； F6 查找字符串； F7 查找函數誰調用
"nmap <silent> <F5> :cs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <silent> <F6> :cs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <silent> <F7> :cs find c <C-R>=expand("<cword>")<CR><CR>

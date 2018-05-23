"dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

" dein
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" install dein.vim if not exists
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir = expand('~/.vim/rc')
  let s:toml = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------


set number
syntax on

set backspace=indent,eol,start

set nobackup
set noundofile
set history=10000
set ruler " show the cursor position all the time
set cursorline

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

set autochdir " auto change directory

set vb t_vb= " suppress error bell

set diffopt+=vertical

" ------------------------------------------------------------------------------
" Enabled file type detection
" Use the default filetype settings. If you also want to load indent files
" to automatically do language-dependent indenting add 'indent' as well.
filetype plugin on
filetype indent on

set shiftwidth=4
set tabstop=4
set softtabstop=4
autocmd FileType xhtml,html,ruby,memo setlocal sw=2 ts=2 sts=2

set expandtab
autocmd FileType c,cpp,make setlocal noexpandtab

set smartindent

set wrap
set showcmd
set laststatus=2
set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=\ %l,%c%V%8P

set list
set listchars=tab:~\ ,extends:>,precedes:<,trail:-,eol:_

set showmatch
inoremap { {}<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap " ""<left>
inoremap ' ''<left>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

set wildmenu
set wildmode=list:longest

set hidden
set autoread

" search
set ignorecase
set smartcase
set wrapscan
set hlsearch
set incsearch

set encoding=utf-8
set fileencodings=utf-8,euc-jp,cp932,iso-2022-jp

set fileformats=unix,dos,mac
if exists('&ambiwidth')
  set ambiwidth=double
endif

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif


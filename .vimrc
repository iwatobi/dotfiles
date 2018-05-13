" vim: set fdm=marker sw=4 ts=4 sts=4:
" -----------------------------------------------------------------------------
" Vim Settings
" -----------------------------------------------------------------------------

set nocompatible  " Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start  " <BS>の制限を外す

set textwidth=0   " Don't wrap words by default
set nobackup    " Don't keep a backup file
set viminfo='50,<1000,s100,\"50 " read/write a .viminfo file, don't store more than
" set viminfo='50,<1000,s100,:0,n~/.vim/viminfo
set history=10000   " keep 10000 lines of command line history
set ruler " show the cursor position all the time
set number " 行番号を表示

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

set autochdir " auto change directory

set vb t_vb= " errorbellを抑制

set diffopt+=vertical

" ------------------------------------------------------------------------------
" Enabled file type detection
" Use the default filetype settings. If you also want to load indent files
" to automatically do language-dependent indenting add 'indent' as well.
filetype plugin on
" そのファイルタイプにあわせたインデントを利用する
filetype indent on
" これらのftではインデントを無効に
" autocmd FileType php filetype indent off
" autocmd FileType php set indentexpr=
" autocmd FileType html set indentexpr=
" autocmd FileType xhtml set indentexpr=

" シンタックスハイライトを有効にする
syntax on

" ------------------------------------------------------------------------------
" インデント幅(shiftwidth)
" タブ幅(tabstop, softtabstop)
set shiftwidth=4
set tabstop=4
set softtabstop=4
autocmd FileType xhtml,html,ruby,memo setlocal sw=2 ts=2 sts=2

" TabをSpaceに展開
set expandtab
autocmd FileType c,cpp,python,make setlocal noexpandtab

" ------------------------------------------------------------------------------
" インデント設定 {{{
set smartindent
" set autoindent

" :h 'cinoptions'
set cinoptions+=+8
autocmd FileType c,cpp setlocal cinoptions+=:0g0t0

" namespaceでインデントしない(C++)
function! GetCppIndent()
  let curr_line = getpos('.')[1]
  let prev_indx = 1
  while match(getline(curr_line - prev_indx), '^[ \t]*$') == 0
      let prev_indx = prev_indx + 1
  endwhile
  let prev_line = getline(curr_line - prev_indx)
  let ns_indent = match(prev_line, 'namespace')
  if 0 <= ns_indent
      return ns_indent
  endif
  return cindent('.')
endfunction
autocmd FileType cpp setlocal indentexpr+=GetCppIndent()
" }}}
" ------------------------------------------------------------------------------
set wrap " 折り返す
set showcmd " 入力中のコマンドをステータスに表示する
set showmatch " 括弧入力時の対応する括弧を表示
set laststatus=2 " ステータスラインを常に表示
" ステータスラインに文字コードと改行文字を表示する
set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=[%{GetB()}]\ %l,%c%V%8P

set list " listcharsで指定した文字でタブ・改行・行末スペース・行末を表示する
set listchars=tab:~\ ,extends:>,precedes:<,trail:-,eol:_

" コマンドライン補完
set wildmenu
set wildmode=list:longest

set hidden " バッファが編集中でもその他のファイルを開けるように
set autoread " 外部のエディタで編集中のファイルが変更されたら自動で読み直す

" -----------------------------------------------------------------------------
" 検索関連
set ignorecase " 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase " 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan " 検索時に最後まで行ったら最初に戻る
set hlsearch " 検索結果文字列をハイライト
set incsearch " IncrementalSearch

" ------------------------------------------------------------------------------
" 文字コード関連 {{{

" $VIMRUNTIME/encode_japan.vim に頼る
set encoding=utf-8
set fileencodings=euc-jp,cp932,iso-2022-jp

" from ずんWiki http://www.kawaz.jp/pukiwiki/?vim#content_1_7
" if &encoding !=# 'utf-8'
  " set encoding=japan
" endif
" set fileencoding=japan
" if has('iconv')
  " let s:enc_euc = 'euc-jp'
  " let s:enc_jis = 'iso-2022-jp'
  " " iconvがJISX0213に対応しているかをチェック
  " if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    " let s:enc_euc = 'euc-jisx0213'
    " let s:enc_jis = 'iso-2022-jp-3'
  " endif
  " " fileencodingsを構築
  " if &encoding ==# 'utf-8'
    " let s:fileencodings_default = &fileencodings
    " let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    " let &fileencodings = &fileencodings .','. s:fileencodings_default
    " unlet s:fileencodings_default
  " else
    " let &fileencodings = &fileencodings .','. s:enc_jis
    " set fileencodings+=utf-8,ucs-2le,ucs-2
    " if &encoding =~# '^euc-\%(jp\|jisx0213\)$'
      " set fileencodings+=cp932
      " set fileencodings-=euc-jp
      " set fileencodings-=euc-jisx0213
      " let &encoding = s:enc_euc
    " else
      " let &fileencodings = &fileencodings .','. s:enc_euc
    " endif
  " endif
  " " 定数を処分
  " unlet s:enc_euc
  " unlet s:enc_jis
" endif

" " 日本語を含まない場合は fileencoding に encoding を使うようにする
" if has('autocmd')
    " function! AU_ReCheck_FENC()
        " if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
            " let &fileencoding=&encoding
        " endif
    " endfunction
    " autocmd BufReadPost * call AU_ReCheck_FENC()
" endif
" }}}

" ------------------------------------------------------------------------------
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
    set ambiwidth=double
endif

" ------------------------------------------------------------------------------
" migemo辞書設定 {{{
if has('migemo')
    set migemo
    set migemodict=$VIM/vimfiles/migemo_dict/migemo-dict
endif
" }}}

" ------------------------------------------------------------------------------
" ActionScript
autocmd BufNewFile,BufRead *.as set filetype=actionscript

" ------------------------------------------------------------------------------
" vimperatorrc
autocmd BufNewFile,BufRead .vimperatorrc set filetype=vimperator

" ------------------------------------------------------------------------------
" CharCode取得関数 {{{
function! GetB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Hex(c)
endfunction
" :help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
function! Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
function! String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc
" }}}

" ------------------------------------------------------------------------------
" 折り畳み
"set foldmethod=syntax
"autocmd FileType php setlocal foldmethod=indent
"autocmd FileType javascript setlocal foldmethod=indent
"autocmd FileType yaml setlocal foldmethod=indent
"autocmd FileType actionscript setlocal foldmethod=indent
"autocmd FileType perl setlocal foldmethod=indent
"autocmd FileType memo setlocal foldmethod=indent

" ------------------------------------------------------------------------------
" cvs,svnの時は文字コードをeuc-jpに設定
autocmd FileType cvs setlocal fileencoding=euc-jp
autocmd FileType svn setlocal fileencoding=utf-8

" ------------------------------------------------------------------------------
" tagsの生成 {{{
function! Ctags()
    if &filetype == 'cpp'
        :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q *.cpp *.h *.hpp
    elseif &filetype == 'php'
        :!ctags -R --PHP-kinds=+cf-v *.php
    else
        :!ctags -R *.*
    endif
endfunction
:command! Ctags :call Ctags()
" }}}

set tags=tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags,../../../../../../tags,../../../../../../../tags,../../../../../../../../tags,../../../../../../../../../tags,../../../../../../../../../../tags,../../../../../../../../../../../tags,../../../../../../../../../../../../tags,../../../../../../../../../../../../../tags,../../../../../../../../../../../../../../tags,../../../../../../../../../../../../../../../tags,../../../../../../../../../../../../../../../../tags,../../../../../../../../../../../../../../../../../tags,../../../../../../../../../../../../../../../../../../tags,../../../../../../../../../../../../../../../../../../../tags,../../../../../../../../../../../../../../../../../../../../tags,../../../../../../../../../../../../../../../../../../../../../tags

" ------------------------------------------------------------------------------
" C {{{
" autocmd FileType c setlocal tags+=c:/cygwin/home/NFv3.4SP16/slim/tags
" autocmd FileType c setlocal path+=c:/cygwin/home/NFv3.4SP16/slim
" autocmd FileType c,cpp setlocal path+=c:/cygwin/usr/include
" autocmd FileType c,cpp setlocal path+=c:/cygwin/usr/include/tags
" }}}

" ------------------------------------------------------------------------------
" C++ {{{
" STLのtagsとpathを追加
" autocmd FileType cpp setlocal tags+=c:/cygwin/home/NFv3.4SP16/slim/tags
" autocmd FileType cpp setlocal path+=c:/cygwin/home/NFv3.4SP16/slim
" autocmd FileType cpp setlocal tags+=c:/cygwin/lib/gcc/i686-pc-cygwin/3.4.4/include/c++/tags
" autocmd FileType cpp setlocal path+=c:/cygwin/lib/gcc/i686-pc-cygwin/3.4.4/include/c++
" Boostのtagsとpathを追加
autocmd FileType cpp setlocal tags+=$Boost/boost/tags
autocmd FileType cpp setlocal path+=$Boost
" }}}

" ------------------------------------------------------------------------------
" Javascript {{{
" 辞書ファイルからの単語補完
autocmd FileType javascript setlocal complete+=k
autocmd FileType javascript setlocal dictionary+=$VIM/vimfiles/dict/javascript.dict
" }}}

" ------------------------------------------------------------------------------
" CSS {{{
" 辞書ファイルからの単語補完
autocmd FileType css setlocal complete+=k
autocmd FileType css setlocal dictionary+=$VIM/vimfiles/dict/css.dict
" }}}

" ------------------------------------------------------------------------------
" HTML {{{
" 辞書ファイルからの単語補完
autocmd FileType html setlocal complete+=k
autocmd FileType html setlocal dictionary+=$VIM/vimfiles/dict/html.dict
" }}}

" ------------------------------------------------------------------------------
" PHP {{{
" 辞書ファイルからの単語補完
autocmd FileType php setlocal complete+=k
autocmd FileType php setlocal dictionary+=$VIM/vimfiles/dict/php_functions.dict

" PEAR & includes
autocmd FileType php setlocal path+=c:/php/pear,c:/php/includes

" :makeでPHP構文チェック
autocmd FileType php setlocal makeprg=php\ -l\ %
autocmd FileType php setlocal errorformat=%m\ in\ %f\ on\ line\ %l

" PHP fileencoding UTF-8
autocmd FileType php setlocal fileencoding=utf-8

" 文字列中のSQLクエリをハイライト
let php_sql_query=1
" 文字列中のHTMLをハイライト
let php_htmlInStrings=1
" ショートタグ(<?)を無効にする(ハイライト除外)
let php_noShortTags=1
" クラスと関数のfoldingを無効にする
" let php_folding=1
" }}}

" ------------------------------------------------------------------------------
" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" ------------------------------------------------------------------------------
" closetag.vim
" http://www.vim.org/scripts/script.php?script_id=13
" C-_で(X)HTMLタグをとじる
" let g:closetag_html_style=1

" ------------------------------------------------------------------------------
" Chalice
" 板デフォルトの名無しさんを使用
let chalice_anonyname = ''
" プロクシを使用
" let chalice_curl_options = '-x 157.78.32.241:8080'
let chalice_statusline = '%c,'
set runtimepath+=$VIM/vimfiles/chalice
let chalice_preview = 0
" 起動時にスレの栞を表示
let chalice_startupflags = 'bookmark'
let chalice_writeoptions = 'amp,nbsp,zenkaku'

autocmd FileType 2ch_bookmark setlocal sw=1 ts=20 sts=20
autocmd FileType 2ch_write setlocal wrap

" ------------------------------------------------------------------------------
" html escape function {{{
:function! HtmlEscape()
    silent s/&/\&amp;/eg
    silent s/</\&lt;/eg
    silent s/>/\&gt;/eg
:endfunction
" :command! HtmlEscape :call HtmlEscape()

:function! HtmlUnEscape()
    silent s/&lt;/</eg
    silent s/&gt;/>/eg
    silent s/&amp;/\&/eg
:endfunction
" :command! HtmlUnEscape :call HtmlUnEscape()
" }}}

" ------------------------------------------------------------------------------
" AutoClose.vim Off
let g:autoclose_on = 0

" ------------------------------------------------------------------------------

let html_use_css = 1 " code2html

" SeeTab
let g:SeeTabCtermFG="black"
let g:SeeTabCtermBG="red"

let g:netrw_ftp_cmd="ftp" " netrw-ftp
let g:netrw_http_cmd="wget -q -O" " netrw-http

" ------------------------------------------------------------------------------
" GUIのクリップボードを使う
" if has('GUI')
"    set clipboard=unnamed
" endif

" ------------------------------------------------------------------------------
" Intellisence.vim
" let $VIM_INTELLISENSE = '$VIM/Intellisense'
" if has('win32')
"    let g:intellisense_root_dir = expand('$VIM/Intellisense')
"    if isdirectory(expand($JAVA_HOME))
"        let g:intellisense_jvm_dir  = expand('$JAVA_HOME\jre\bin\server')
"        let g:intellisense_javaapi_dir  = expand('$JAVA_HOME\docs\api')
"    endif
" endif

" ------------------------------------------------------------------------------
" backup
" set backup
" set backupdir=$home/.vim/tmp
" let file = strftime(".%Y%m%d%H%M%S", localtime())
" exe "set backupext=".file
" unlet file

" ------------------------------------------------------------------------------
" yankring setting
" http://www.vim.org/scripts/script.php?script_id=1234
let g:yankring_persist = 0

" ------------------------------------------------------------------------------
" 補完候補の色づけ for vim7
hi Pmenu ctermbg=9
hi PmenuSel ctermbg=1
hi PmenuSbar ctermbg=3

" ------------------------------------------------------------------------------
" minibufexp
" "set minibufexp
" let g:miniBufExplMapWindowNavVim = 1 "hjklで移動
" let g:miniBufExplSplitBelow=0  " Put new window above
" let g:miniBufExplMapWindowNavArrows = 1
" let g:miniBufExplMapCTabSwitchBufs = 1
" let g:miniBufExplModSelTarget = 1
" "let g:miniBufExplSplitToEdge=1

" ------------------------------------------------------------------------------
" Mappings {{{
"
" mapleader
let mapleader = ","

" ------------------------------------------------------------------------------
" 表示行単位で行移動する {{{
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k
" }}}

" ------------------------------------------------------------------------------
" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" yeでそのカーソル位置にある単語をレジスタに追加
nmap ye :let @"=expand("<cword>")<CR>

" バッファ切替
nmap <Space> :bn<CR>
nmap <S-Space> :bp<CR>

" IncBufSwitch.vim
" nnoremap <Leader>s :IncBufSwitch<CR>
" nnoremap <Leader><C-s> :IncBufSwitch<CR>
nnoremap <C-s> :FuzzyFinderBuffer<CR>

" スクリプトをその場で実行
nmap <Leader>e :execute '!' &ft ' %'<CR>

" カレントバッファを最大化
nmap <Leader>r :resize<CR>

" YankRing一覧を表示(YankRing.vim)
nmap <Leader>y :YRShow<CR>

" *.h <-> *.cpp (A.vim)
nmap <Leader>a :A<CR>

" Perl/Ruby互換正規表現で検索(eregex.vim)
nnoremap <Leader>/ :M/

" ------------------------------------------------------------------------------
" TagList.vim
" http://www.vim.org/scripts/script.php?script_id=273
nmap <Leader>o :Tlist<CR>

" フレームサイズを怠惰に変更する
map <kPlus> <C-W>+
map <kMinus> <C-W>-

" C-]でtjと同等の効果
nmap <C-]> g<C-]>

" ------------------------------------------------------------------------------
" Emacs Like Key Bind
inoremap <C-A> <Home>
inoremap <C-B> <Left>
" inoremap <C-D> <Del>
inoremap <C-F> <Right>
inoremap <C-E> <End>

" command mode 時 tcsh風のキーバインドに
cmap <C-A> <Home>
cmap <C-F> <Right>
cmap <C-B> <Left>
" cmap <C-D> <Delete>
" cmap <Esc>b <S-Left>
" cmap <Esc>f <S-Right>
cnoremap  

" ------------------------------------------------------------------------------
" increment.vim
" 矩形選択中に<C-A>で連番になるようにインクリメントする
vnoremap <C-A> :Inc<CR>

" ------------------------------------------------------------------------------
" snippetsEmu.vim
" http://www.vim.org/scripts/script.php?script_id=1318
" if exists('loaded_snippet')
"    imap <C-S> <Plug>Jumper
" endif

" CapsLockをCtrlにしていると<C-X>が押しにくいため
"  modeに<C-S>でも入れるようにする
inoremap <C-S> <C-X>

" <C-\>でIME切替
inoremap  
cnoremap  

" insert mode中の<C-@>誤発動対策
inoremap <C-@> <Nop>

" ------------------------------------------------------------------------------
" 関数移動の後にzz {{{
nnoremap [[ [[zt<C-y><C-y>
nnoremap [] []zb<C-e><C-e>
nnoremap ]] ]]zt<C-y><C-y>
nnoremap ][ ][zb<C-e><C-e>
" }}}

" ------------------------------------------------------------------------------
" FuzzyFinder {{{
" http://hiki.ns9tks.net/?fuzzyfinder.vim
" http://www.vim.org/scripts/script.php?script_id=1984

" mappings
" launchs the buffer explorer.
nmap <Leader>b :FuzzyFinderBuffer<CR>
" launchs the file explorer.
nmap <Leader>f :FuzzyFinderFile<CR>
" launchs the MRU-file explorer.
nmap <Leader>m :FuzzyFinderMruFile<CR>
" launchs the MRU-command explorer.
" nmap <Leader>c :FuzzyFinderMruCmd<CR>
" launchs the favorite-file explorer.
" nmap <Leader>v :FuzzyFinderFavFile<CR>
" launchs the directory explorer.
nmap <Leader>d :FuzzyFinderDir<CR>
" launchs the tag explorer.
" nmap <Leader>p :FuzzyFinderTag<CR>
" launchs the tagged-file explorer.
" nmap <Leader>t :FuzzyFinderTaggedFile<CR>

" options
" let g:FuzzyFinderOptions['migemo_support'] = 1
" }}}

" ------------------------------------------------------------------------------
" NERDCommenter {{{
" http://www.vim.org/scripts/script.php?script_id=1218
" toggleComment
nmap <Leader>x ,c<Space>
vmap <Leader>x ,c<Space>

let NERDShutUp = 1 " 未対応だった場合の警告を黙らせる
let NERDSpaceDelims = 1 " スペースを空ける
" }}}

" ------------------------------------------------------------------------------
" BufExplorer
nmap <C-@> :BufExplorer<CR>

nnoremap ,w :se wrap!<CR>

nnoremap ,E :e ++enc=euc-jp<CR>
nnoremap ,U :e ++enc=utf-8<CR>
nnoremap ,S :e ++enc=cp932<CR>

" ------------------------------------------------------------------------------
" mapleaderを処分
unlet mapleader
" }}} Mappings
" ------------------------------------------------------------------------------

if &diff
    set bg=dark
endif

"<TAB>で補完
" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function! InsertTabWrapper()
        let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
                return "\<TAB>"
        else
                if pumvisible()
                        return "\<C-N>"
                else
                        return "\<C-N>\<C-P>"
                end
        endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }}} Autocompletion using the TAB key

highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PmenuSbar ctermbg=4

"setting for gtags
map <C-g> :Gtags 
map <C-j> :Gtags -f %<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>
map <C-c> :ccl<CR>
map <C-]> :GtagsCursor<CR>

inoremap <silent> <expr> ,t
      \ (exists('#AutoComplPopGlobalAutoCommand#InsertEnter#*')) ? "\<C-o>:AutoComplPopDisable\<CR>" : "\<C-o>:AutoComplPopEnable\<CR>"

set whichwrap=b,s,<,>,[,]

set noic
"set mouse=a

"setting for yamptmp
map <silent> sd :call YanktmpDelete()<CR>
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

map <C-M> :Migemo<CR>

imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap <> <><Left>

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

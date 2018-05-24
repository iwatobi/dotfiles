set columns=104
set lines=33

set background=dark

source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim

" font
if has('win32')
  set guifont=Consolas:h13
  set guifontwide=MS_Gothic:h13:cSHIFTJIS
  set linespace=1
  if has('kaoriya')
    set ambiwidth=auto
  endif
endif

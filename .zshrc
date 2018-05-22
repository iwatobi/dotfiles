### .zshrc

# Vi style key binding
# bindkey -v

# Emacs style key binding
bindkey -e

# エスケープシーケンスを使う。
setopt prompt_subst

case ${UID} in
0)
    PROMPT="%B%{[31m%}%/%{[m%}%b
$ "
    PROMPT2="%B%{[31m%}%_%{[m%}%b> "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[32m%}%n@%m[%W %T]%{[m%} %{[33m%}%/%{[m%}
$ "
    PROMPT2="%{[32m%}%_%{[m%}> "
    #RPROMPT="[%{[33m%}%h%{[m%}]"
    SPROMPT="%{[32m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac

# PROMPT="%/%% "
# PROMPT2="%_%% "
# SPROMPT="%r is correct? [n,y,a,e]: "

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats '(%b|%a)'
precmd () { vcs_info }
RPROMPT=$RPROMT'${vcs_info_msg_0_}'

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# プロンプトのカラー表示を有効
autoload -U colors
colors

# デフォルトの補完機能を有効
autoload -U compinit
compinit

# 補完候補を詰めて表示
setopt list_packed

# 補完候補表示時にbeepを鳴らさない
setopt nolistbeep

# 補完侯補をEmacsのキーバインドで動き回る
zstyle ':completion:*:default' menu select=1

# 補完の時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 先方予測
#autoload predict-on
#predict-on

setopt hist_ignore_dups # ignore duplication command history
setopt share_history # share command history data

zstyle :compinstall filename '~/.zshrc'

# リダイレクトで上書きする事を許可しない。
setopt no_clobber

# ベルを鳴らさない。
setopt no_beep

# ^Dでログアウトしないようにする。
setopt ignore_eof

# ^Iで補完可能な一覧を表示する。(曖昧補完)
setopt auto_list

# <C-u> <C-d> で履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
#bindkey "^U" history-beginning-search-backward-end
#bindkey "^D" history-beginning-search-forward-end 
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 

# cdでpushdする。
setopt auto_pushd

# pushdで同じディレクトリを重複してpushしない。
setopt pushd_ignore_dups

# globを拡張する。
setopt extended_glob

# 補完時にスペルチェックをする。
#setopt auto_correct

# リターンを押す度にスペルチェックをする。
#setopt correct
#setopt correct_all

# 補完時にヒストリを自動的に展開する。
setopt hist_expand

# pushd を引数無しで実行した時に pushd ~ とする。
setopt pushd_to_home

# ディレクトリ名だけで移動できる。
setopt auto_cd

# rm * を実行する前に確認される。
#setopt rmstar_wait

# カレントディレクトリ中にサブディレクトリが
# 見付からなかった場合に cd が検索する
# ディレクトリのリスト
cdpath=($HOME)

# ログインとログアウトを監視する。
#watch=(all all)
# 全部監視
watch="all"
# 10分おき(デフォルトは1分おき)
#LOGCHECK="$[10 * 60]"
# 取りあえず表示してみる
log

# 10分後に自動的にログアウトする。
#setopt autologout=10

# 10分おきにメールをチェックする。
#setopt mail 600 /var/spool/mail/$USER
#setopt mail 600 $MAIL
# メールをチェックする。
#setopt mail $MAIL

# バックグラウンドジョブが終了したらすぐに知らせる。
setopt no_tify

# 履歴ファイルに時刻を記録
setopt extended_history

# 履歴をインクリメンタルに追加
setopt inc_append_history

# 履歴の共有
setopt share_history

# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
# setopt hist_ignore_all_dups

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space

# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify

# coreのサイズ
# limit coredumpsize 0

# environment variables
# export LANG="ja_JP.UTF-8"

# set alias
alias ls="ls -hAF --show-control-chars --color=auto"
alias la="ls -lhAF --show-control-chars --color=auto"
alias ll="ls -lhAF --show-control-chars --color=auto | less"
alias rm="rm -i"
#alias cp="cp -i"
alias mv="mv -i"
alias grep="grep --color=always"
alias agrep="ack-grep"

alias pd="pushd"
alias po="popd"

# Auto-launch Screen
#if [ $SHLVL = 1 ]; then
#	screen
#fi

# Settings for Screen
if [ "$TERM" = "screen" ]; then
	chpwd () { echo -n "_`dirs`\\" }
	preexec() {
		# see [zsh-workers:13180]
		# http://www.zsh.org/mla/workers/2000/msg03993.html
		# http://nijino.homelinux.net/diary/200206.shtml#200206140
		emulate -L zsh
		local -a cmd; cmd=(${(z)2})
		case $cmd[1] in
			fg)
				if (( $#cmd == 1 )); then
					cmd=(builtin jobs -l %+)
				else
					cmd=(builtin jobs -l $cmd[2])
				fi
				;;
			%*)
				cmd=(builtin jobs -l $cmd[1])
				;;
#			cd)
#				if (( $#cmd == 2)); then
#					cmd[1]=$cmd[2]
#				fi
#				;&
			*)
				echo -n "k$cmd[1]:t\\"
				return
				;;
		esac

		local -A jt; jt=(${(kv)jobtexts})

		$cmd >>(read num rest
			cmd=(${(z)${(e):-\$jt$num}})
			echo -n "k$cmd[1]:t\\") 2>/dev/null
	}
	chpwd
fi

WORDCHARS="${WORDCHARS:s#/#}"

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

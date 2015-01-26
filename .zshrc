alias dpl="cd /tmp/gpdpl"
alias d="git diff"
alias t="tig"
alias ts="tig status"
alias dc="git diff --cached"
alias m="git commit -m"
alias s="git status -s -u -b"
alias c="git checkout"
alias a="git add --all"
alias r="git reset"
alias where="command -v"
alias j="jobs -l"

alias gcm="git commit -m"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias gs=$HOME/bin/gs
alias gl="git log --stat"
alias av="git branch -a -v "
alias gsl="git stash list"
alias gai="git add -i"
alias gap="git add -p"
alias gco="git checkout"
alias garzip="git archive --format=zip HEAD -o /tmp/gitarchived.zip"

alias vr="vim ~/.vimrc"
alias br="vim ~/.bashrc"
alias zr="vim ~/.zshrc"

alias svr="source ~/.vimrc"
alias sbr="source ~/.bashrc"
alias szr="source ~/.zshrc"

# LANG
export LANG=ja_JP.UTF-8
 
# KEYBIND
bindkey -v
 
# PROMPT
PROMPT="$ "
PROMPT2="> "
SPROMPT="%r is correct? [n,y,a,e]: "
RPROMPT='[`rprompt-git-current-branch`%F{cyan}%~%f]'
RPROMPT2="%K{green}%_%k"
# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
## 入力が右端まで来たらRPROMPTを消す
setopt transient_rprompt
 
## ${fg[...]} や $reset_color をロード
autoload -U colors; colors
 
function rprompt-git-current-branch {
local name st color
 
if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
return
fi
name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
if [[ -z $name ]]; then
return
fi
st=`git status 2> /dev/null`
if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
color=${fg[green]}
elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
color=${fg[yellow]}
elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
color=${fg_bold[red]}
else
color=${fg[red]}
fi
 
echo "%{$color%}$name%{$reset_color%} "
}
 
# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
## history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store
## すぐにヒストリファイルに追記する。
setopt inc_append_history
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## ヒストリを共有
setopt share_history
## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
 
# 補完
autoload -Uz compinit
compinit
## The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
## 補完候補を一覧表示
setopt auto_list
## TAB で順に補完候補を切り替える
setopt auto_menu
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## 補完候補の色づけ
eval `dircolors`
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## 補完候補を詰めて表示
setopt list_packed
## スペルチェック
setopt correct
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash
 
# 未分類
## コアダンプサイズを制限
limit coredumpsize 102400
## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
## ビープを鳴らさない
setopt nobeep
## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs
## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
## cd 時に自動で push
setopt auto_pushd
## 同じディレクトリを pushd しない
setopt pushd_ignore_dups
## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob
## =command を command のパス名に展開する
setopt equals
## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst
## ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort
## 出力時8ビットを通す
setopt print_eight_bit
## ディレクトリ名だけで cd
setopt auto_cd
## {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
#setopt NO_flow_control
## コマンドラインでも # 以降をコメントと見なす
#setopt interactive_comments
 
# PAGER
if type lv > /dev/null 2>&1; then
## lvを優先する。
export PAGER="lv"
else
## lvがなかったらlessを使う。
export PAGER="less"
fi
 
if [ "$PAGER" = "lv" ]; then
## -c: ANSIエスケープシーケンスの色付けなどを有効にする。
## -l: 1行が長くと折り返されていても1行として扱う。
## （コピーしたときに余計な改行を入れない。）
export LV="-c -l"
else
## lvがなくてもlvでページャーを起動する。
alias lv="$PAGER"
fi
 
# global aliases
alias -g T="| tee"
alias -g G="| grep"
alias -g L="|& $PAGER"
alias -g WC="| wc"
alias -g LC="| wc -l"
alias -g Z="| tail"
 
# 以下は.bashrcと共用
 
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
 
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
fi
 
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -alh --color'
alias vi='vim'
alias vim='vim'
 
 
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
 
# retter settings
export EDITOR=vim
export RETTER_HOME=`pwd`/my_letter
 
########################################
# OS 別の設定
case ${OSTYPE} in
darwin*)
#Mac用の設定
export CLICOLOR=1
alias ls='ls -G -F'
;;
linux*)
#Linux用の設定
;;
esac
 
export GREP_OPTIONS='--binary-files=without-match'

function ptvim () {
  vim $(pt $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
 }

function peco-select-history() {
local tac
if which tac > /dev/null; then
tac="tac"
else
tac="tail -r"
fi
BUFFER=$(history -n 1 | \
eval $tac | \
peco --query "$LBUFFER")
CURSOR=$#BUFFER
zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-cd () {
local selected_dir=$(find ~/ -type d | peco)
if [ -n "$selected_dir" ]; then
BUFFER="cd ${selected_dir}"
zle accept-line
fi
zle clear-screen
}
zle -N peco-cd
bindkey '^x^f' peco-cd

typeset -ga precmd_functions
typeset -ga preexec_functions
if [[ $ZSH_VERSION == (<5->|4.<4->|4.3.<10->)* ]]; then
  source ~/.zsh/term.zshrc
fi

bblue=$'\e[1;104m'
boldGreen=$'\e[1;32m'
bBoldGreen=$'\e[1;42m'
bBlackGreen=$'\e[7;49;32m'
boldRed=$'\e[1;31m'
bBoldRed=$'\e[31;41m'
bBlackRed=$'\e[7;49;91m'
normalGreen=$'\e[30m'
cyan=$'\e[36m'
bcyan=$'\e[46m'
byellow=$'\e[43m'
red=$'\e[31m'
green=$'\e[32m'
default=$'\e[m'


source ~/.bash_profile
source ~/.bashrc

if [ -f ~/dotfiles/.aliases ]; then
source ~/dotfiles/.aliases
fi
if [ -f ~/.dotfiles/.zshrc.local ]; then
source ~/.dotfiles/.zshrc.local
fi
if [ -f ~/.dotfiles/.bashrc.local ]; then
source ~/.dotfiles/.bashrc.local
fi


# LANG
export LANG=ja_JP.UTF-8

## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
  PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
  PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
*)
  PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
  PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
  SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
    PROMPT="%{${fg[white]}%}${HOST%%.*} ${PROMPT}"
  ;;
esac
 
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
 
## PAGER
#if type lv > /dev/null 2>&1; then
### lvを優先する。
#export PAGER="lv"
#else
### lvがなかったらlessを使う。
#export PAGER="less"
#fi
# 
#if [ "$PAGER" = "lv" ]; then
### -c: ANSIエスケープシーケンスの色付けなどを有効にする。
### -l: 1行が長くと折り返されていても1行として扱う。
### （コピーしたときに余計な改行を入れない。）
#export LV="-c -l"
#else
### lvがなくてもlvでページャーを起動する。
#alias lv="$PAGER"
#fi
 
 
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
 
#
# expand aliases before completing
#
setopt complete_aliases # aliased ls needs if file/dir completions work
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
## terminal configuration
unset LSCOLORS
case "${TERM}" in
xterm)
  export TERM=xterm-color
  ;;
kterm)
  export TERM=kterm-color
  # set BackSpace control character
  stty erase
  ;;
cons25)
  unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
  precmd() {
    echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
  }
  export LSCOLORS=exfxcxdxbxegedabagacad
  export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
  ;;
esac
 
 
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

function agvim () {
vim $( ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1 }')
}
function ptvim () {
vim $( pt $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1 }')
}

#function peco-select-history() {
#local tac
#if which tac > /dev/null; then
#tac="tac"
#else
#tac="tail -r"
#fi
#BUFFER=$(history -n 1 | \
#eval $tac | \
#peco --query "$LBUFFER")
#CURSOR=$#BUFFER
#zle clear-screen
#}
#zle -N peco-select-history
#bindkey '^r' peco-select-history


function peco-select-history(){
BUFFER=$(\history 1 | \
	sort -r -k 2 | \
	uniq -1 | \
	sort -r | \
	awk '$1=$1' | \
	cut -d" " -f 2- | \
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

peco-lscd(){
    local dir="$( ls -1d */ | peco )"
    if [ ! -z "$dir" ] ; then
	    cd "$dir"
    fi
}
alias C=peco-lscd



export GREP_OPTIONS='--binary-files=without-match'

function set_target_branch(){
	if [ $# -lt 1 ] ; then
		echo "no argument error"
	else
		_set_zshrc_variable targetbranch ${1}
		show_set_branch
	fi
}
function set_now_branch(){
	if [ $# -lt 1 ] ; then
		echo "no argument error"
	else
		_set_zshrc_variable nowbranch ${1}
		show_set_branch
	fi
}

function _set_zshrc_variable(){
	if [ $# -lt 2 ] ; then
		echo "argument error"
	else
		sed -i -E "s/^${1}=.*$/${1}=\"${2}\"/" ${HOME}/.dotfiles/.zshrc.local
		szr
		echo "${1} set to >>> ${2}" ;
	fi
}

function wget_ticket(){
rnd=`ruby -e 'puts Time.now.to_f' | md5`
echo ${rnd} ;
}


alias adbinstall="adb install -r"
diffbranch(){
	git diff ${1}..${2} --stat
}

alias -g N="${nowbranch}"
alias -g T="${targetbranch}"
function show_set_branch(){

nowBranchTitle=`get_ticket_title_from_branch ${nowbranch}`
targetBranchTitle=`get_ticket_title_from_branch ${targetbranch}`

echo "
#########################
now    => ${nowbranch} :: ${nowBranchTitle}
target => ${targetbranch} :: ${targetBranchTitle}
#########################
"
}
function get_ticket_title_from_branch(){
	if [ $# -lt 1 ] ; then
		echo "no argument error"
	else
		ticketNumber=`get_ticket_number ${1}`;
		echo `get_ticket_title $ticketNumber`;
	fi
}



function get_ticket_number(){
	if [ $# -lt 1 ] ; then
		echo "no argument error"
	else
		echo $1 | rev | cut -d"_" -f1 | rev
	fi
}
function get_ticket_title(){
	if [ $# -lt 1 ] ; then
		echo "no argument error"
	else
		ruby ${HOME}/bin/ticket_title.rb ${1}
	fi
}
# now branch usage put this in .zshrc.local
#########################
#nowbranch="feature_30610"
#targetbranch="ver_30277"
#########################




function bundleUpdate(){
  vim +NeoBundleUpdate +qall
}
function bundleInstallForce(){
  vim +NeoBundleInstall +qall
}
function bundleInstall(){
#TODO need to get option correctly here
if [ $# -eq 1 ] && [ "${1}" == "-f" ] ; then
  vim +PluginInstall! +qall
else
  vim +NeoBundleInstall +qall
fi

}
alias vimprocMake="cd ${HOME}/dotfiles/.vim/bundle/vimproc/;make;cd ~-";

function check(){
if [ $# -lt 1 ]; then
  echoNoArgument
else
  checkme=$1
  echo "
${green}whereis : $checkme${default}"
  whereis $checkme
  echo "
${green}which : $checkme${default}"
  which $checkme
fi
}
echoNoArgument(){
		echo "${red}empty argument${default}" ;
}
function exitIfNoArgument(){
	if [ $# -lt 1 ]; then
    echoNoArgument
    return 1
  else
    return 0
	fi
}



# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

alias lbr="vim $HOME/.dotfiles/.bashrc.local"
alias lvr="vim $HOME/.dotfiles/.bashrc.local"
alias dbr="vim $HOME/dotfiles/.bashrc"
alias dvr="vim $HOME/dotfiles/.vimrc"

alias vdupdate="vim $HOME/dotfiles/bin/dots_update.sh"
alias vdinit="vim $HOME/dotfiles/bin/dots_init.sh"

alias dotfiles_update="sh $HOME/dotfiles/bin/dots_update.sh"
alias dotfiles_init="sh $HOME/dotfiles/bin/dots_init.sh"

alias cdot="cd $HOME/dotfiles"

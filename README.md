```
sudo yum -y install git zsh vim ctags screen wget gcc;git config --global color.ui auto ;cd ;git clone git@github.com:rw-nue/dotfiles.git; sh ~/dotfiles/bin/dots_init.sh; zsh;ln -sf ~/dotfiles/.screenrc~/ .screenrc ; chsh -s /bin/zsh;mkdir -p ~/local/bin;ln -sf /usr/bin/vim ~/local/bin/vim;

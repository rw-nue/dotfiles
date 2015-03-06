#!/bin/bash


# submodules
dotfiles="$HOME/dotfiles"
cd $dotfiles
git submodule add -f https://github.com/Shougo/neobundle.vim .vim/bundle/neobundle.vim
git submodule update --init

# Vundle install
vim +NeoBundleUpdate +qall

#!/bin/bash


# submodules
dotfiles="$HOME/dotfiles"
cd $dotfiles
git submodule add -f https://github.com/gmarik/Vundle.vim.git .vim/bundle/Vundle.vim
git submodule update --init

# Vundle install
vim +PluginInstall! +qall

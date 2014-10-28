#!/bin/bash

# settings 
gitUserName="rw-nue";
gitUserEmail="$gitUserName@users.noreply.github.com"
DOT_FILES=( .vimrc .bashrc)
DOT_DIRS=( .vim)

# git config for dotfile directory
cd $HOME/dotfiles
echo "git config user.name $gitUserName"
git config user.name $gitUserName
echo "git config user.email $gitUserEmail"
git config user.email $gitUserEmail


#inits for script
dotfiles="$HOME/dotfiles"
dotdotfiles="$HOME/.dotfiles"
chmod +x "$dotfiles/update.sh"


if [ ! -d "$dotdotfiles" ]; then
		mkdir $dotdotfiles ;
fi

for file in ${DOT_FILES[@]}
do
		homeFile=$HOME/$file
		dotFile=$dotfiles/$file
		localFile=$dotdotfiles/${file}.local
		originalFile=$dotdotfiles/${file}.original
		mixedFile=$dotdotfiles/${file}


		if [ -a "$homeFile" ]; then
				if [ -a "$dotFile" ]; then
						if [ -L "$homeFile" ]; then
								echo "has link already" ;
						else
								cp $homeFile $originalFile
								mv $homeFile $localFile
								cp $dotFile $mixedFile
								cat $localFile >> $mixedFile
								ln -s $mixedFile $homeFile
						fi
				else
						echo "dot file doesnt exist" ;
				fi
		else
				echo "$file doesnt exist" ;
		fi
done
for file in ${DOT_DIRS[@]}
do
		homeFile=$HOME/$file
		dotFile=$dotfiles/$file
		originalFile=$dotdotfiles/${file}.original
		if [ ! -d "$dotFile" ]; then
				echo "$dotFile doesnt exist"
		elif [ -d "$homeFile" -a -L "$homeFile" ]; then
				echo "has link already $homeFile" ;
		else
				echo "$originalFile backup "
				mv $homeFile $originalFile
				echo "ln -s $dotFile $homeFile"
				ln -s $dotFile $homeFile
		fi
done


# submodules
git submodule update --init

# Vundle install
vim +PluginInstall! +qall

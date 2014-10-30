#!/bin/bash

#inits for script
dotfiles="$HOME/dotfiles"
dotdotfiles="$HOME/.dotfiles"
chmod +x "$dotfiles/bin/update.sh"

# settings 
gitUserName="rw-nue";
gitUserEmail="$gitUserName@users.noreply.github.com"
gitInitTemplateDir="$dotfiles/.git_template"

DOT_FILES=( .vimrc .bashrc)
DOT_DIRS=( .vim)

# git config for dotfile directory
cd $HOME/dotfiles
echo "git config user.name $gitUserName"
git config user.name $gitUserName
echo "git config user.email $gitUserEmail"
git config user.email $gitUserEmail

echo "git config init.templatedir $gitInitTemplateDir"
git config init.templatedir $gitInitTemplateDir




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
cd $dotfiles
git submodule add -f https://github.com/gmarik/Vundle.vim.git .vim/bundle/Vundle.vim
git submodule update --init

# Vundle install
vim +PluginInstall! +qall

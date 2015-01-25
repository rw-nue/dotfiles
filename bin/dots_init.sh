#!/bin/bash

#inits for script
dotfiles="$HOME/dotfiles"
dotdotfiles="$HOME/.dotfiles"

if [ ! -d "$dotdotfiles" ]; then
		mkdir $dotdotfiles ;
else
		echo "exit ... "
		echo "$dotdotfiles exists cannot setup dotfiles";
		exit 0;
fi

chmod +x "$dotfiles/bin/dots_update.sh"
chmod +x "$dotfiles/bin/dots_vundle_update.sh"

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





for file in ${DOT_FILES[@]}
do
		homeFile=$HOME/$file
		dotFile=$dotfiles/$file
		localFile=$dotdotfiles/${file}.local
		originalFile=$dotdotfiles/${file}.original
		mixedFile=$dotdotfiles/${file}

		echo "checking initializing file $homeFile ..."

		if [ -a "$homeFile" ]; then
				if [ -a "$dotFile" ]; then
						if [ -L "$homeFile" ]; then
								echo "pass this file ..." ;
								echo "$homeFile is already a symbolic link" ;
						else
								echo "executing initializing $homeFile ..."
								cp $homeFile $originalFile
								mv $homeFile $localFile
								cp $dotFile $mixedFile
								cat $localFile >> $mixedFile
								ln -s $mixedFile $homeFile
						fi
				else
						echo "pass this file ..." ;
						echo "$dotFile doesnt exist" ;
				fi
		else
				echo "pass this file ..." ;
				echo "$homeFile doesnt exist" ;
		fi
done
for file in ${DOT_DIRS[@]}
do
		homeFile=$HOME/$file
		dotFile=$dotfiles/$file
		originalFile=$dotdotfiles/${file}.original

		echo "checking initializing directory $homeFile ..."
		if [ ! -d "$dotFile" ]; then
				echo "pass this directory ..." ;
				echo "$dotFile doesnt exist"
		elif [ -d "$homeFile" -a -L "$homeFile" ]; then
				echo "pass this directory ..." ;
				echo "has link already $homeFile" ;
		else

		echo "executing initializing directory $homeFile ..."
				mv $homeFile $originalFile
				ln -s $dotFile $homeFile
		fi
done

sh $dotfiles/bin/dots_vundle_update.sh


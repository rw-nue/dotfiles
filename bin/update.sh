#!/bin/bash 

DOT_FILES=( .vimrc .bashrc)
#inits for script
dotfiles="$HOME/dotfiles"
dotdotfiles="$HOME/.dotfiles"


if [ ! -d "$dotdotfiles" ]; then
		echo "$dotdotfiles has not created , please init first" ;
else

		for file in ${DOT_FILES[@]}
		do
				homeFile=$HOME/$file
				dotFile=$dotfiles/$file
				localFile=$dotdotfiles/${file}.local
				originalFile=$dotdotfiles/${file}.original
				mixedFile=$dotdotfiles/${file}

				if [ ! -L "$homeFile" ]; then
						echo "$homeFile is not Symbolic Link , please init first";
				else
						if [ ! -a "$dotFile" ]; then
								echo "$dotFile doesnt exist" ;
						else
								cp $dotFile $mixedFile
								if [ -a "$localFile" ]; then
										cat $localFile >> $mixedFile
								fi
								ln -s $mixedFile $homeFile
						fi
				fi
		done

		# submodules
		git submodule update --init

		# Vundle install
		vim +PluginInstall! +qall
fi

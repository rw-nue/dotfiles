#!/bin/bash 

DOT_FILES=( .vimrc .bashrc)
#inits for script
dotfiles="$HOME/dotfiles"
dotdotfiles="$HOME/.dotfiles"

echo "checking updating dotfiles ..."

if [ ! -d "$dotdotfiles" ]; then
		echo "$dotdotfiles has not created , please init first" ;
		exit 0 ;
fi

for file in ${DOT_FILES[@]}
do
		homeFile=$HOME/$file
		dotFile=$dotfiles/$file
		localFile=$dotdotfiles/${file}.local
		originalFile=$dotdotfiles/${file}.original
		mixedFile=$dotdotfiles/${file}

		echo "checking updating $homeFile ...";

		if [ ! -L "$homeFile" -o ! -f "$dotFile" ]; then
				echo "$homeFile is not Symbolic Link nor $dotFile exits";
				echo "passing this file ...";
		else
				echo "executing updating $homeFile ...";
				cp $dotFile $mixedFile
				if [ -f "$localFile" ]; then
						comment="###### LOCAL FILE BELOW ######";
						comment2="# update ${localFile} and ${dotfiles}/bin/dot_update.sh to edit here#";
						if [ "$file" == ".vimrc" ]; then
								comment="\"${comment}";
								comment2="\"${comment2}";
						fi
						echo $comment >> $mixedFile;
						echo $comment2 >> $mixedFile;
						cat $localFile >> $mixedFile
				fi
		fi
done

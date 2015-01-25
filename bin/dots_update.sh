#!/bin/bash 
. $HOME/dotfiles/bin/includes/variables

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
						firstLine="###### LOCAL FILE BELOW ######";
						secondLine="# update ${localFile} and ${dotfiles}/bin/dot_update.sh to edit here#";
						if [ "$file" == ".vimrc" ]; then
								#adding comment out
								firstLine="\"${firstLine}";
								secondLine="\"${secondLine}";
						fi
						echo "
						" >> $mixedFile;
						echo $firstLine >> $mixedFile;
						echo $secondLine >> $mixedFile;
						cat $localFile >> $mixedFile;
				fi
		fi
done

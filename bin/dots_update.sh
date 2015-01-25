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

		echo "[ ${file} ]";
		echo "checking updating $homeFile ...";

		# create if none 
		if [ ! -e "$homeFile" ]; then
				echo "${homeFile} does not exist , creating blank ..."
				touch $homeFile ;
		fi

		if [ ! -e "$dotFile" ]; then
				echo "$dotFile does not exist";
				echo "passing this file ...";
				continue
		elif [ ! -L "$homeFile" ]; then
				# file exists but not a link ... so may be can init here 
				echo "$homeFile is not Symbolic Link nor $dotFile exists";
				echo "passing this file ...";
				continue
		else
				echo "execute updating $homeFile ...";
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

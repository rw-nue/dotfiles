#!/bin/bash 
. $HOME/dotfiles/bin/includes/variables

if [ ${#} == 1 ] && [ ${1} == "--force" ] ;then
		FORCED_FLG="TRUE"
fi

echo "checking updating dotfiles ..."

if [ ! -e "$dotdotfiles" -o ! -d "$dotdotfiles" ]; then
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

		# create if none and if forced init
		if [ "${FORCED_FLG}" == "TRUE" -a ! -e "$homeFile" ]; then
				echo "${homeFile} does not exist , creating blank ..."
				touch $homeFile ;
		fi

		if [ ! -e "$homeFile" ]; then
				echo "$homeFile does not exist";
				echo "<<< passing this file ...";
				continue
		elif [ ! -e "$dotFile" ]; then
				echo "$dotFile does not exist";
				echo "<<< passing this file ...";
				continue
		elif [  ! -L "$homeFile" ]; then
				echo "$homeFile is not Symbolic Link";

				# file exists but not a link ... so may be can init here 

				if [ "${FORCED_FLG}" == "TRUE" ]; then
						echo "initializing ${file} since forced";
						echo ">>> executing initializing $homeFile ..."
						cp $homeFile $originalFile
						mv $homeFile $localFile
						cp $dotFile $mixedFile
						ln -s $mixedFile $homeFile
				else
				echo "<<< passing this file ...";
				echo "... you can add --force option to init this file";
				fi

				continue
		else
				echo ">>> execute updating $homeFile ...";
				cp $dotFile $mixedFile
				if [ -f "$localFile" ]; then
						echo ">>> append $localFile to $mixedFile...";
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

#!/bin/bash
. $HOME/dotfiles/bin/includes/variables

#create $HOME/.dotfiles
if [ ! -d "$dotdotfiles" ]; then
		mkdir $dotdotfiles ;
fi

#create backup dir
backup_dir=$dotdotfiles/backup/`date +%Y_%m_%d_%H_%M_%S`
mkdir -p $backup_dir

exit 0;
chmod +x "$dotfiles/bin/dots_update.sh"
chmod +x "$dotfiles/bin/dots_vundle_update.sh"

# settings 
gitUserName="rw-nue";
gitUserEmail="$gitUserName@users.noreply.github.com"
gitInitTemplateDir="$dotfiles/.git_template"


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
		backup_file=$backup_dir/$file
		dotFile=$dotfiles/$file
		localFile=$dotdotfiles/${file}.local

		echo "checking initializing file $homeFile ..."

		if [ -e "$homeFile" ]; then
				echo "$homeFile exist , create backup $homeFile" ;
                cp -prf $homeFile $backup_file
		fi
		if [ ! -e "$dotFile" ]; then
				echo "pass this file ..." ;
				echo "$dotFile doesnt exist" ;
		elif [ -f "$homeFile" -a -L "$homeFile" ]; then
				echo "pass this file ..." ;
				echo "$homeFile is already a symbolic link" ;
		else
				echo "executing initializing $homeFile ..."
				cp $homeFile $originalFile
				mv $homeFile $localFile
				cp $dotFile $mixedFile
				ln -s $mixedFile $homeFile
		fi
done
for file in ${DOT_DIRS[@]}
do
		homeFile=$HOME/$file
		dotFile=$dotfiles/$file
		originalFile=$dotdotfiles/${file}.original

		echo "checking initializing directory $homeFile ..."
		if [ ! -e "$homeFile" ]; then
				echo "$homeFile doesnt exist , create blank $homeFile" ;
				mkdir -p $homeFile ;
		fi

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

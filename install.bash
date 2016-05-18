#!/bin/sh

bashVersionAtLeast4=$(bash --version | grep 'version 4' | wc -l)
if [ $bashVersionAtLeast4 -ne 1 ];
then
	echo 'Bash version should be at least 4.0'
	exit
fi

alreadyInstalled=$(cat ~/.bashrc | grep -c '__init.bash')

if [ $alreadyInstalled -eq 0 ];
then 
	echo 'Adding __init.bash to .bashrc'
	initFilePath="source $(dirname "${BASH_SOURCE[0]}")/__init.bash"  
	echo >> ~/.bashrc
	echo $initFilePath >> ~/.bashrc
else 
	echo 'Already installed.'
fi



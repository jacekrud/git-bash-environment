#!/bin/sh


alreadyInstalled=$(cat ~/.bashrc | grep -c '__init.bash')

if [ $alreadyInstalled -eq 0 ];
then 
	echo 'Adding __init.bash to .bashrc'
	initFilePath="source $(dirname "${BASH_SOURCE[0]}")/__init.bash"  
	echo $initFilePath >> ~/.bashrc
else 
	echo 'Already installed.'
fi



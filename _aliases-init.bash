#!/bin/sh

echo 'Add g as git alias'
alias g='git'
complete -o default -o nospace -F _git g

if [[ -e /c/Program\ Files\ \(x86\)/Notepad++/notepad++.exe ]]
then	
	alias notepad2='/c/Program\ Files\ \(x86\)/Notepad++/notepad++.exe -multiInst -notabbar -nosession -noPlugin'
	echo 'Notepad++ alias registered'
fi

echo 'Include aliases from aliases.gitconfig'
aliasesFilePath="$(dirname "${BASH_SOURCE[0]}")/aliases.gitconfig"
git config --global include.path $aliasesFilePath

echo 'Register aliases autocompletions functions'
_git_not_merged_list () 
{
    _git_branch
}
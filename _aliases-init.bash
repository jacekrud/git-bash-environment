#!/bin/sh
LANG=en_US.UTF-8
LC_CTYPE=en_US.utf8

echo 'Add g as git alias'
alias g='git'
complete -o default -o nospace -F __git_wrap__git_main g

echo 'Add notepad alias'
if [[ -e /c/Program\ Files\ \(x86\)/Notepad++/notepad++.exe ]]
then	
	alias notepad='/c/Program\ Files\ \(x86\)/Notepad++/notepad++.exe -multiInst -notabbar -nosession -noPlugin'
fi

echo 'Include aliases from aliases.gitconfig'
aliasesFilePath="$(dirname "${BASH_SOURCE[0]}")/aliases.gitconfig"
git config --global include.path $aliasesFilePath

echo 'Register aliases autocompletions functions'
_git_not_merged_list() 
{
    _git_branch
}


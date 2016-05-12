#!/bin/sh

echo 'Add g as git alias'
alias g='git'
complete -o default -o nospace -F _git g

echo 'Include aliases from aliases.gitconfig'
aliasesFilePath="$(dirname "${BASH_SOURCE[0]}")/aliases.gitconfig"
git config --global include.path $aliasesFilePath

echo 'Register aliases autocompletions functions'
_git_not_merged_list () 
{
    _git_branch
}
#!/bin/sh

echo 'Initializing custom prompt'

COLOR_RED="\033[0;31m"
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[1;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

function git_colored_status {
  local shortStatus="$(git status -bs 2>/dev/null)"
  if [[ $RETVAL -ne 0 ]]
  then
	return;
  fi
  
  local aheadCount=$(grep -Po 'ahead\s\K\d+(?=[^\d])' <<< $shortStatus)
  local aheadCount=$([ -z $aheadCount ] && echo 0 || echo $aheadCount)
  local ahead=$([ $aheadCount -gt 0 ] && echo "$aheadCount↑" || echo "")
  local behindCount=$(grep -Po 'behind\s\K\d+(?=[^\d])' <<< $shortStatus)
  local behindCount=$([ -z $behindCount ] && echo 0 || echo $behindCount)
  local behind=$([ $behindCount -gt 0 ] && echo "$behindCount↓" || echo "")
  local count=$(echo "$shortStatus" | wc -l)
  local color=$([ $count -gt 1 ] && echo "$COLOR_RED" || echo "$COLOR_GREEN")
   
  local branch=$(__git_ps1)
   
  echo -e $color$branch $COLOR_RESET$behind $ahead
}

export PS1="\[\033[1;40;30m[\t]\[\033[0m\] \[$COLOR_YELLOW\]\\w\$(git_colored_status) $(echo -e "\n$") "
export PROMPT_COMMAND='history -a'
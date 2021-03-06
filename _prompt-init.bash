#!/bin/sh
LANG=en_US.UTF-8
LC_CTYPE=en_US.utf8
export LC_ALL=en_GB.UTF-8

echo 'Initializing custom prompt'


COLOR_RED="\e[0;31m"
COLOR_RED="\e[0;31m"
COLOR_YELLOW="\e[1;33m"
COLOR_GREEN="\e[0;32m"
COLOR_OCHRE="\e[38;5;95m"
COLOR_BLUE="\e[0;34m"
COLOR_WHITE="\e[0;37m"
COLOR_RESET="\e[0m"
COLOR_DARKGREY="\e[1;30m"
COLOR_DARKGREEN="\e[2;32m"

function countFilesStatuses {
	sAdded=0
	sModified=0
	sRenamed=0
	sDeleted=0
	uModified=0
	uDeleted=0
	u=0
	unkown=0
			
	IFS=''
	while read -r line; do
		case "${line}" in
		"D ") sDeleted=$((sDeleted+1));;
		"R ") sRenamed=$((sRenamed+1));;
		"M ") sModified=$((sModified+1));;
		"A ") sAdded=$((sAdded+1));;
		"??") u=$((u+1));;
		" D") uDeleted=$((uDeleted+1));;
		"RD") uDeleted=$((uDeleted+1));;
		" M") uModified=$((uModified+1));;
		"AM") 
			sAdded=$((sAdded+1));
			uModified=$((uModified+1));;
		"MM") 
			sModified=$((sModified+1));
			uModified=$((uModified+1));;
		"AD") 
			sAdded=$((sAdded+1));
			uDeleted=$((uDeleted+1));;
		*) unkown=$((unkown+1));;
		esac
	done <<< "$(echo "${1}" | cut -c -2 | sed 1d)";
	
	sDeleted=$([ $sDeleted -gt 0 ] && echo "$sDeleted✘ " || echo "")
	sRenamed=$([ $sRenamed -gt 0 ] && echo "$sRenamed➚ " || echo "")
	sModified=$([ $sModified -gt 0 ] && echo "$sModified✎ " || echo "")
	sAdded=$([ $sAdded -gt 0 ] && echo "$sAdded✚ " || echo "")
	u=$([ $u -gt 0 ] && echo "$u✚ " || echo "")
	uModified=$([ $uModified -gt 0 ] && echo "$uModified✎ " || echo "")
	uDeleted=$([ $uDeleted -gt 0 ] && echo "$uDeleted✘ " || echo "")
	unkown=$([ $unkown -gt 1 ] && echo "$unkown " || echo "")
	
	local staged="$sAdded$sDeleted$sModified$sRenamed"
	local unStaged="$u$uModified$uDeleted"
	
	staged=$([ ! -z $staged  ] && echo "[ $staged] " || echo "")
	unStaged=$([ ! -z $unStaged  ] && echo "[ $unStaged]" || echo "")
	unknown=$([ ! -z $unkown  ] && echo " $unkown?!" || echo "")
	
	echo -e "$COLOR_DARKGREEN$staged$COLOR_DARKGREY$unStaged$COLOR_RESET$unknown"
}

function git_colored_status {
  local shortStatus="$(git status -bs -u 2>/dev/null)"
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
  local fileStatuses=$(countFilesStatuses "${shortStatus}")
   
  echo -e $color$branch $COLOR_RESET$behind $ahead\\t\\t\\t$fileStatuses
  
}

export PS1="\r\n\[\033[1;40;30m[\t]$COLOR_RESET $COLOR_YELLOW\\w\$(git_colored_status) $(echo -e "\n$") "
export PROMPT_COMMAND='history -a'
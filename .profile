#!/bin/bash
machine=$(uname -s)
if [[ $machine == "Linux" ]]; then 
  home=/home/tshmak
  color="--color=auto"
  source $home/.bashrc
elif [[ $machine == "Darwin" ]]; then 
  home=/Users/tshmak
  export CLICOLOR=1
else 
  echo "I don't know what home is for this machine" 
fi

source $home/scripts/git-prompt.sh
if [ "$defaultPATH" == "" ]; then
	export defaultPATH=$PATH
#	echo $defaultPATH
fi
export PATH="$defaultPATH:$home/scripts/"
export PS1='\[\e[1;32m\][$(__git_ps1)\h \w]\n\$ \[\e[0m\]'

alias ll='ls $color -Flha'
alias diff=colordiff

if [ "$_chdir" != "" ]; then 
  cd $_chdir # This variable is used when calling qsub in interactive mode in my script for switching to current directory 
  export _chdir=""
fi 


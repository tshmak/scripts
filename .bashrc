#!/bin/bash
machine=$(uname -s)
if [[ $machine == "Linux" ]]; then 
  home=/home/tshmak
  color="--color=auto"
  conda_path=$home/miniconda3
elif [[ $machine == "Darwin" ]]; then 
  home=/Users/tshmak
  conda_path=$home/anaconda3
  export CLICOLOR=1
else 
  echo "I don't know what home is for this machine" 
fi
#### Activate conda ####
. $conda_path/etc/profile.d.conda.sh
CONDA_CHANGEPS1=false conda activate base

# echo $default_PATH

if [ "$default_PATH" == "" ]; then
	export default_PATH=$PATH
#	echo $default_PATH
fi
export PATH="$default_PATH:$home/scripts/"
export PS1='\[\e[1;32m\][$(__git_ps1)\h \w]\n\$ \[\e[0m\]'

# echo $PATH 

source $home/scripts/git-prompt.sh
alias ll='ls $color -Flha'
alias diff=colordiff

if [ "$_chdir" != "" ]; then 
  cd $_chdir # This variable is used when calling qsub in interactive mode in my script for switching to current directory 
  export _chdir=""
fi 

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

echo "Hello!"

export ted=$HOME/WORK/Projects/WFST/kaldi/egs/tedlium/s5_r3
export kaldi=$HOME/WORK/Projects/WFST/kaldi
export WFST=$HOME/WORK/Projects/WFST
export tommyted=/home/tommy/kaldi/egs/tedlium/s5_r3

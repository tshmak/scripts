#!/bin/bash
machine=$(uname -s)
if [[ $machine == "Linux" ]]; then 
  color="--color=auto"
  conda_path=$HOME/miniconda3

  # Set up simlinks to shared drive 
  cd $HOME
  [ ! -d nas2 ] && ln -s /mnt/nas2 nas2
  [ ! -d storage ] && ln -s nas2/tshmak storage
  [ ! -d scripts ] && ln -s storage/scripts scripts
  [ ! -d sandbox ] && ln -s storage/sandbox sandbox
  [ ! -d WORK ] && ln -s storage/WORK WORK
  [ ! -d Downloads ] && ln -s storage/Downloads Downloads
  [ ! -f .gitconfig ] && ln -s scripts/.gitconfig .gitconfig
  [ ! -d DATA ] && ln -s storage/DATA DATA
  [ ! -d local ] && ln -s storage/local local
  cd - 
elif [[ $machine == "Darwin" ]]; then 
  conda_path=$HOME/anaconda3
  export CLICOLOR=1

  # set up simlinks 
  cd $HOME
  [ ! -d local ] && ln -s /usr/local local
  cd - 

else 
  echo "I don't know what home is for this machine" 
fi
#### Activate conda ####
. $conda_path/etc/profile.d/conda.sh  
CONDA_CHANGEPS1=false conda activate base

# echo $default_PATH

if [ "$default_PATH" == "" ]; then
	export default_PATH=$PATH
#	echo $default_PATH
fi
export PATH="$default_PATH:$HOME/scripts/:$HOME/local/bin"
export PS1='\[\e[1;32m\][$(__git_ps1)\h \w]\n\$ \[\e[0m\]'

# echo $PATH 

source $HOME/scripts/git-prompt.sh
alias ll='ls $color -Flha'
alias diff=colordiff

if [ "$_chdir" != "" ]; then 
  cd $_chdir # This variable is used when calling qsub in interactive mode in my script for switching to current directory 
  export _chdir=""
fi 

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# echo "Hello!"

export ted=$HOME/WORK/Projects/WFST/kaldi/egs/tedlium/s5_r3
export kaldi=$HOME/WORK/Projects/WFST/kaldi
export WFST=$HOME/WORK/Projects/WFST
export tommyted=/home/tommy/kaldi/egs/tedlium/s5_r3

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/tshmak/storage/software/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/tshmak/storage/software/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/tshmak/storage/software/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/tshmak/storage/software/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<


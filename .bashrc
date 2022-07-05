#!/bin/bash
machine=$(uname -s)
if [[ $(hostname) =~ ^Fano-HK ]]; then 
  # Fano server 
  color="--color=auto"
  conda_path=$HOME/miniconda3
  START_TMUX=1

elif [[ $(hostname) =~ ^Fano-SZ ]]; then 
  # Fano SZ server 
  color="--color=auto"
  conda_path=$HOME/storage/miniconda3

elif [[ $(hostname) == "timhome" ]]; then 
  # Home Linux
  conda_path=$HOME/miniconda3
  export CLICOLOR=1

elif [[ $(hostname) == "Timothy-Mak.local" ]]; then 
  # Fano Macbookpro
  conda_path=$HOME/anaconda3
  export CLICOLOR=1

else 
  echo "I don't know what home is for this machine" 
fi

if [ "$default_PATH" == "" ]; then
	export default_PATH=$PATH
fi
export PATH="$default_PATH:$HOME/miniconda3/bin:$HOME/scripts/:$HOME/local/gpu2/bin:$HOME/local/gpu1/bin"
export PS1='\[\e[1;32m\][$(__git_ps1)\h \w]\n\$ \[\e[0m\]'
export VISUAL=vim
export EDITOR="$VISUAL"
export HOMEBREW_NO_AUTO_UPDATE=1

# echo $PATH 

source $HOME/scripts/git-prompt.sh
alias ll='ls $color -Flha'
alias ll0='ls $color -Flh'
alias lsU='ls -U'
alias diff=colordiff
alias xc="xclip -r -sel c"
if [[ $(hostname) =~ ^Fano-HK ]]; then 
  # Fano HK server 
  alias vim=/home/tshmak/local/gpu1/bin/vim
  alias vimdiff=/home/tshmak/local/gpu1/bin/vimdiff
fi

if [ "$_chdir" != "" ]; then 
  cd $_chdir # This variable is used when calling qsub in interactive mode in my script for switching to current directory 
  export _chdir=""
fi 

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# echo "Hello!"

#export ted=$HOME/WORK/Projects/WFST/kaldi/egs/tedlium/s5_r3
#export kaldi=$HOME/WORK/Projects/WFST/kaldi
#export WFST=$HOME/WORK/Projects/WFST
#export tommyted=/home/tommy/kaldi/egs/tedlium/s5_r3
export BUP_DIR=/home/tshmak/storage/.bup
if [[ ! $(hostname) =~ server2 ]]; then 
    export CUDA_VISIBLE_DEVICES=1
fi

if [[ $- =~ i ]]
then
    # Better autocomplete: https://mhoffman.github.io/2015/05/21/how-to-navigate-directories-with-the-shell.html
    bind '"\e[A":history-search-backward'
    bind '"\e[B":history-search-forward'
    [ -n "$START_TMUX" ] && tmux
fi

#### Activate conda ####
. $conda_path/etc/profile.d/conda.sh  
conda deactivate
#CONDA_CHANGEPS1=false conda activate base


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

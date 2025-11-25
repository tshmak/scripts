#!/bin/bash
machine=$(uname -s)

if [[ $(hostname) == "LAPTOP-3M6CFHF7" ]]; then 
    # Pantheon Windows WSL 
    conda_path=$HOME/miniforge3
    color="--color=auto"
    export CLICOLOR=1
elif [[ $(hostname) =~ "Timothy" ]]; then 
    # My Macbookpro
    conda_path=$HOME/miniforge3
    export CLICOLOR=1
elif [[ $(hostname) == "sake" ]]; then 
    # Pantheon sake
    conda_path=$HOME/miniforge3
    color="--color=auto"
    export CLICOLOR=1
else 
  echo "I don't know what home is for this machine" 
fi

if [ "$default_PATH" = "" ]; then
	export default_PATH=$PATH
fi

export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$default_PATH:$HOME/miniforge3/bin:$HOME/scripts/:/opt/homebrew/bin"
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
alias copy=osc52

if [ "$_chdir" != "" ]; then 
  cd $_chdir # This variable is used when calling qsub in interactive mode in my script for switching to current directory 
  export _chdir=""
fi 

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export DOTNET_CLI_TELEMETRY_OPTOUT=1 # https://learn.microsoft.com/en-us/dotnet/core/tools/telemetry

# echo "Hello!"

if [[ $- =~ i ]]
then
    # Better autocomplete: https://mhoffman.github.io/2015/05/21/how-to-navigate-directories-with-the-shell.html
    bind '"\e[A":history-search-backward'
    bind '"\e[B":history-search-forward'
    [ "$START_TMUX" = "1" ] && tmux
fi

#### Setting below to mute warnings at Pantheon because I don't have sudo privileges
command_not_found_handle() {
    echo "$1: command not found"
}

#### Activate conda ####
. $conda_path/etc/profile.d/conda.sh      # commented out by conda initialize
#[[ $(hostname) =~ ^HKSTP ]] && . $conda_path/etc/profile.d/mamba.sh    
conda deactivate


## >>> conda initialize >>>
## !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/timothy/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
    #eval "$__conda_setup"
#else
    #if [ -f "/home/timothy/miniforge3/etc/profile.d/conda.sh" ]; then
        #. "/home/timothy/miniforge3/etc/profile.d/conda.sh"
    #else
        #export PATH="/home/timothy/miniforge3/bin:$PATH"
    #fi
#fi
#unset __conda_setup
## <<< conda initialize <<<
#

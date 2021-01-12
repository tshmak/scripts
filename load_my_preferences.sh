#!/bin/bash

_conda_dir=$(ls -d $HOME/*conda3 2>/dev/null) 
if [ "$?" != "0" ] 
then
    echo "conda not found"
    echo "Consider: wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
else
    echo "conda found: $_conda_dir"
    source $_conda_dir/etc/profile.d/conda.sh
fi
echo

_vim_exec=$(which vim)
if [ ! $_vim_exec ] 
then
    echo "vim not installed"
    echo "Consider: sudo apt install vim"
else 
    echo "vim found: $_vim_exec"
    export VISUAL=vim 
    export EDITOR="$VISUAL"
fi
echo

_xclip_exec=$(which xclip)
if [ ! _xclip_exec ] 
then
    echo "xclip not installed"
    echo "Consider: sudo apt-get install -y xclip"
else 
    echo "xclip found: $_xclip_exec"
fi
echo

color="--color=auto"
alias ll='ls $color -Flha'
alias ll0='ls $color -Flh'
export PS1='\[\e[1;32m\][$(__git_ps1)\h \w]\n\$ \[\e[0m\]'


scripts=$HOME/Downloads/scripts
[ $1 ] && scripts=$1
if [ ! -d $scripts ] 
then
    echo "scripts dir not found. Exits early." 
    exit
fi

export PATH=$PATH:$scripts

source $scripts/git-prompt.sh
git config -f $scripts/.gitconfig

alias ssh="ssh -F $scripts/sshconfig"
alias vim="MYVIMRC=$scripts/.vimrc vim -u $scripts/.vimrc"


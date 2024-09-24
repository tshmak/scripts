cd $HOME
[ -L ttsnas ] && rm ttsnas
ln -s /mnt/ttsnas
cd - 

cd $HOME
if [[ $(hostname) =~ ^Fano-SZ ]]; then # Fano ShenZhen server 
    # /home/tshmak is already on ssd
    [ -L localnas ] && rm localnas
    ln -s /mnt/Research localnas
elif [[ $(hostname) =~ ^HK ]]; then # Fano HK server 
    [ -L ssd ] && rm ssd
    ln -s /mnt/ssd/tshmak ssd
    [ -L localnas ] && rm localnas
    ln -s /mnt/ttsnas localnas
fi
cd - 

cd $HOME
[ -L storage ] && rm storage
ln -s localnas/tshmak storage
cd - 

cd $HOME
[ -L scripts ] && rm scripts
ln -s /mnt/ttsnas/tshmak/scripts # Script will point to HK ttsnas even in SZ, because SZ have no access to github
cd - 

cd $HOME
for i in storage/WORK storage/DATA storage/sandbox storage/Downloads storage/local storage/Dropbox
do 
    b=$(basename $i)
    [ -L $b ] && rm $(basename $i)
    ln -s $i
done
cd - 

cd $HOME/local
ln -s /usr/bin
cd - 

cd $HOME
for i in scripts/.gitconfig scripts/.vimrc scripts/.bashrc scripts/.bash_profile scripts/.Rprofile scripts/.condarc scripts/.tmux.conf scripts/.ducrc
do 
    b=$(basename $i)
    [ -L $b ] && rm $(basename $i)
    ln -s $i
done
cd - 

mkdir -p $HOME/.ssh
cd $HOME/.ssh
[ -L config ] && rm config
ln -s $HOME/scripts/sshconfig config
[ -L authorized_keys ] && rm authorized_keys
cp $HOME/scripts/authorized_keys .
cd - 

mkdir -p $HOME/.config
cd $HOME/.config
[ -L rclone ] && rm rclone
ln -s $HOME/scripts/rclone 
cd - 


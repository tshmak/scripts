if [ "$HOME" != "/home/tshmak" ] 
then 
    echo "\$HOME is not /home/tshmak. Terminating."
fi

cd $HOME
[ -L nas2 ] && rm nas2
ln -s /mnt/nas2
cd - 

cd $HOME
[ -L storage ] && rm storage
ln -s nas2/tshmak storage
cd - 

cd $HOME
for i in storage/scripts storage/sandbox storage/WORK storage/Downloads storage/DATA storage/local storage/Dropbox
do 
    b=$(basename $i)
    [ -L $b ] && rm $(basename $i)
    ln -s $i
done
cd - 

cd $HOME
for i in scripts/.gitconfig scripts/.vimrc scripts/.bashrc scripts/.bash_profile scripts/.Rprofile scripts/.condarc 
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
cd - 

mkdir -p $HOME/.config
cd $HOME/.config
[ -L rclone ] && rm rclone
ln -s $HOME/scripts/rclone 
cd - 


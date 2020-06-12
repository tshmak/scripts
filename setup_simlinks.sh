cd $HOME
[ -L nas2 ] && rm nas2
ln -s /mnt/nas2
cd - 

cd $HOME
[ -L storage ] && rm storage
ln -s nas2/tshmak storage
cd - 

cd $HOME
for i in storage/scripts storage/sandbox storage/WORK storage/Downloads scripts/.gitconfig storage/DATA storage/local scripts/.vimrc scripts/.bashrc scripts/.bash_profile scripts/.Rprofile scripts/.condarc
do 
    b=$(basename $i)
    [ -L $b ] && rm $(basename $i)
    ln -s $i
done
cd - 

cd $HOME/.ssh
[ -L config ] && rm config
ln -s $HOME/scripts/sshconfig config
cd - 

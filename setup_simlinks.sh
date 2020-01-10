cd $HOME
for i in /mnt/nas2 nas2/tshmak storage/scripts storage/sandbox storage/WORK storage/Downloads scripts/.gitconfig storage/DATA storage/local scripts/.vimrc scripts/.bashrc scripts/.bash_profile scripts/.Rprofile
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

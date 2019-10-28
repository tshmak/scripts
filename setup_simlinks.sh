cd $HOME
ln -sf /mnt/nas2 nas2
ln -sf nas2/tshmak storage
ln -sf storage/scripts scripts
ln -sf storage/sandbox sandbox
ln -sf storage/WORK WORK
ln -sf storage/Downloads Downloads
ln -sf scripts/.gitconfig .gitconfig
ln -sf storage/DATA DATA
ln -sf storage/local local
ln -sf scripts/.vimrc .vimrc
ln -sf scripts/.bashrc .bashrc
ln -sf scripts/.bash_profile .bash_profile
cd - 

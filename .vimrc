filetype plugin indent on
syntax on
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>

" From https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab


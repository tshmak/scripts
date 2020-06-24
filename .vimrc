filetype plugin indent on
syntax on
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>
map gc :s/^\(\s*\)/\1#/<CR>
map cg :s/^\(\s*\)#/\1/<CR>

" From https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
filetype plugin indent on
set tabstop=4
set shiftwidth=2
set expandtab

" From https://github.com/ConradIrwin/vim-bracketed-paste/blob/master/plugin/bracketed-paste.vim
" For automatically starting paste mode when pasting
if exists("g:loaded_bracketed_paste")
  finish
endif
let g:loaded_bracketed_paste = 1

let &t_ti .= "\<Esc>[?2004h"
let &t_te = "\e[?2004l" . &t_te

function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>

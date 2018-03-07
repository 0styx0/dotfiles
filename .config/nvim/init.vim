" use vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" if python is not installed, run `pacman -S python-pip`, `pip install
" neovim`, and `:UpdateRemotePlugins` (source:
" https://stackoverflow.com/a/41780680)

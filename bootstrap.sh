# install vundle itself (needed so vundle can install other plugins)
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# link dotfiles
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

# create vim swapfile targets
mkdir ~/.vimbackup
mkdir ~/.vimswap

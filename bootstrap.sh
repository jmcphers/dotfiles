# set up git identity
git config --global user.email "jonathan@rstudio.com"
git config --global user.name "Jonathan McPherson"

# install vundle itself (needed so vundle can install other plugins)
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install vim color schemes (vundle has a hard time with this)
git clone https://github.com/flazz/vim-colorschemes.git ~/.vim/vim-colorschemes
mv ~/.vim/vim-colorschemes/colors ~/.vim/colors
rm -rf ~/.vim/vim-colorschemes

# use vim color schemes for neovim
mkdir -p ~/.nvim
ln -s ~/.vim/colors ~/.nvim/colors

# link dotfiles
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

# create vim swapfile targets
mkdir -p ~/.vimbackup
mkdir -p ~/.vimswap

# set up git identity
git config --global user.email "jonathan@rstudio.com"
git config --global user.name "Jonathan McPherson"

VIMRT=~/.vim
VIMRC=~/.vimrc
if [[ "$OSTYPE" == "msys" ]]; then
    VIMRT=~/vimfiles
    VIMRC=~/_vimrc
fi

# install vundle itself (needed so vundle can install other plugins)
git clone https://github.com/gmarik/Vundle.vim.git $VIMRT/bundle/Vundle.vim

# install vim color schemes (vundle has a hard time with this)
git clone https://github.com/flazz/vim-colorschemes.git $VIMRT/vim-colorschemes
mv $VIMRT/vim-colorschemes/colors $VIMRT/colors
rm -rf $VIMRT/vim-colorschemes

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# use vim color schemes for neovim
mkdir -p ~/.nvim
ln -s $VIMRT/colors ~/.nvim/colors

# link dotfiles
ln -s ~/dotfiles/.vimrc $VIMRC
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.todo.cfg ~/.todo.cfg
ln -s ~/dotfiles/UltiSnips ~/.vim/UltiSnips
ln -s ~/dotfiles/.muttrc ~/.muttrc

# create vim swapfile targets
mkdir -p ~/.vimbackup
mkdir -p ~/.vimswap

#!/usr/bin/env bash

# set up git identity
git config --global user.email "jonathan@rstudio.com"
git config --global user.name "Jonathan McPherson"

VIMRT=~/.vim
VIMRC=~/.vimrc
if [[ "$OSTYPE" == "msys" ]]; then
    VIMRT=~/vimfiles
    VIMRC=~/_vimrc

    # install vim-plug for neovim
    mkdir -p ~/AppData/Local/nvim/autoload
    curl -o ~/AppData/Local/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install vim-plug
curl -fLo $VIMRT/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if [[ "$OSTYPE" == "msys" ]]; then
    # use same vimrc for neovim and regular vim
    ln -s ~/dotfiles/vim/.vimrc $VIMRC
    ln -s ~/dotfiles/init-windows.vim ~/AppData/Local/nvim/init.vim
else
    # use stow to set up symlinks
    stow neovim
    stow todo.txt
    stow tmux
    stow zsh
    stow mutt
    stow vim
fi

# create vim swapfile targets -- this keeps directories tidy
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undo

# make "git gtags" work
git config --global alias.gtags '!.git/hooks/gtags'

# set up git template folder and init with gtags
GIT_TEMPLATE="~/.config/git/template"
mkdir -p $GIT_TEMPLATE/hooks
git config --global init.templatedir "$GIT_TEMPLATE"
~/dotfiles/bin/setup-git-gtags $GIT_TEMPLATE



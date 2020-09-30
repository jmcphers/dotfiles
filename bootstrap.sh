#!/usr/bin/env bash

# figure out where we live
DOTFILES="$(dirname ${BASH_SOURCE[0]})"

# set up git identity
git config --global user.email "jonathan@rstudio.com"
git config --global user.name "Jonathan McPherson"

# ensure we have curl
if ! command -v curl &> /dev/null; then
    echo "This script requires the curl. Install curl and re-run."
    exit 1
fi

if [[ "$OSTYPE" != "msys" ]]; then
    if ! command -v stow &> /dev/null; then
        echo "This script requires stow. Install stow and re-run"
        exit 1
    fi
fi

VIMRT=~/.vim
VIMRC=~/.vimrc
if [[ "$OSTYPE" == "msys" ]]; then
    VIMRT=~/vimfiles
    VIMRC=~/_vimrc

    # install vim-plug for neovim
    if [ ! -d ~/AppData/Local/nvim/autoload ]; then
       mkdir -p ~/AppData/Local/nvim/autoload
       curl -o ~/AppData/Local/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
else
    # install vim-plug for neovim
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install vim-plug for standard vim
if [ ! -d $VIMRT/autoload/plug.vim ]; then 
    curl -fLo $VIMRT/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install tmux plugin manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [[ "$OSTYPE" == "msys" ]]; then
    NEOVIMRC=~/AppData/Local/nvim
    mkdir -p "$NEOVIMRC"
    cp "$DOTFILES/vim/.vimrc" "$VIMRC" 
    cp "$DOTFILES/init-windows.vim" "$NEOVIMRC/init.vim" 
else
    # setup zpretzo
    if [ ! -d ~/.zprezto ]; then
        git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    fi
    # use stow to set up symlinks
    stow --stow neovim --target=$HOME
    stow --stow todo.txt --target=$HOME
    stow --stow tmux --target=$HOME
    stow --stow zsh --target=$HOME
    stow --stow mutt --target=$HOME
    stow --stow vim --target=$HOME
    stow --stow vrapper --target=$HOME
fi

# create vim swapfile targets -- this keeps directories tidy
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undo

# setup vim with ctags (not available on windows)
if [[ "$OSTYPE" != "msys" ]]; then
    # make "git ctags" work
    git config --global alias.ctags '!.git/hooks/ctags'

    # set up git template folder and init with gtags
    GIT_TEMPLATE="$HOME/.config/git/template"
    mkdir -p $GIT_TEMPLATE/hooks
    git config --global init.templatedir "$GIT_TEMPLATE"
    $DOTFILES bin/setup-git-ctags $GIT_TEMPLATE
fi



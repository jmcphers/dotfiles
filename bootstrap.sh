# set up git identity
git config --global user.email "jonathan@rstudio.com"
git config --global user.name "Jonathan McPherson"

VIMRT=~/.vim
VIMRC=~/.vimrc
if [[ "$OSTYPE" == "msys" ]]; then
    VIMRT=~/vimfiles
    VIMRC=~/_vimrc
fi

# install vim-plug
curl -fLo $VIMRT/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# link dotfiles
ln -s ~/dotfiles/.vimrc $VIMRC
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.todo.cfg ~/.todo.cfg
ln -s ~/dotfiles/UltiSnips ~/.vim/UltiSnips
ln -s ~/dotfiles/.muttrc ~/.muttrc
ln -s ~/dotfiles/.tmuxinator ~/.tmuxinator

# use same vimrc for neovim and regular vim (TODO: this is unix-only)
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/.vimrc ~/.config/nvim/init.vim

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



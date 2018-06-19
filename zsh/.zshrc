# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# for zippy path navigation!
alias z='fasd_cd'

# add fuzzy findler zsh extensions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# added by travis gem
[ -f /Users/jmcphers/.travis/travis.sh ] && source /Users/jmcphers/.travis/travis.sh

# add tmuxinator
source ~/.bin/tmuxinator.zsh

# common env vars
if [ -x "$(command -v nvim)" ]; then 
    # use nvim if available
    export VISUAL=nvim
    export EDITOR=nvim
else
    # and vim otherwise
    export VISUAL=vim
    export EDITOR=vim
fi
export PATH=$PATH:~/bin:~/dotfiles/bin
export GOPATH=~


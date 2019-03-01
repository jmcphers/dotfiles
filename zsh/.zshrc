# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# for zippy path navigation!
alias z='fasd_cd'

# add fuzzy findler zsh extensions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# add tmuxinator
[ -f ~/.bin/tmuxinator.zsh ] && source ~/.bin/tmuxinator.zsh

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
export PATH=$PATH:/usr/local/sbin:~/bin:~/dotfiles/bin
export GOPATH=~

# python runtime (MacOS)
[ -d ~/Library/Python/2.7/bin ] && export PATH=$PATH:~/Library/Python/2.7/bin

[ -d ~/.gem/ruby/2.3.0/bin ] && export PATH=$PATH:~/.gem/ruby/2.3.0/bin

# add linuxbrew
[ -d /home/linuxbrew/.linuxbrew/bin ] && export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin


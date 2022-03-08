# install homebrew zsh completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# for zippy path navigation!
alias z='fasd_cd'

# add fuzzy findler zsh extensions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/local/var/homebrew/linked/fzf/shell/completion.zsh ] && source /usr/local/var/homebrew/linked/fzf/shell/completion.zsh
[ -f /usr/local/var/homebrew/linked/fzf/shell/key-bindings.zsh ] && source /usr/local/var/homebrew/linked/fzf/shell/key-bindings.zsh


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

# amend PATH with dotfiles and local bin folder
export PATH=$PATH:/usr/local/sbin:~/bin:~/dotfiles/bin

# use home directory as root for Go code
export GOPATH=~

# python runtime (MacOS)
[ -d ~/Library/Python/2.7/bin ] && export PATH=$PATH:~/Library/Python/2.7/bin

[ -d ~/.gem/ruby/2.3.0/bin ] && export PATH=$PATH:~/.gem/ruby/2.3.0/bin

# R runtime (MacOS)

[ -d /Library/Frameworks/R.framework/Versions/Current/Resources ] && export PATH=$PATH:/Library/Frameworks/R.framework/Versions/Current/Resources 

# add linuxbrew
[ -d /home/linuxbrew/.linuxbrew/bin ] && export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


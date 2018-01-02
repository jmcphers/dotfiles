# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# for zippy path navigation!
alias z='fasd_cd'

# ensure gpg agent is running
if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi

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
export PATH=$PATH:~/bin
export GOPATH=~


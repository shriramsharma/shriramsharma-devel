export PATH=/usr/local/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export FZF_TMUX=1
export FZF_TMUX_HEIGHT='40'

export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME/Shriram"

if [[ "$OSTYPE" == "darwin"* ]]; then
   export GOPATH=$HOME/go
else
   export GOPATH=/usr/local/go
fi

SHELL_SESSION_HISTORY=0

#. /usr/local/etc/profile.d/bash_completion.sh
# . $HOME/.git-completion.bash
# . /etc/bash_completion.d

HISTFILESIZE=10000

alias tmux="TERM=xterm-256color tmux"

complete -o default -o nospace -F _git_checkout gco
complete -o default -o nospace -F _git_branch gb

if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -f $HOME/.alias ]; then
  . $HOME/.alias
fi

if [ -d $HOME/bin ]; then
  export PATH=$HOME/bin:$PATH
fi

function ck(){
  git checkout "$@";
}


function _update_ps1() {
	    PS1="$($GOPATH/bin/powerline-go -error $?)"
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

export NVM_DIR="/Users/sshar47/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#/usr/local/etc/profile.d/bash_completion.sh
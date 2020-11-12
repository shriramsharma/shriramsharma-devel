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


#if [ $TERM = 'dumb' ]; then
#    PS1='$ '
#else
#    PROMPT_COMMAND=setprompt
#fi

## The below code was yanked from http://pascal.nextrem.ch/2010/04/30/automatically-start-screen-on-ssh-login

# Auto-screen invocation. see: http://taint.org/wk/RemoteLoginAutoScreen
# if we're coming from a remote SSH connection, in an interactive session
# then automatically put us into a screen(1) session.   Only try once
# -- if $STARTED_SCREEN is set, don't try it again, to avoid looping
# if screen fails for some reason.
#if [ "$PS1" != "" -a "${STARTED_SCREEN:-x}" = x ]
#then
#  STARTED_SCREEN=1 ; export STARTED_SCREEN
#  [ -d $HOME/lib/screen-logs ] || mkdir -p $HOME/lib/screen-logs
#  sleep 1
#  screen -RR S && exit 0
#  # normally, execution of this rc script ends here...
#  echo "Screen failed! continuing with normal bash startup"
#fi
# [end of auto-screen snippet]

export NVM_DIR="/Users/sshar47/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#/usr/local/etc/profile.d/bash_completion.sh

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/Users/sshar47/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/sshar47/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '/Users/sshar47/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/sshar47/Downloads/google-cloud-sdk/completion.bash.inc'; fi

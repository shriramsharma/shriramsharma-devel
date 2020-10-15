export PATH=/usr/local/bin:$PATH
#export JAVA_HOME=$(/usr/libexec/java_home -v '1.8*')
export M2_HOME=/Users/sshar47/Shriram/apache-maven-3.2.3
export M2=$M2_HOME/bin
export NOTIPATH=/Users/sshar47/Shriram/Scratch/noti
export NOTI_PB=o.XzgTgFasDEsMU76wfdYR32mznIzrUM0L
export GOPATH=$HOME/Shriram/go
#export GOROOT_BOOTSTRAP=$(go env GOROOT)
export ANTHOME=/Users/sshar47/Shriram/Downloads/apache-ant-1.9.7
export SCALA_HOME=/Users/sshar47/Shriram/Downloads/scala-2.10.4
export DEPOT_TOOLS_HOME=/Users/sshar47/Shriram/udemy/javascript/depot_tools
export MY_SCRIPTS=/Users/sshar47/Shriram/scripts
export MARKDOWN_TOC_PATH=/Users/sshar47/Shriram/github/markdown-toc/node_modules
export FLUTTER=/Users/sshar47/Shriram/github/flutter
export PATH=$SCALA_HOME/bin:$JAVA_HOME/bin:$M2:$NOTIPATH:$ANTHOME/bin:$DEPOT_TOOLS_HOME:$MY_SCRIPTS:$HOME/Shriram/go1.13/bin:$PATH:$GOPATH/bin:$MARKDOWN_TOC_PATH:$FLUTTER/bin
export FZF_TMUX=1
export FZF_TMUX_HEIGHT='40'

export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME/Shriram"


SHELL_SESSION_HISTORY=0

#. /usr/local/etc/profile.d/bash_completion.sh
. $HOME/.git-completion.bash
. /etc/bash_completion.d

HISTFILESIZE=10000


alias screen="/usr/local/bin/screen"
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

# next three ganked from <http://muness.blogspot.com/2008/06/stop-presses-bash-said-to-embrace.html>
sub_dir() {
    local sub_dir
    sub_dir=$(stat --printf="%n" "${PWD}")
    sub_dir=${sub_dir#$1}
    echo ${sub_dir#/}
}

git_dir() {
    ref=''
    base_dir=$(git rev-parse --show-cdup 2>/dev/null) || return 1
    if [ -n "$base_dir" ]; then
	base_dir=`cd $base_dir; pwd`
    else
	base_dir=$PWD
    fi
    sub_dir=$(git rev-parse --show-prefix)
    sub_dir="/${sub_dir%/}"
    ref=$(git symbolic-ref -q HEAD) || ref=$(\[\e[0;31m\]\h\[\e[m\]; echo -n 'DETACHED! ' ; \[\e[1;37m\]\h;  git name-rev --name-only HEAD 2>/dev/null )
    ref=${ref#refs/heads/}
    vcs="git"
    alias cleanup="git fsck && git gc"
    alias commit="git commit -s"
    alias dc="d --cached"
    alias l="git log"
    alias lp="l -p"
    alias lss="l --stat --summary"
    alias newbranch="git checkout -b"
    alias pull="git pull"
    alias push="commit ; git push"
    alias revert="git checkout"
    alias status="git status"
    alias fetch="git fetch"
    alias rb="git branch -r"
    alias db="git branch -D"
    alias br="git branch"
}

setprompt() {
  local load etc vcs base_dir sub_dir ref last_command

  P1="\e[0;37m\]\T\e[m\]"
  P2="\e[0;36m\]\h\e[m\]"

  if [ -e /proc/loadavg ]; then
      load=( $(</proc/loadavg) )
  else
      load=""
  fi

  P3=""
  if [ $load ]; then
      if [ ${load%.*} -ge 2 ]; then
	  P3="\[\e[0;31m\] \[\e[1;37m\]$load[\e[m\]"
      else
	  P3="\[\e[1;34m\]$load[\e[m\]"
      fi
  fi

  #P4="-\e[0;31m\]\$?\e[m\]-"

  # this next bit also ganked from http://muness.blogspot.com/2008/06/stop-presses-bash-said-to-embrace.html
  git_dir

  P5=""

  if [ -n "$vcs" ]; then
      alias st="$vcs status"
      alias d="$vcs diff"
      alias up="pull"
      alias cdb="cd $base_dir"
      base_dir="$(basename "${base_dir}")"
      working_on="$base_dir:"
      __vcs_ref="[$ref]"
      __vcs_sub_dir="${sub_dir}"
      P5="\e[1;33m\]$__vcs_ref\e[m\]"
  fi
  P6="\e[0;35m\]\w\e[m\]"

  P7="[Screen: $WINDOW]"


  PS1="\n$P1 $P2 [$P6] $P4\n$P5 $P7 \$ "
}

function _update_ps1() {
	    PS1="$($GOPATH/bin/powerline-go -error $?)"
}

if [ "$TERM" != "linux" ]; then
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

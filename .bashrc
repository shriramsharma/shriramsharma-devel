. $HOME/.git-completion.bash

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

function modver() {
 perl -M"$@" -e 'print $'$@'::VERSION';
}

function tm() {
 TEST_METHOD="$@" prove -lv;
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

svn_dir() {
    [ -d ".svn" ] || return 1
    base_dir="."
    while [ -d "$base_dir/../.svn" ]; do base_dir="$base_dir/.."; done
    base_dir=`cd $base_dir; pwd`
    sub_dir="/$(sub_dir "${base_dir}")"
    ref=$(svn info "$base_dir" | awk '/^URL/ { sub(".*/","",$0); r=$0 } /^Revision/ { sub("[^0-9]*","",$0); print r":"$0 }')
    vcs="svn"
    alias pull="svn up"
    alias commit="svn commit"
    alias push="svn ci"
    alias revert="svn revert"
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
  git_dir || svn_dir

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

if [ $TERM = 'dumb' ]; then
    PS1='$ '
else
    PROMPT_COMMAND=setprompt
fi

## The below code was yanked from http://pascal.nextrem.ch/2010/04/30/automatically-start-screen-on-ssh-login

# Auto-screen invocation. see: http://taint.org/wk/RemoteLoginAutoScreen
# if we're coming from a remote SSH connection, in an interactive session
# then automatically put us into a screen(1) session.   Only try once
# -- if $STARTED_SCREEN is set, don't try it again, to avoid looping
# if screen fails for some reason.
if [ "$PS1" != "" -a "${STARTED_SCREEN:-x}" = x ]
then
  STARTED_SCREEN=1 ; export STARTED_SCREEN
  [ -d $HOME/lib/screen-logs ] || mkdir -p $HOME/lib/screen-logs
  sleep 1
  screen -RR S && exit 0
  # normally, execution of this rc script ends here...
  echo "Screen failed! continuing with normal bash startup"
fi
# [end of auto-screen snippet]


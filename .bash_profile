#!/bin/bash -x
##########################################
function parse_git_branch {
      ref=$(git symbolic-ref HEAD 2> /dev/null) || return
      echo "("${ref#refs/heads/}")"
}


export PATH="/usr/local/mysql/bin:/usr/local/bin:$PATH:~:~/bin"

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

if [ -f ~/.bash_colours ]; then
  . ~/.bash_colours
fi

export PS1="[${WHITE}cool:${LIGHT_BLUE}\w${LIGHT_GREEN} \$(parse_git_branch)${WHITE}]"

export LSCOLORS="cxfxcxdxbxegedabagacad"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

##
# Your previous /Users/ramon/.bash_profile file was backed up as /Users/ramon/.bash_profile.macports-saved_2010-12-16_at_14:38:55
##

# MacPorts Installer addition on 2010-12-16_at_14:38:55: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

export HISTCONTROL=ignoredups

bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

export EDITOR=vim

#ruby gc settings
export RUBY_HEAP_MIN_SLOTS=500000
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=50000000

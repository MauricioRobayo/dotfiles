# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -s "$HOME/.git-prompt.sh" ] && . "$HOME/.git-prompt.sh"
[ -s "$HOME/.git-completion.bash" ] && . "$HOME/.git-completion.bash"
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_DESCRIBE_STYLE="default"
GIT_PS1_HIDE_IF_PWD_IGNORED=1
__prompt_command() {
    local EXIT="$?"
    local ps1_pre=
    local ps1_post=

    if [ $EXIT -eq 0 ]; then
      __git_ps1 '[\W]' '\$ ' '(%s)'
    else
      __git_ps1 '\[\033[1;31m\]E!\[\033[0m\][\W]' '\$ ' '(%s)'
    fi
}
PROMPT_COMMAND="__prompt_command"

export EDITOR=vim

eval "$(direnv hook bash)"

# fnm
export PATH=/home/rfmaj/.fnm:$PATH
eval "`fnm env`"

export PATH="/tmp/fnm_multishell_4740_1605492491387/bin":$PATH
export FNM_MULTISHELL_PATH="/tmp/fnm_multishell_4740_1605492491387"
export FNM_DIR="/home/rfmaj/.fnm"
export FNM_LOGLEVEL="info"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
__fnm_use_if_file_found() {
    if [[ -f .node-version || -f .nvmrc ]]; then
        fnm use
    fi
}

__fnmcd() {
    \cd "$@" || return $?
    __fnm_use_if_file_found
}

alias cd=__fnmcd
__fnm_use_if_file_found

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/rfmaj/google-cloud-sdk/path.bash.inc' ]; then . '/home/rfmaj/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/rfmaj/google-cloud-sdk/completion.bash.inc' ]; then . '/home/rfmaj/google-cloud-sdk/completion.bash.inc'; fi

eval "$(zoxide init bash)"

source /usr/share/doc/fzf/examples/completion.bash
source /usr/share/doc/fzf/examples/key-bindings.bash
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fdfind --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

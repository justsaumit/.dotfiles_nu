## ~/.bashrc
#
#| |__   __ _ ___| |__  _ __ ___
#| '_ \ / _` / __| '_ \| '__/ __|
#| |_) | (_| \__ \ | | | | | (__
#|_.__/ \__,_|___/_| |_|_|  \___|
#


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#neofetch small
pfetch

#ble.sh bash w vi-mode and auto-completion
##[[ $- == *i* ]] && source $HOME/.local/src/blesh/ble.sh --noattach

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

export TERM="xterm-256color"
export EDITOR="nvim"
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

#export PS1="[\u@\h ~]\\$\[$(tput sgr0)\]"

#susexport PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 6)\]\u\[$(tput setaf 1)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# Shell options
#vi mode in bash (uncomment after expertise)
set -o vi
#Ctrl+D EOF Disable
set -o ignoreeof
shopt -s autocd
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s extglob
#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

#envpaths
export PATH="$PATH:$HOME/.scripts"
# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$HOME/.local/bin"
export SUDO_ASKPASS="$HOME/.local/bin/tofi-askpass"
#cuda
export PATH=/opt/cuda/bin:$PATH
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH

# Permanent history ignore dupes
export HISTCONTROL=ignoredups:erasedups
#infinite history
export HISTFILESIZE=
export HISTSIZE=
#timecodes in bash history :))
#HISTTIMEFORMAT="%d/%m/%y %T "
export HISTTIMEFORMAT="[%F %T] "

#XDG
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export TERMINFO="$XDG_DATA_HOME/terminfo"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export HISTFILE="${XDG_STATE_HOME}/bash/history"
export GRIM_DEFAULT_DIR="$HOME/pix/Screenshots"

# Load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
# Load shortcut
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"

#partially supported XDG Base Directory
[ -f "$HOME/.config/env" ] && source "$HOME/.config/env"

#[[ ${BLE_VERSION-} ]] && ble-attach

#export N_PREFIX="$HOME/.local/usr/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

osc7_cwd() {
    local strlen=${#PWD}
    local encoded=""
    local pos c o
    for (( pos=0; pos<strlen; pos++ )); do
        c=${PWD:$pos:1}
        case "$c" in
            [-/:_.!\'\(\)~[:alnum:]] ) o="${c}" ;;
            * ) printf -v o '%%%02X' "'${c}" ;;
        esac
        encoded+="${o}"
    done
    printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "${encoded}"
}
PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }osc7_cwd


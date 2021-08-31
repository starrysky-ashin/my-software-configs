#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Maintainer: jinxin.ashin@outlook.com
#
# Sections:
#   -> General
#   -> Plugins
#   -> User interface
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


#**********************************************************#
# => General
# zsh path 
export ZSH=$HOME/.oh-my-zsh

# theme
ZSH_THEME="agnoster"

# disable auto title
DISABLE_AUTO_TITLE=true

# bindkey
bindkey \^U backward-kill-line
bindkey '^v' edit-command-line

# modern completion
autoload -Uz compinit && compinit -u

# alias
alias sz="source ~/.zshrc"
alias smi='nvidia-smi'
alias ctags="ctags -f .tags -R *"
alias tn='tmux new-session -s'
alias ta='tmux a -t'
alias tl='tmux ls'


#**********************************************************#
# => Plugins
plugins=(git)


#**********************************************************#
# => User interface
# prompt
# keep the prompt as concise as possible by removing both user and host names.
prompt_context() {
    if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        # use user@host as prompt
        # prompt_segment black default "%(!.%{%F{yellow}%}.)$USER@$HOST"
        
        # only use user name as prompt
        # prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
         
        # only use host name as prompt
        # prompt_segment black default "%(!.%{%F{yellow}%}.)$HOST"
    fi
}

# colors
# set dircolor by the .dircolors file
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        alias dir='dir --color=auto'
        alias vdir='vdir --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
fi

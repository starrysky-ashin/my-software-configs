#"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
# Maintainer: jinxin.ashin@outlook.com
#
# Sections:
#   -> Usage
#   -> General
#   -> Theme
#   -> Plugins
#   -> User interface
#   -> Software configt config
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


#**********************************************************#
# => Usage
# Copy the following cmd (source this rc file) to ~/.zshrc

# export default_zshrc=/path/to/this/file
# [ -f $default_zshrc ] && source $default_zshrc


#**********************************************************#
# => General
# ZSH path related
export ZSH=$HOME/.oh-my-zsh
[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh

# Disable auto title
DISABLE_AUTO_TITLE=true

# Bindkey
bindkey \^U backward-kill-line
bindkey '^v' edit-command-line

# Env alias
alias sz="source ~/.zshrc"
alias smi='nvidia-smi'


#**********************************************************#
# => Theme
ZSH_THEME="agnoster"


#**********************************************************#
# => Plugins
plugins=(git)


#**********************************************************#
# => User interface
# Prompt
# We keep the prompt as concise as possible by removing both user and host names.
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

# Colors
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


#**********************************************************#
# => Software configs
# tmux
alias tn='tmux new-session -s'
alias ta='tmux a -t'
alias tl='tmux ls'

# autojump
[ -f /usr/share/autojump/autojump.sh ] && . /usr/share/autojump/autojump.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

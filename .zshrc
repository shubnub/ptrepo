# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#export ZSH_THEME="pt"
#export ZSH_THEME="obraun"
export ZSH_THEME="agnoster"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
#DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Customize to your needs...
export PATH=/Users/pete/bin:/Users/pete/work-bin:/opt/brew/bin:/opt/local/bin:/opt/brew/sbin:/opt/local/sbin:/opt/X11/bin:/usr/local/bin:/usr/local/MacGPG2/bin:/usr/bin:/usr/sbin:/bin:/sbin:/opt/local/lib/postgresql96/bin:$HOME/Library/Python/2.7/bin

#export ZSH_TMUX_AUTOSTART=false
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOQUIT=false
export ZSH_TMUX_FIXTERM=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    git
    tmux
    colored-man-pages
    colorize
    jira
    themes
    docker
)
# Info on some of the above plugins
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/jira
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/themes
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker
#

source $ZSH/oh-my-zsh.sh

#export REQUESTS_CA_BUNDLE=/Users/pete/arin-int-ca.crt

export MANPATH=/Applications/Wireshark.app/Contents/Resources/share/man:/Library/Developer/CommandLineTools/usr/share/man:/opt/brew/manpages:/opt/local/share/man:/usr/local/share/man:/usr/share/man:/Users/pete/man

# The following three are provided by the tmux plugin.
#alias tl='tmux list-sessions'
#alias tn='tmux new -s'
#alias tks='tmux kill-session -t'
alias tnd='tmux new -d -s'
alias tm='tmuxifier'
alias tml='tmuxifier list'
alias tmw='tmuxifier load-window'
alias tmew='tmuxifier edit-window'
alias tmnw='tmuxifier new-window'
alias tmls='tmuxifier list-sessions'
alias tms='tmuxifier load-session'
alias tmes='tmuxifier edit-session'
alias tmns='tmuxifier new-session'
export EDITOR=vim
export TMUXIFIER="$HOME/git/tmuxifier"
export TMUXIFIER_LAYOUT_PATH="$HOME/.tmuxifier-layouts"
export HISTTIMEFORMAT="%Y-%m-%d %T "
export LANG=en_US.UTF-8

#source ~/.bin/tmuxinator.zsh
source ~/.iterm2_shell_integration.zsh
source ~/git/zsh-hist/zsh-hist.plugin.zsh # https://github.com/marlonrichert/zsh-hist

eval "$(tmuxifier init -)"

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

# disable autocorrect
unsetopt correct_all

export LESS='-R -X'

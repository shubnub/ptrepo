#. /sw/bin/init.sh
export PATH=/opt/local/bin:$HOME/work-bin:$HOME/bin:/usr/local/bin:$PATH
#export MANPATH=/opt/local/man:$MANPATH
#export VISUAL=gvim
export EDITOR=vim
export LSCOLORS="Cxfxcxdxbxegedabagacad"

case $TERM in
   xterm*)
#      local TITLEBAR='\[\033]0;\u@\h:\w\007\]\033k\w\033\\'
      TITLEBAR='\[\033]0;\u@\h:\w\007\]'
   ;;
   *)
      TITLEBAR=''
   ;;
esac

# set up tab completion for ssh hosts
#complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh

#export PS1="${TITLEBAR}\
#[\u@\h:\w]\
#\$ "
export PS1="${TITLEBAR}\
### \u@\h \t [\w]\n\$ "
export PS2='> '
export PS4='+ '

alias ls='ls -FA'
alias s=sudo

# set up tab completion for ssh hosts
_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh


##
# Your previous /Users/pete/.bash_profile file was backed up as /Users/pete/.bash_profile.macports-saved_2011-02-26_at_17:43:49
##

# MacPorts Installer addition on 2011-02-26_at_17:43:49: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


##
# Your previous /Users/pete/.bash_profile file was backed up as /Users/pete/.bash_profile.macports-saved_2011-07-26_at_00:51:59
##

# MacPorts Installer addition on 2011-07-26_at_00:51:59: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

_width () {
    echo $COLUMNS
}

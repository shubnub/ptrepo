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

#export PS1="${TITLEBAR}\
#### \u@\h \t [\w]\n\$ "
#export PS2='> '
#export PS4='+ '

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
# Your previous /Users/pete/.bash_profile file was backed up as /Users/pete/.bash_profile.macports-saved_2011-07-26_at_00:51:59
##

# MacPorts Installer addition on 2011-07-26_at_00:51:59: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

hostnam=$(hostname -s)
usernam=$(whoami)
temp="$(tty)"
#   Chop off the first five chars of tty (ie /dev/):
cur_tty="${temp:5}"
unset temp

function prompt_command {

    #   Find the width of the prompt:
    TERMWIDTH=${COLUMNS}

    #   Add all the accessories below ...
    local temp="--(${usernam}@${hostnam}:${cur_tty})---(${PWD})--"

    let fillsize=${TERMWIDTH}-${#temp}
    if [ "$fillsize" -gt "0" ]
    then
        fill="-------------------------------------------------------------------------------------------------------------------------------------------"
        #   It's theoretically possible someone could need more 
        #   dashes than above, but very unlikely!  HOWTO users, 
        #   the above should be ONE LINE, it may not cut and
        #   paste properly
        fill="${fill:0:${fillsize}}"
        newPWD="${PWD}"
    fi

    if [ "$fillsize" -lt "0" ]
    then
        fill=""
        let cut=3-${fillsize}
        newPWD="...${PWD:${cut}}"
    fi
}

PROMPT_COMMAND=prompt_command

WHITE="\[\033[1;37m\]"
NO_COLOUR="\[\033[0m\]"

LIGHT_BLUE="\[\033[1;34m\]"
YELLOW="\[\033[1;33m\]"

case $TERM in
    xterm*|rxvt*)
        TITLEBAR='\[\033]0;\u@\h:\w\007\]'
        ;;
    *)
        TITLEBAR=""
        ;;
esac
    
PS1="$TITLEBAR\
$YELLOW-$LIGHT_BLUE-(\
$YELLOW\$usernam$LIGHT_BLUE@$YELLOW\$hostnam$LIGHT_BLUE:$WHITE\$cur_tty\
${LIGHT_BLUE})-${YELLOW}-\${fill}${LIGHT_BLUE}-(\
$YELLOW\${newPWD}\
$LIGHT_BLUE)-$YELLOW-\
\n\
$YELLOW-$LIGHT_BLUE-(\
$YELLOW\$(date +%H%M)$LIGHT_BLUE:$YELLOW\$(date \"+%a,%d %b %y\")\
$LIGHT_BLUE:$WHITE\$$LIGHT_BLUE)-\
$YELLOW-\
$NO_COLOUR " 
    
PS2="$LIGHT_BLUE-$YELLOW-$YELLOW-$NO_COLOUR "
